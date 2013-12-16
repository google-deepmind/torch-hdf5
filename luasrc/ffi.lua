local ffi = require 'ffi'
local stringx = require 'pl.stringx'
require 'torchffi'

local hdf5lib = ffi.load("hdf5")
if not hdf5lib then
    error("torch-hdf5: unable to load libhdf5!")
end
hdf5.C = hdf5lib

-- Pass the header file through the C preprocessor once
local process = io.popen("gcc -E hdf5/include/hdf5.h")
local contents = process:read("*all")
process:close()

-- Strip out the extra junk that GCC returns
local cdef = ""
for _, line in ipairs(stringx.splitlines(contents)) do
    if not stringx.startswith(line, '#') then
        cdef = cdef .. line .. "\n"
    end
end

ffi.cdef(cdef)

-- Initialize HDF5
hdf5.C.H5open()
hdf5.C.H5check_version(1, 8, 12)
hdf5.ffi = ffi

--[[

Adding definitions for global constants

]]

-- H5Tpublic.h
local function addConstants(tableName, constantNames, func)
    if not func then
        func = function(x) return x end
    end
    if not hdf5[tableName] then
        hdf5[tableName] = { }
    end
    for _, name in ipairs(constantNames) do
        hdf5[tableName][name] = hdf5.C[func(name)]
    end
end

local function addH5t(x) return "H5T_" .. x end
addConstants('h5t', {
    'NO_CLASS',
    'INTEGER',
    'FLOAT',
    'TIME',
    'STRING',
    'BITFIELD',
    'OPAQUE',
    'COMPOUND',
    'REFERENCE',
    'ENUM',
    'VLEN',
    'ARRAY',
    'NCLASSES',
}, addH5t)
local function addG(x) return addH5t(x) .. "_g" end

addConstants('h5t', {
    'IEEE_F32BE',
    'IEEE_F32LE',
    'IEEE_F64BE',
    'IEEE_F64LE',
}, addG)

addConstants('h5t', {
    'STD_I8BE',
    'STD_I8LE',
    'STD_I16BE',
    'STD_I16LE',
    'STD_I32BE',
    'STD_I32LE',
    'STD_I64BE',
    'STD_I64LE',
    'STD_U8BE',
    'STD_U8LE',
    'STD_U16BE',
    'STD_U16LE',
    'STD_U32BE',
    'STD_U32LE',
    'STD_U64BE',
    'STD_U64LE',
    'STD_B8BE',
    'STD_B8LE',
    'STD_B16BE',
    'STD_B16LE',
    'STD_B32BE',
    'STD_B32LE',
    'STD_B64BE',
    'STD_B64LE',
    'STD_REF_OBJ',
    'STD_REF_DSETREG',
}, addG)

addConstants('h5t', {
    'NATIVE_SCHAR',
    'NATIVE_UCHAR',
    'NATIVE_SHORT',
    'NATIVE_USHORT',
    'NATIVE_INT',
    'NATIVE_UINT',
    'NATIVE_LONG',
    'NATIVE_ULONG',
    'NATIVE_LLONG',
    'NATIVE_ULLONG',
    'NATIVE_FLOAT',
    'NATIVE_DOUBLE',
    'NATIVE_LDOUBLE',
    'NATIVE_B8',
    'NATIVE_B16',
    'NATIVE_B32',
    'NATIVE_B64',
    'NATIVE_OPAQUE',
    'NATIVE_HADDR',
    'NATIVE_HSIZE',
    'NATIVE_HSSIZE',
    'NATIVE_HERR',
    'NATIVE_HBOOL',
    'NATIVE_INT8',
    'NATIVE_UINT8',
    'NATIVE_INT_LEAST8',
    'NATIVE_UINT_LEAST8',
    'NATIVE_INT_FAST8',
    'NATIVE_UINT_FAST8',
    'NATIVE_INT16',
    'NATIVE_UINT16',
    'NATIVE_INT_LEAST16',
    'NATIVE_UINT_LEAST16',
    'NATIVE_INT_FAST16',
    'NATIVE_UINT_FAST16',
    'NATIVE_INT32',
    'NATIVE_UINT32',
    'NATIVE_INT_LEAST32',
    'NATIVE_UINT_LEAST32',
    'NATIVE_INT_FAST32',
    'NATIVE_UINT_FAST32',
    'NATIVE_INT64',
    'NATIVE_UINT64',
    'NATIVE_INT_LEAST64',
    'NATIVE_UINT_LEAST64',
    'NATIVE_INT_FAST64',
    'NATIVE_UINT_FAST64',
}, addG)

