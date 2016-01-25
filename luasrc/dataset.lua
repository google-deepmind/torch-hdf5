local torch = require "torch"

-- Lua 5.2 compatibility
local unpack = unpack or table.unpack

local HDF5DataSet = torch.class("hdf5.HDF5DataSet")

--[[ Get the sizes and max sizes of an HDF5 dataspace, returning them in Lua tables ]]
local function getDataspaceSize(nDims, spaceID)
    local size_t = hdf5.ffi.typeof("hsize_t[" .. nDims .. "]")
    local dims = size_t()
    local maxDims = size_t()
    if hdf5.C.H5Sget_simple_extent_dims(spaceID, dims, maxDims) ~= nDims then
        error("Failed getting dataspace size")
    end
    local size = {}
    local maxSize = {}
    for k = 1, nDims do
        size[k] = tonumber(dims[k-1])
        maxSize[k] = tonumber(maxDims[k-1])
    end
    return size, maxSize
end

local function longStorageToHSize(storage, n)
    local out = hdf5.ffi.new("hsize_t[" .. n .. "]")
    for k = 1, n do
        out[k-1] = storage[k]
    end
    return out
end

--[[ Create an HDF5 dataspace corresponding to a given tensor ]]
local function createTensorDataspace(tensor)
    local n = tensor:nDimension()
    local dataspaceID = hdf5.C.H5Screate_simple(
            n,
            longStorageToHSize(tensor:size(), n),
            longStorageToHSize(tensor:size(), n)
        )
    return dataspaceID
end

function HDF5DataSet:__init(parent, datasetID)
    assert(parent)
    assert(datasetID)
    self._parent = parent
    self._datasetID = datasetID
    self._dataspaceID = hdf5.C.H5Dget_space(self._datasetID)
    hdf5._logger.debug("Initialising " .. tostring(self))
end

function HDF5DataSet:_refresh_dataspace()
    local status = hdf5.C.H5Sclose(self._dataspaceID)
    assert(status >= 0, "error refreshing dataspace")
    self._dataspaceID = hdf5.C.H5Dget_space(self._datasetID)
    return self._dataspaceID
end

function HDF5DataSet:__tostring()
    return "[HDF5DataSet " .. hdf5._describeObject(self._datasetID) .. "]"
end

function HDF5DataSet:all()

    -- Create a new tensor of the correct type and size
    local nDims = hdf5.C.H5Sget_simple_extent_ndims(self._dataspaceID)
    local size = getDataspaceSize(nDims, self._dataspaceID)
    local factory, nativeType = self:getTensorFactory()

    local tensor = factory():resize(unpack(size))

    -- Read data into the tensor
    local dataPtr = tensor:data()
    local status = hdf5.C.H5Dread(self._datasetID, nativeType, hdf5.H5S_ALL, hdf5.H5S_ALL, hdf5.H5P_DEFAULT, dataPtr)

    if status < 0 then
        error("HDF5DataSet:all() - failed reading data from " .. tostring(self))
    end
    hdf5.C.H5Tclose(nativeType)

    return tensor
end

function HDF5DataSet:getTensorFactory()
    local typeID = hdf5.C.H5Dget_type(self._datasetID)
    local nativeType = hdf5.C.H5Tget_native_type(typeID, hdf5.C.H5T_DIR_ASCEND)
    local torchType = hdf5._getTorchType(typeID)
    hdf5.C.H5Tclose(typeID)
    if not torchType then
        error("Could not find torch type for native type " .. tostring(nativeType))
    end
    if not nativeType then
        error("Cannot find hdf5 native type for " .. torchType)
    end
    if not hdf5.C.H5Sis_simple(self._dataspaceID) then
        error("Error: complex dataspaces are not supported!")
    end
    local factory = torch.factory(torchType)
    if not factory then
        error("No torch factory for type " .. torchType)
    end
    return factory, nativeType
end

local function rangesToOffsetAndCount(ranges)
    local offset = hdf5.ffi.new("hsize_t[" .. #ranges+1 .. "]")
    local count = hdf5.ffi.new("hsize_t[" .. #ranges+1 .. "]")

    for k, range in ipairs(ranges) do
        if type(range) ~= 'table' then
            range = { range, range }
        end
        offset[k-1] = range[1] - 1
        count[k-1] = range[2] - range[1] + 1
    end
    return offset, count
end

local function hsizeToLongStorage(hsize, n)
    local out = torch.LongStorage(n)
    for k = 1, n do
        out[k] = tonumber(hsize[k-1])
    end
    return out
end

function HDF5DataSet:partial(...)
    local ranges = { ... }
    local nDims = hdf5.C.H5Sget_simple_extent_ndims(self._dataspaceID)
    if #ranges ~= nDims then
        error("HDF5DataSet:partial() - dimension mismatch. Expected " .. nDims .. " but " .. #ranges .. " were given.")
    end
    -- TODO dedup
    local null = hdf5.ffi.new("hsize_t *")
    local offset, count = rangesToOffsetAndCount(ranges)
    -- Create a new tensor of the correct type and size
    local factory, nativeType = self:getTensorFactory()
    local tensor = factory():resize(hsizeToLongStorage(count, #ranges))

    local stride = null

    -- TODO clone space first?
    local status = hdf5.C.H5Sselect_hyperslab(self._dataspaceID, hdf5.C.H5S_SELECT_SET, offset, stride, count, null)
    if status < 0 then
        error("Cannot select hyperslab " .. tostring(...) .. " from " .. tostring(self))
    end

    hdf5._logger.debug("HDF5DataSet:partial() - selected "
            .. tostring(hdf5.C.H5Sget_select_npoints(self._dataspaceID)) .. " points"
        )

    local tensorDataspace = createTensorDataspace(tensor)
    -- Read data into the tensor
    local dataPtr = tensor:data()
    status = hdf5.C.H5Dread(self._datasetID, nativeType, tensorDataspace, self._dataspaceID, hdf5.H5P_DEFAULT, dataPtr)
    -- delete tensor dataspace
    local dataspace_status = hdf5.C.H5Sclose(tensorDataspace)

    assert(status >=0, "HDF5DataSet:partial() - failed reading data from " .. tostring(self))
    assert(dataspace_status >= 0, "HDF5DataSet:partial() - error closing tensor dataspace for " .. tostring(self))
    hdf5.C.H5Tclose(nativeType)
    return tensor
end

function HDF5DataSet:close()
    hdf5._logger.debug("Closing " .. tostring(self))
    local status = hdf5.C.H5Dclose(self._datasetID)
    if status < 0 then
        error("Failed closing dataset for " .. tostring(self))
    end
    status = hdf5.C.H5Sclose(self._dataspaceID)
    if status < 0 then
        error("Failed closing dataspace for " .. tostring(self))
    end
end

function HDF5DataSet:dataspaceSize()
  local nDims = hdf5.C.H5Sget_simple_extent_ndims(self._dataspaceID)
  local size = getDataspaceSize(nDims, self._dataspaceID)
  return size
end
