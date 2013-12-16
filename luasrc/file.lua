
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

--[[ Return a pointer to a NULL hsize_t array ]]
local function nullSize()
    local size_t = hdf5.ffi.typeof("hsize_t *")
    return size_t()
end

local HDF5File = torch.class("hdf5.HDF5File")

function HDF5File:__init(filename, fileID)
    assert(filename and type(filename) == 'string', "HDF5File.__init() requires a filename - perhaps you want HDF5File.create()?")
    assert(fileID and type(fileID) == 'number', "HDF5File.__init() requires a fileID - perhaps you want HDF5File.create()?")
    self._filename = filename
    self._fileID = fileID
end

function HDF5File:filename()
    return self._filename
end

function HDF5File:__tostring()
    return "[HDF5File: " .. self:filename() .. "]"
end

function HDF5File:close()
    hdf5._logger.debug("Closing " .. tostring(self))
    local status = hdf5.C.H5Fclose(self._fileID)
    if not status then
        hdf5._logger.error("Error closing " .. tostring(self))
    end
end

function HDF5File:write(datapath, tensor)
    assert(datapath and type(datapath) == 'string')
    assert(tensor and type(tensor) == 'userdata')
    local components = stringx.split(datapath, "/")
    --local total = #components
    --for k, component in ipairs(components) do
    --    if k == total then
    --        -- create dataset
    --    else
    --        -- create group
    --    end
    --end
    local dims = convertSize(tensor:size())

    -- (rank, dims, maxdims)
    local dataspaceID = hdf5.C.H5Screate_simple(tensor:nDimension(), dims, nullSize());

    local name = "/dset"

    local typename = torch.typename(tensor)
    local fileDataType = hdf5._outputTypeForTensorType(typename)
    local memoryDataType = hdf5._nativeTypeForTensorType(typename)
    if fileDataType == nil then
        error("Cannot find hdf5 file type for " .. typename)
    end
    local datasetID = hdf5.C.H5Dcreate2(
            self._fileID,
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

    status = hdf5.C.H5Dclose(datasetID)
    -- TODO check status
    status = hdf5.C.H5Sclose(dataspaceID)
    -- TODO check status
end

function HDF5File:read(datapath)
    hdf5._logger.debug("Opening " .. tostring(self))
    local datasetID = hdf5.C.H5Dopen2(self._fileID, "/dset", hdf5.H5P_DEFAULT);
    local typeID = hdf5.C.H5Dget_type(datasetID)
    local nativeType = hdf5.C.H5Tget_native_type(typeID, hdf5.C.H5T_DIR_ASCEND)
    local torchType = hdf5._getTorchType(typeID)
    if not torchType then
        error("Could not find torch type for native type " .. tostring(nativeType))
    end
    if not nativeType then
        error("Cannot find hdf5 native type for " .. torchType)
    end
    local spaceID = hdf5.C.H5Dget_space(datasetID)
    if not hdf5.C.H5Sis_simple(spaceID) then
        error("Error: complex dataspaces are not supported!")
    end

    -- Create a new tensor of the correct type and size
    local nDims = hdf5.C.H5Sget_simple_extent_ndims(spaceID)
    local size = getDataspaceSize(nDims, spaceID)
    local factory = torch.factory(torchType)
    if not factory then
        error("No torch factory for type " .. torchType)
    end

    local tensor = factory():resize(unpack(size))

    -- Read data into the tensor
    local dataPtr = torch.data(tensor)
    hdf5.C.H5Dread(datasetID, nativeType, hdf5.H5S_ALL, hdf5.H5S_ALL, hdf5.H5P_DEFAULT, dataPtr)
    return tensor
end

function hdf5.HDF5File.create(filename)
end
function hdf5.HDF5File.open(filename)
    return nil
end