local function getNativeTypeName(nativeTypeID)
--    print("LOOKING FOR ", nativeTypeID)
    for k, v in pairs(hdf5.h5t) do
--        prit(k, v)
        if k:sub(1,6) == "NATIVE" and v == nativeTypeID then
            return k
        end
    end
    return nil
end

hdf5.H5F_ACC_RDONLY = 0x0000       -- absence of rdwr => rd-only 
hdf5.H5F_ACC_RDWR   = 0x0001       -- open for read and write    
hdf5.H5F_ACC_TRUNC  = 0x0002       -- overwrite existing files   
hdf5.H5F_ACC_EXCL   = 0x0004       -- fail if file already exists
hdf5.H5F_ACC_DEBUG  = 0x0008       -- print debug info           
hdf5.H5F_ACC_CREAT  = 0x0010       -- create non-existing files  


hdf5.H5P_DEFAULT = 0
hdf5.H5S_ALL = 0

local NULL = 0



local function convertSize(size)
    local nDims = size:size()
    local size_t = hdf5.ffi.typeof("hsize_t[" .. nDims .. "]")
    local hdf5_size = size_t()
    for k = 1, nDims do
        hdf5_size[k-1] = size[k]
    end
    return hdf5_size
end

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

local function nullSize()
    local size_t = hdf5.ffi.typeof("hsize_t *")
    return size_t()
end

