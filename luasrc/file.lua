local stringx = require 'pl.stringx'

local HDF5File = torch.class("hdf5.HDF5File")

function HDF5File:__init(filename, fileID)
    assert(filename and type(filename) == 'string', "HDF5File.__init() requires a filename - perhaps you want HDF5File.create()?")
    assert(fileID and type(fileID) == 'number', "HDF5File.__init() requires a fileID - perhaps you want HDF5File.create()?")
    if fileID < 0 then
        error("HDF5File: fileID " .. fileID .. " is not valid")
    end
    self._filename = filename
    self._fileID = fileID

    hdf5._logger.debug("Opening " .. tostring(self))

    self._rootGroup = hdf5._loadObject(self, fileID, "/")
    if not self._rootGroup then
        error("HDF5FILE: unable to load root group from file")
    end
end

function HDF5File:filename()
    return self._filename
end

function HDF5File:__tostring()
    return "[HDF5File: " .. self:filename() .. "]"
end

function HDF5File:close()
    self._rootGroup:close()
    hdf5._logger.debug("Closing " .. tostring(self))
    local status = hdf5.C.H5Fclose(self._fileID)
    if not status then
        hdf5._logger.error("Error closing " .. tostring(self))
    end
end

function HDF5File:write(datapath, data)
    if datapath:sub(1,1) == "/" then
        datapath = datapath:sub(2)
    end
    datapath = stringx.split(datapath, "/") -- TODO
    assert(datapath and type(datapath) == 'table', "HDF5File:write() requires a table (data path) as its first parameter")
    assert(data and type(data) == 'userdata' or type(data) == 'table', "HDF5File:write() requires a tensor or table as its second parameter")
    --[[
    local components = stringx.split(datapath, "/")

    for k, component in ipairs(components) do
        local table = {}
        table[component] = data
        data = table
    end
    ]]

    if #datapath == 0 then
        if type(data) == 'table' then
            for k, v in pairs(data) do
                self._rootGroup:write( { k }, v)
            end
            return
        else
            error("HDF5File:write() - must provide a table when writing to the root location")
        end
    end

    self._rootGroup:write(datapath, data)
end

function HDF5File:read(datapath)
    hdf5._logger.debug("Reading " .. datapath .. " from " .. tostring(self))
    if datapath:sub(1,1) == "/" then
        datapath = datapath:sub(2)
    end
    datapath = stringx.split(datapath, "/") -- TODO
--    return hdf5._loadObject(self, self._fileID, datapath)
    return self._rootGroup:read(datapath)
end

--[[ Open or create an HDF5 file.

Parameters:
* `filename` - path to file
* `mode` (default `'a'`) - mode of access

Where `mode` is one of the following strings:

* `'a'`  - Read/write if exists; create otherwise
* `'r'`  - Read-only; file must exist
* `'r+'` - Read/write; file must exist
* `'w'`  - Create file; overwrite if exists
* `'w-'` - Create file; fail if exists

Returns:
* A new HDF5File object

]]
function hdf5.HDF5File.open(filename, mode)
    -- TODO: more control over HDF5 options
    -- * compression
    -- * chunking

    local dirname = path.dirname(filename)
    if not path.isdir(dirname) then

    end
    if mode == nil or mode == 'a' then
        if path.exists(filename) then
            mode = 'r+'
        else
            mode = 'w'
        end
    end
    if mode == 'r' then
        local fileID = hdf5.C.H5Fopen(filename, hdf5.H5F_ACC_RDONLY, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    elseif mode == 'r+' then
        local fileID = hdf5.C.H5Fopen(filename, hdf5.H5F_ACC_RDRW, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    elseif mode == 'w' then
        local fileID = hdf5.C.H5Fcreate(filename, hdf5.H5F_ACC_TRUNC, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    elseif mode == 'w-' then
        local fileID = hdf5.C.H5Fcreate(filename, hdf5.H5F_ACC_EXCL, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    else
        error("Unknown mode '" .. mode .. "' for hdf5.open()")
    end
end

