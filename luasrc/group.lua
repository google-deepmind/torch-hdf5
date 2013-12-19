local stringx = require 'pl.stringx'

local HDF5Group = torch.class("hdf5.HDF5Group")

--[[ Convert from LongStorage containing tensor sizes to an HDF5 hsize_t array ]]
local function convertSize(size)
    local nDims = size:size()
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
    hdf5.C.H5Literate(
            self._groupID,
            hdf5.C.H5_INDEX_NAME,
            hdf5.C.H5_ITER_NATIVE,
            ffi.new("hsize_t *"),
            function(baseGroupID, linkName, linkInfo, data)
                linkName = ffi.string(linkName)
                self._children[linkName] = hdf5._loadObject(self, baseGroupID, linkName)
                return 0
            end,
            ffi.new("void *")
        )
end

function HDF5Group:__tostring()
    return "[HDF5Group " .. self._groupID .. " " .. hdf5._getObjectName(self._groupID) .. "]"
end

function HDF5Group:_writeDataSet(locationID, name, tensor)
    hdf5._logger.debug("Writing dataset '" .. name .. "' in " .. tostring(self))
    local dims = convertSize(tensor:size())

    -- (rank, dims, maxdims)
    local dataspaceID = hdf5.C.H5Screate_simple(tensor:nDimension(), dims, nullSize());

    local typename = torch.typename(tensor)
    local fileDataType = hdf5._outputTypeForTensorType(typename)
    local memoryDataType = hdf5._nativeTypeForTensorType(typename)
    if fileDataType == nil then
        error("Cannot find hdf5 file type for " .. typename)
    end
    local datasetID = hdf5.C.H5Dcreate2(
            locationID,
            name,
            fileDataType,
            dataspaceID,
            hdf5.H5P_DEFAULT,
            hdf5.H5P_DEFAULT,
            hdf5.H5P_DEFAULT
        );

    local status = hdf5.C.H5Dwrite(
            datasetID,
            memoryDataType,
            hdf5.H5S_ALL,
            hdf5.H5S_ALL,
            hdf5.H5P_DEFAULT,
            torch.data(tensor)
        );
    -- TODO check status


    local dataset = hdf5.HDF5DataSet(self, datasetID, dataspaceID) -- TODO
    return dataset
end

function HDF5Group:_writeTable(locationID, name, table)
    for name, v in pairs(table) do

        -- create group for key (or ensure exists)
        -- TODO
        local subLocationID = 0
        error("TODO hdf5._writeTable")
        self:_writeData(subLocationID, name, v)
    end

    return hdf5.HDF5Group(self, groupID)
end

local function isTensor(data)
    return torch.typename(data):sub(-6, -1) == 'Tensor'
end

function HDF5Group:_writeData(locationID, name, data)

    if type(data) == 'table' then
        error("_writeData should not be used for tables")
--        return self:_writeTable(, name, data)
    elseif type(data) == 'userdata' then
        if isTensor(data) then
            return self:_writeDataSet(locationID, name, data)
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

function HDF5Group:write(datapath, data)
    assert(datapath and type(datapath) == 'table', "HDF5Group:write() expects table as first parameter")
    assert(data, "HDF5Group:write() requires data as parameter")
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
        return child:write(datapath, data)
    end

    if type(data) == 'table' then
        local child = self:getOrCreateChild(key)
        for k, v in pairs(data) do
            child:write({k}, v)
        end
        return
    end

    hdf5._logger.debug("Writing " .. (torch.typename(data) or type(data))
                       .. " as '" .. key .. "' in " .. tostring(self))
    local child = self:_writeData(self._groupID, key, data)
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
