local ffi = require 'ffi'
local stringx = require 'pl.stringx'
local path = require 'pl.path'
require 'torchffi'

function loadHDF5Library(libraryPaths)
    local libraries = stringx.split(libraryPaths, ";")
    local hdf5LibPath
    for _, libPath in ipairs(libraries) do
        local basename = path.basename(libPath)
        local name, ext = path.splitext(basename)
        if name == 'libhdf5' then
            hdf5LibPath = libPath
            break
        end
    end

    if not hdf5LibPath then
        error("Error: unable to find a valid HDF5 lib path in the config")
    end

    -- If the path from the config isn't valid, fall back to the default search mechanism
    if not path.isfile(hdf5LibPath) then
        hdf5._logger.warn("Unable to find the HDF5 lib we were built against - trying to find it elsewhere")
        hdf5LibPath = "hdf5"
    end

    local hdf5lib = ffi.load(hdf5LibPath)
    if not hdf5lib then
        error("torch-hdf5: unable to load libhdf5!")
    end
    return hdf5lib
end

function loadHDF5Header(includePath)

    -- Pass the header file through the C preprocessor once
    local headerPath = path.join(includePath, "hdf5.h")
    hdf5._logger.debug("Processing header " .. headerPath)
    if not path.isfile(headerPath) then
        error("Error: unable to locate HDF5 header file at " .. headerPath)
    end
    local process = io.popen("gcc -E " .. headerPath) -- TODO pass -I
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
end

hdf5.C = loadHDF5Library(hdf5._config.HDF5_LIBRARIES)
loadHDF5Header(hdf5._config.HDF5_INCLUDE_PATH)

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

hdf5.H5F_ACC_RDONLY = 0x0000 -- absence of rdwr => rd-only
hdf5.H5F_ACC_RDWR   = 0x0001 -- open for read and write
hdf5.H5F_ACC_TRUNC  = 0x0002 -- overwrite existing files
hdf5.H5F_ACC_EXCL   = 0x0004 -- fail if file already exists
hdf5.H5F_ACC_DEBUG  = 0x0008 -- print debug info
hdf5.H5F_ACC_CREAT  = 0x0010 -- create non-existing files


hdf5.H5P_DEFAULT = 0
hdf5.H5S_ALL = 0

function hdf5.open(filename, mode)
    if mode == 'w' then
        -- TODO more control over options?
        -- * compression
        -- * chunking
        local fileID = hdf5.C.H5Fcreate(filename, hdf5.H5F_ACC_TRUNC, hdf5.H5P_DEFAULT, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    elseif mode == 'r' then
        local fileID = hdf5.C.H5Fopen(filename, hdf5.H5F_ACC_RDWR, hdf5.H5P_DEFAULT)
        return hdf5.HDF5File(filename, fileID)
    else
        error("Unknown mode '" .. mode .. "' for hdf5.open()")
    end
end

-- This table specifies which exact format a given type of Tensor should be saved as.
local fileTypeMap = {
    ["torch.ByteTensor"] = hdf5.h5t.STD_U8BE,
    ["torch.CharTensor"] = hdf5.h5t.STD_I8BE,
    ["torch.IntTensor"] = hdf5.h5t.STD_I32BE,
    ["torch.LongTensor"] = hdf5.h5t.STD_I64BE,
    ["torch.FloatTensor"] = hdf5.h5t.IEEE_F32BE,
    ["torch.DoubleTensor"] = hdf5.h5t.IEEE_F64BE
}

function hdf5._outputTypeForTensorType(tensorType)
    return fileTypeMap[tensorType]
end

-- This table tells HDF5 what format to read a given Tensor's data into memory as.
local nativeTypeMap = {
    ["torch.ByteTensor"] = hdf5.h5t.NATIVE_UCHAR,
    ["torch.CharTensor"] = hdf5.h5t.NATIVE_SCHAR,
    ["torch.IntTensor"] = hdf5.h5t.NATIVE_INT,
    ["torch.LongTensor"] = hdf5.h5t.NATIVE_LONG,
    ["torch.FloatTensor"] = hdf5.h5t.NATIVE_FLOAT,
    ["torch.DoubleTensor"] = hdf5.h5t.NATIVE_DOUBLE,
}

function hdf5._nativeTypeForTensorType(tensorType)
    local nativeType = nativeTypeMap[tensorType]
    if nativeType == nil then
        error("Cannot find hdf5 native type for " .. tensorType)
    end
    return nativeType
end

-- This table lets us stringify HDF5 datatype classes
local classMap = {}
classMap[tonumber(hdf5.h5t.INTEGER)] = 'INTEGER'
classMap[tonumber(hdf5.h5t.FLOAT)] = 'FLOAT'
classMap[tonumber(hdf5.h5t.STRING)] = 'STRING'

function hdf5._datatypeName(typeID)
    local classID = tonumber(hdf5.C.H5Tget_class(typeID))
    local className = classMap[classID]
    if not className then
        error("Unknown class for type " .. typeID)
    end
    return className
end

function hdf5._getTorchType(typeID)
    local className = hdf5._datatypeName(typeID)
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
        error("Reading data of class " .. tostring(className) .. "(" .. typeID .. ") is unsupported")
    end
end


function hdf5._getObjectName(objectID)
    local name = ffi.new('char[255]')
    hdf5.C.H5Iget_name(objectID, name, 255)
    return ffi.string(name)
end