function hdf5.open(filename, mode)
    if mode == 'w' then
        local fileID = hdf5.C.H5Fcreate(filename, hdf5.H5F_ACC_TRUNC, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    elseif mode == 'r' then
        local fileID = hdf5.C.H5Fopen(filename, hdf5.H5F_ACC_RDWR, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    else
        error("Unknown mode '" .. mode .. "' for hdf5.open()")
    end
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
--    print("closing file")
    local status = hdf5.C.H5Fclose(self._fileID)
    if not status then
        error("Error closing file " .. self._filename)
    end
    -- TODO track file open status
--    print("status: ", status)
end

local fileTypeMap = {
    ["torch.IntTensor"] = hdf5.h5t.STD_I32BE,
    ["torch.LongTensor"] = hdf5.h5t.STD_I64BE,
    ["torch.FloatTensor"] = hdf5.h5t.IEEE_F32BE,
    ["torch.DoubleTensor"] = hdf5.h5t.IEEE_F64BE
}
local inverseNativeTypeMap = {
        [hdf5.h5t.NATIVE_SCHAR] = "torch.ByteTensor",
        [hdf5.h5t.NATIVE_SHORT] = "torch.IntTensor",
        [hdf5.h5t.NATIVE_INT]   = "torch.IntTensor",
        [hdf5.h5t.NATIVE_LONG]  = "torch.LongTensor",
        [hdf5.h5t.NATIVE_LLONG] = "torch.LongTensor",
--        H5T_NATIVE_UCHAR = "torch.Tensor",
--        H5T_NATIVE_USHORT = "torch.Tensor",
--        H5T_NATIVE_UINT = "torch.Tensor",
--        H5T_NATIVE_ULONG = "torch.Tensor",
--        H5T_NATIVE_ULLONG = "torch.Tensor",
        [hdf5.h5t.NATIVE_FLOAT]  = "torch.FloatTensor",
        [hdf5.h5t.NATIVE_DOUBLE] = "torch.DoubleTensor",
--        H5T_NATIVE_LDOUBLE = "torch.Tensor",
--        H5T_NATIVE_B8 = "torch.Tensor",
--        H5T_NATIVE_B16 = "torch.Tensor",
--        H5T_NATIVE_B32 = "torch.Tensor",
--        H5T_NATIVE_B64 = "torch.Tensor",
}
local nativeTypeMap = {
    ["torch.ByteTensor"] = hdf5.h5t.NATIVE_CHAR,
    ["torch.IntTensor"] = hdf5.h5t.NATIVE_INT,
    ["torch.LongTensor"] = hdf5.h5t.NATIVE_LONG,
    ["torch.FloatTensor"] = hdf5.h5t.NATIVE_FLOAT,
    ["torch.DoubleTensor"] = hdf5.h5t.NATIVE_DOUBLE,
}

local classMap = {}
classMap[tonumber(hdf5.h5t.INTEGER)] = 'INTEGER'
classMap[tonumber(hdf5.h5t.FLOAT)] = 'FLOAT'
classMap[tonumber(hdf5.h5t.STRING)] = 'STRING'

function HDF5File:set(datapath, tensor)
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
--    print("space id: ", dataspaceID)

    local name = "/dset"

--    print(hdf5.datatypes)
    local typename = torch.typename(tensor)
    local fileDataType = fileTypeMap[typename]
    local memoryDataType = nativeTypeMap[typename]
    if fileDataType == nil then
        error("Cannot find hdf5 file type for " .. typename)
    end
    if memoryDataType == nil then
        error("Cannot find hdf5 native type for " .. typename)
    end
    -- hdf5.datatypes.H5T_INTEGER
    -- hdf5.std.H5T_STD_I32BE,
--    print(datatype)
    local datasetID = hdf5.C.H5Dcreate2(
            self._fileID,
            name,
            fileDataType,
            dataspaceID,
            hdf5.H5P_DEFAULT,
            hdf5.H5P_DEFAULT,
            hdf5.H5P_DEFAULT
        );
--    print("set id: ", dataspaceID)

--    print("writing data")
    local status = hdf5.C.H5Dwrite(
            datasetID,
            memoryDataType,
            hdf5.H5S_ALL,
            hdf5.H5S_ALL,
            hdf5.H5P_DEFAULT,
            torch.data(tensor)
        );
--    print("status: ", status)

--    print("closing dataset")
    status = hdf5.C.H5Dclose(datasetID)
--    print("status: ", status)
--    print("closing dataspace")
    status = hdf5.C.H5Sclose(dataspaceID)
--    print("status: ", status)
end

function HDF5File:get(datapath)
    local datasetID = hdf5.C.H5Dopen2(self._fileID, "/dset", hdf5.H5P_DEFAULT);
    local typeID = hdf5.C.H5Dget_type(datasetID)
    function getTorchType(typeID)
        local classID = tonumber(hdf5.C.H5Tget_class(typeID))
        local className = classMap[classID]
        local size = tonumber(hdf5.C.H5Tget_size(typeID))
        if className == 'INTEGER' then
            if size == 1 then
                return 'torch.ByteTensor'
            end
            if size == 4 then
                return 'torch.IntTensor'
            end
            if size == 8 then
                return 'torch.LongTensor'
            end
            error("Cannot support reading integer data with size = " .. size .. " bytes")
        elseif className == 'FLOAT' then
            if size == 4 then
                return 'torch.FloatTensor'
            end
            if size == 8 then
                return 'torch.DoubleTensor'
            end
            error("Cannot support reading float data with size = " .. size .. " bytes")

        else
            error("Reading data of class " .. tostring(className) .. "(" .. classID .. ") is unsupported")
        end
    end
    local nativeType = hdf5.C.H5Tget_native_type(typeID, hdf5.C.H5T_DIR_ASCEND)
    local torchType = getTorchType(typeID)
    if not torchType then
        error("Could not find torch type for native type " .. tostring(getNativeTypeName(nativeType)))
    end
    local hdf5memoryType = nativeType
    if not hdf5memoryType then
        error("Cannot find hdf5 native type for " .. torchType)
    end
    local spaceID = hdf5.C.H5Dget_space(datasetID)
    if not hdf5.C.H5Sis_simple(spaceID) then
        error("Error: complex dataspaces are not supported!")
    end
    local nDims = hdf5.C.H5Sget_simple_extent_ndims(spaceID)
    local size = getDataspaceSize(nDims, spaceID)
    local factory = torch.factory(torchType)
    if not factory then
        error("No torch factory for type " .. torchType)
    end
    local tensor = factory():resize(unpack(size))
    local dataPtr = torch.data(tensor)
    hdf5.C.H5Dread(datasetID, hdf5memoryType, hdf5.H5S_ALL, hdf5.H5S_ALL, hdf5.H5P_DEFAULT, dataPtr)
    return tensor
end

function hdf5.HDF5File.create(filename)
end
function hdf5.HDF5File.open(filename)
    return nil
end

