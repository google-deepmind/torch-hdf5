
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

function HDF5File:_writeTensor(locationID, name, tensor)
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

function HDF5File:_writeTable(locationID, name, table)
    for name, v in pairs(table) do

        -- create group for key (or ensure exists)
        -- TODO
        local subLocationID = 0

        self:_writeData(subLocationID, name, v)
    end
end

local function isTensor(data)
    -- TODO
    return true
end

function HDF5File:_writeData(locationID, name, data)

    if type(data) == 'table' then
        self:_writeTable(locationID, name, data)
    elseif type(data) == 'userdata' then
        if isTensor(data) then
            self:_writeTensor(locationID, name, data)
        else
            error("HDF5File: writing non-Tensor userdata is not supported")
        end
    else
        error("HDF5File: writing data of type " .. type(data) .. " is not supported")
    end

end

function HDF5File:write(datapath, data)
    assert(datapath and type(datapath) == 'string', "HDF5File:write() requires a string (data path) as its first parameter")
    assert(data and type(data) == 'userdata' or type(data) == 'table', "HDF5File:write() requires a tensor or table as its second parameter")
    local components = stringx.split(datapath, "/")

    for k, component in ipairs(components) do
        local table = {}
        table[component] = data
        data = table
    end

    local root = 0 -- TODO
    local name = ""
    self:_writeData(root, name, data)
end

function HDF5File:read(datapath)
    hdf5._logger.debug("Reading " .. datapath .. " from " .. tostring(self))
    return hdf5._loadObject(self, self._fileID, datapath)
end

-- TODO fix or remove
function hdf5.HDF5File.create(filename)
end
function hdf5.HDF5File.open(filename)
    return nil
end
