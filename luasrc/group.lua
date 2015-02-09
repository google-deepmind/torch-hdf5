local torch = require 'torch'
local stringx = require 'pl.stringx'
local ffi = require 'ffi'

local HDF5Group = torch.class("hdf5.HDF5Group")

--[[ Convert from LongStorage containing tensor sizes to an HDF5 hsize_t array ]]

local function convertSize(size)
    local nDims

    if type(size) == 'table' then
      nDims = #size
    else
      nDims = size:size()
    end
 
    local size_t = hdf5.ffi.typeof("hsize_t[" .. nDims .. "]")
    local hdf5_size = size_t()
    for k = 1, nDims do
        hdf5_size[k-1] = size[k]
    end
    return hdf5_size
end

--[[ Return a pointer to a NULL hsize_t array ]]
local function nullSize()
    local size_t = hdf5.ffi.typeof("hsize_t *")
    return size_t()
end

--[[ Constructor. Users need not call this directly. ]]
function HDF5Group:__init(parent, groupID)
    assert(parent)
    assert(groupID)
    self._parent = parent
    self._groupID = groupID

    hdf5._logger.debug("Initialising " .. tostring(self))

    if self._groupID < 0 then
        error("Invalid groupID " .. groupID)
    end

    local groupInfo = hdf5.ffi.new("H5G_info_t[1]")
    local err = hdf5.C.H5Gget_info(self._groupID, groupInfo)
    if err < 0 then
        error("Failed getting group info")
    end
    local nChildren = tonumber(groupInfo[0].nlinks)

    -- Create a wrapper object for each child of this group
    self._children = {}
    local callback = ffi.cast("H5L_iterate_t",
        function(baseGroupID, linkName, linkInfo, data)
            linkName = hdf5.ffi.string(linkName)
            self._children[linkName] =
                hdf5._loadObject(self, baseGroupID, linkName)
            return 0
        end)
    hdf5.C.H5Literate(
            self._groupID,
            hdf5.C.H5_INDEX_NAME,
            hdf5.C.H5_ITER_NATIVE,
            hdf5.ffi.new("hsize_t *"),
            callback,
            hdf5.ffi.new("void *")
        )
    callback:free()
end

function HDF5Group:__tostring()
    return "[HDF5Group " .. self._groupID .. " " .. hdf5._getObjectName(self._groupID) .. "]"
end

function HDF5Group:_writeDataSet(locationID, name, tensor, options)
    hdf5._logger.debug("Writing dataset '" .. name .. "' in " .. tostring(self))
    if not options then
        options = hdf5.DataSetOptions()
    end

    options:adjustForData(tensor)

    hdf5._logger.debug("Using options: " .. tostring(options))
    local dims = convertSize(tensor:size())
    local maxDims = convertSize(tensor:size())
    
    if options._chunking then
      maxDims[0] = hdf5.H5F_UNLIMITED -- array is zero indexed
    end

    -- (rank, dims, maxdims)
    local dataspaceID = hdf5.C.H5Screate_simple(tensor:nDimension(), dims, maxDims);

    local typename = torch.typename(tensor)
    local fileDataType = hdf5._outputTypeForTensorType(typename)
    if fileDataType == nil then
        error("Cannot find hdf5 file type for " .. typename)
    end

    local datasetID = hdf5.C.H5Dcreate2(
            locationID,
            name,
            fileDataType,
            dataspaceID,
            hdf5.H5P_DEFAULT,
            options:creationProperties(),
            hdf5.H5P_DEFAULT
        );


    local status = self:_writeTensorToDataSet(datasetID, tensor)

    if status < 0 then
        error("Error writing data " .. name .. " to " .. tostring(self))
    end

    local dataset = hdf5.HDF5DataSet(self, datasetID)
    return dataset
end

function HDF5Group:_writeTensorToDataSet(datasetID, tensor)
    local typename = torch.typename(tensor)
    local memoryDataType = hdf5._nativeTypeForTensorType(typename)
    local status = hdf5.C.H5Dwrite(
            datasetID,
            memoryDataType,
            hdf5.H5S_ALL,
            hdf5.H5S_ALL,
            hdf5.H5P_DEFAULT,
            tensor:contiguous():data()
        );
    return status
end

-- http://www.hdfgroup.org/ftp/HDF5/current/src/unpacked/examples/h5_extend.c
function HDF5Group:_appendDataSet(locationID, name, tensor, options)
  local status
  local datasetID = hdf5.C.H5Dopen2(
    locationID,
    name,
    hdf5.H5P_DEFAULT
    );

  local dataset = hdf5.HDF5DataSet(self, datasetID)
  local dataspaceID = dataset._dataspaceID

  -- Extend the dataset
  local tensorSize = tensor:size():totable()
  local originalSize = dataset:dataspaceSize()
  local newSize = dataset:dataspaceSize()
  newSize[1] = originalSize[1] + tensorSize[1]

  local newSize_h = convertSize(newSize)

  status = hdf5.C.H5Dset_extent(datasetID, newSize_h)
  dataspaceID = dataset:_refresh_dataspace() -- http://www.hdfgroup.org/HDF5/doc/RM/RM_H5D.html#Dataset-SetExtent

  if status < 0 then
    error("Error extending data " .. name .. " to " .. tostring(self))
  end

  -- build the offset
  local offset = {originalSize[1]}
  for k = 1, (tensor:nDimension() - 1) do
    table.insert(offset, k + 1, 0)
  end

  local offset_h = convertSize(offset)
  local stride_h = null
  local count_h = convertSize(tensorSize)

  -- Select a hyperslab in extended portion of dataset
  status = hdf5.C.H5Sselect_hyperslab(dataspaceID, hdf5.H5S_SELECT_SET, offset_h, stride_h, count_h, null);  

  if status < 0 then
    error("Error selecting hyperslab for data " .. name .. " to " .. tostring(self))
  end

  -- define a new memory space for the extension
  -- TODO we may need to close this memspaceID explicitly
  local memspaceID = hdf5.C.H5Screate_simple(tensor:nDimension(), convertSize(tensorSize), null);

  -- write the data to the extended portion of the dataset
  local typename = torch.typename(tensor)
  local memoryDataType = hdf5._nativeTypeForTensorType(typename)
  local status = hdf5.C.H5Dwrite(
          datasetID,
          memoryDataType,
          memspaceID,
          dataspaceID,
          hdf5.H5P_DEFAULT,
          tensor:data()
      );

  if status < 0 then
    error("Error writing to hyperslab for data " .. name .. " to " .. tostring(self))
  end

  status = hdf5.C.H5Sclose(memspaceID)
  if status < 0 then
    error("Failed closing memspace when appending for " .. tostring(self))
  end

  return dataset
