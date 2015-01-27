local torch = require 'torch'
local path = require 'pl.path'
local stringx = require 'pl.stringx'
local bit = require 'bit'

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
    return "[HDF5File: " .. hdf5._describeObject(self._fileID) .. " " .. self:filename() .. "]"
end

function HDF5File:close()
    self._rootGroup:close()
    hdf5._logger.debug("Closing " .. tostring(self))
    local status = hdf5.C.H5Fclose(self._fileID)
    if not status then
        hdf5._logger.error("Error closing " .. tostring(self))
    end
end

function HDF5File:write(datapath, data, options)
    self:_write_or_append("write", datapath, data, options)
end

function HDF5File:append(datapath, data, options)
    self:_write_or_append("append", datapath, data, options)
end

function HDF5File:_write_or_append(method, datapath, data, options)
    if datapath:sub(1,1) == "/" then
      datapath = datapath:sub(2)
    end
    datapath = stringx.split(datapath, "/") -- TODO
    assert(datapath and type(datapath) == 'table', "HDF5File:" .. method .. "() requires a table (data path) as its first parameter")
    assert(data and type(data) == 'userdata' or type(data) == 'table', "HDF5File:" .. method .. "() requires a tensor or table as its second parameter")

    if #datapath == 0 then
        if type(data) == 'table' then
            for k, v in pairs(data) do
                self._rootGroup[method](self._rootGroup, { k }, v, options)
            end
          return
      else
          error("HDF5File:write() - must provide a table when writing to the root location")
      end
    end

    self._rootGroup[method](self._rootGroup, datapath, data, options)
end

function HDF5File:read(datapath)
    if not datapath then
        datapath = "/"
    end
    hdf5._logger.debug("Reading " .. datapath .. " from " .. tostring(self))
    if datapath:sub(1,1) == "/" then
        datapath = datapath:sub(2)
    end
    datapath = stringx.split(datapath, "/") -- TODO
    return self._rootGroup:read(datapath)
end

function HDF5File:all()
    return self:read("/"):all()
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
    if filename:sub(1,2) == "~/" then
        filename = path.abspath(filename:sub(3))
    end
    filename = path.abspath(filename)

    local dirname = path.dirname(filename)
    if not path.isdir(dirname) then
        error("HDF5File.open: no such directory " .. dirname)
    end
    if mode == nil or mode == 'a' then
        if path.exists(filename) then
            mode = 'r+'
        else
            mode = 'w'
        end
    end
    local function createFunc(filename, access)
        local fileID = hdf5.C.H5Fcreate(filename, access, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    end
    local function openFunc(filename, access)
        local fileID = hdf5.C.H5Fopen(filename, access, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    end
    if mode == 'r' then
        return openFunc(filename, hdf5.H5F_ACC_RDONLY)
    elseif mode == 'r+' then
        return openFunc(filename, hdf5.H5F_ACC_RDWR)
    elseif mode == 'w' then
        return createFunc(filename, hdf5.H5F_ACC_TRUNC)
    elseif mode == 'w-' then
        return createFunc(filename, hdf5.H5F_ACC_EXCL)
    else
        error("Unknown mode '" .. mode .. "' for hdf5.open()")
    end
end

function HDF5File:_printOpenObjects()
    local flags = bit.bor(hdf5.H5F_OBJ_ALL, hdf5.H5F_OBJ_LOCAL)
    local openCount = tonumber(hdf5.C.H5Fget_obj_count(self._fileID, flags))
    local objInfo = ""
    if openCount > 0 then
        local objList = hdf5.ffi.new("int[" .. openCount .. "]")
        hdf5.C.H5Fget_obj_ids(self._fileID, flags, openCount, objList)
        for k = 0, openCount-1 do
            objInfo = objInfo .. " * " .. hdf5._describeObject(objList[k]) .. "\n"
        end
    end
    print("File " .. tostring(self) .. " has " .. openCount .. " open objects.\n" .. objInfo)
    return openCount
end