end

local function isTensor(data)
    return torch.typename(data):sub(-6, -1) == 'Tensor'
end

function HDF5Group:_writeData(locationID, name, data, options)

    if type(data) == 'table' then
        error("_writeData should not be used for tables")
    elseif type(data) == 'userdata' then
        if isTensor(data) then
            return self:_writeDataSet(locationID, name, data, options)
        end
        error("torch-hdf5: writing non-Tensor userdata is not supported")
    end
    error("torch-hdf5: writing data of type " .. type(data) .. " is not supported")
end

function HDF5Group:_appendData(locationID, name, data, options)
    if type(data) == 'table' then
        error("_appendData should not be used for tables")
    elseif type(data) == 'userdata' then
        if isTensor(data) then
            return self:_appendDataSet(locationID, name, data, options)
        end
        error("torch-hdf5: writing non-Tensor userdata is not supported")
    end
    error("torch-hdf5: writing data of type " .. type(data) .. " is not supported")
end

function HDF5Group:createChild(name)
    assert(name, "no name given for child")
    hdf5._logger.debug("Creating child '" .. name .. "' of " .. tostring(self))
    local childID = hdf5.C.H5Gcreate2(self._groupID, name, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
    local child = hdf5.HDF5Group(self, childID)
    self._children[name] = child
    return child
end

function HDF5Group:getOrCreateChild(name)
    local child = self._children[name]
    if not child then
        child = self:createChild(name)
    end
    return child
end

function HDF5Group:write(datapath, data, options)
    self:_write_or_append("write", datapath, data, options)
end

function HDF5Group:append(datapath, data, options)
    self:_write_or_append("append", datapath, data, options)
end

function HDF5Group:_write_or_append(method, datapath, data, options)
    assert(datapath and type(datapath) == 'table', "HDF5Group:" .. method .. "() expects table as first parameter")
    assert(data, "HDF5Group:" .. method .. "() requires data as parameter")
    if #datapath == 0 then
        error("HDF5Group: descended too far")
    end
    local key = datapath[1]
    if #datapath > 1 then
        local child = self:getOrCreateChild(key)
        hdf5._logger.debug("Descending into child '" .. key
                           .. "' (" .. tostring(child) .. ") of " .. tostring(self))
        for k = 1, #datapath do
            datapath[k] = datapath[k+1]
        end
        return child[method](child, datapath, data, options)
    end

    if type(data) == 'table' then
        local child = self:getOrCreateChild(key)
        for k, v in pairs(data) do
            child[method](child, {k}, v, options)
        end
        return
    end

    hdf5._logger.debug(method .. " " .. (torch.typename(data) or type(data))
                       .. " as '" .. key .. "' in " .. tostring(self))

    local child
    if method == "write" then
      child = self:_writeData(self._groupID, key, data, options)
    elseif method == "append" then
      child = self:_appendData(self._groupID, key, data, options)
    end
    if not child then
        error("HDF5Group: error writing '" .. key .. "' in " .. tostring(self))
    end
    self._children[key] = child
end

function HDF5Group:read(datapath)
    assert(datapath and type(datapath) == 'table', "HDF5Group:read() expects table as first parameter")
    hdf5._logger.debug("Reading from " .. tostring(self))
    if not datapath or #datapath == 0 then
        return self
    end

    local key = datapath[1]
    local child = self._children[key]
    if not child then
        error("HDF5Group:read() - no such child '" .. key .. "' for " .. tostring(self))
    end
    if #datapath > 1 then
        hdf5._logger.debug("Descending into child '" .. key
                           .. "' (" .. tostring(child) .. ") of " .. tostring(self))
        for k = 1, #datapath do
            datapath[k] = datapath[k+1]
        end
        return child:read(datapath)
    end

    hdf5._logger.debug("Reading " .. tostring(child) .. " as '" .. key .. "' in " .. tostring(self))
    return child
end

function HDF5Group:all()
    local table = {}
    for k, v in pairs(self._children) do
        table[k] = v:all()
    end
    return table
end

function HDF5Group:close()
    for k, v in pairs(self._children) do
        v:close()
    end

    hdf5._logger.debug("Closing " .. tostring(self))
    local status = hdf5.C.H5Gclose(self._groupID)
    if status < 0 then
        error("Error closing " .. tostring(self))
    end
end
