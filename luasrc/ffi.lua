local torch = require 'torch'
local ffi = require 'ffi'
local bit = require 'bit'
local stringx = require 'pl.stringx'
local path = require 'pl.path'

local function loadHDF5Library(libraryPaths)
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

local function loadHDF5Header(includePath)

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

local function checkHDF5Version()
    local maj = ffi.new('unsigned int[1]')
    local min = ffi.new('unsigned int[1]')
    local rel = ffi.new('unsigned int[1]')
    hdf5.C.H5get_libversion(maj, min, rel)
    if maj[0] ~= 1 or min[0] ~= 8 then
        error("Unsupported HDF5 version: " .. maj[0] .. "." .. min[0] .. "." .. rel[0])
    end
    hdf5.version = {tonumber(maj[0]), tonumber(min[0]), tonumber(rel[0])}
    -- This is disabled as it's a bit too specific
    -- hdf5.C.H5check_version(1, 8, 12)
end
hdf5.ffi = ffi
checkHDF5Version()

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

hdf5.H5F_OBJ_FILE     = 0x0001 -- File objects
hdf5.H5F_OBJ_DATASET  = 0x0002 -- Dataset objects
hdf5.H5F_OBJ_GROUP    = 0x0004 -- Group objects
hdf5.H5F_OBJ_DATATYPE = 0x0008 -- Named datatype objects
hdf5.H5F_OBJ_ATTR     = 0x0010 -- Attribute objects
hdf5.H5F_OBJ_ALL      = bit.bor(
        hdf5.H5F_OBJ_FILE,
        hdf5.H5F_OBJ_DATASET,
        hdf5.H5F_OBJ_GROUP,
        hdf5.H5F_OBJ_DATATYPE,
        hdf5.H5F_OBJ_ATTR
    )
hdf5.H5F_OBJ_LOCAL    = 0x0020 -- Restrict search to objects opened through current file ID
                               -- (as opposed to objects opened through any file ID accessing this file)

hdf5.H5P_DEFAULT = 0
hdf5.H5S_ALL = 0
hdf5.H5F_UNLIMITED = ffi.new('hsize_t', -1)
hdf5.H5S_SELECT_SET = 0

-- This table specifies which exact format a given type of Tensor should be saved as.
local fileTypeMap = {
    ["torch.ByteTensor"] = hdf5.h5t.STD_U8LE,
    ["torch.CharTensor"] = hdf5.h5t.STD_I8LE,
    ["torch.ShortTensor"] = hdf5.h5t.STD_I16LE,
    ["torch.IntTensor"] = hdf5.h5t.STD_I32LE,
    ["torch.LongTensor"] = hdf5.h5t.STD_I64LE,
    ["torch.FloatTensor"] = hdf5.h5t.IEEE_F32LE,
    ["torch.DoubleTensor"] = hdf5.h5t.IEEE_F64LE
}

function hdf5._outputTypeForTensorType(tensorType)
    return fileTypeMap[tensorType]
end

-- This table tells HDF5 what format to read a given Tensor's data into memory as.
local nativeTypeMap = {
    ["torch.ByteTensor"] = hdf5.h5t.NATIVE_UCHAR,
    ["torch.CharTensor"] = hdf5.h5t.NATIVE_SCHAR,
    ["torch.ShortTensor"] = hdf5.h5t.NATIVE_SHORT,
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
classMap[tonumber(hdf5.h5t.NO_CLASS)] =  'NO_CLASS'
classMap[tonumber(hdf5.h5t.INTEGER)] =   'INTEGER'
classMap[tonumber(hdf5.h5t.FLOAT)] =     'FLOAT'
classMap[tonumber(hdf5.h5t.TIME)] =      'TIME'
classMap[tonumber(hdf5.h5t.STRING)] =    'STRING'
classMap[tonumber(hdf5.h5t.BITFIELD)] =  'BITFIELD'
classMap[tonumber(hdf5.h5t.OPAQUE)] =    'OPAQUE'
classMap[tonumber(hdf5.h5t.COMPOUND)] =  'COMPOUND'
classMap[tonumber(hdf5.h5t.REFERENCE)] = 'REFERENCE'
classMap[tonumber(hdf5.h5t.ENUM)] =      'ENUM'
classMap[tonumber(hdf5.h5t.VLEN)] =      'VLEN'
classMap[tonumber(hdf5.h5t.ARRAY)] =     'ARRAY'
classMap[tonumber(hdf5.h5t.NCLASSES)] =  'NCLASSES'

local typeMap = {}

typeMap[tonumber(hdf5.C.H5I_UNINIT)] =      'UNINIT' -- uninitialized type
typeMap[tonumber(hdf5.C.H5I_BADID)] =       'BADID'    -- invalid Type
typeMap[tonumber(hdf5.C.H5I_FILE)] =        'FILE'    -- type ID for File objects
typeMap[tonumber(hdf5.C.H5I_GROUP)] =       'GROUP'          -- type ID for Group objects
typeMap[tonumber(hdf5.C.H5I_DATATYPE)] =    'DATATYPE'          -- type ID for Datatype objects
typeMap[tonumber(hdf5.C.H5I_DATASPACE)] =   'DATASPACE'          -- type ID for Dataspace objects
typeMap[tonumber(hdf5.C.H5I_DATASET)] =     'DATASET'          -- type ID for Dataset objects
typeMap[tonumber(hdf5.C.H5I_ATTR)] =        'ATTR'          -- type ID for Attribute objects
typeMap[tonumber(hdf5.C.H5I_REFERENCE)] =   'REFERENCE '          -- type ID for Reference objects
typeMap[tonumber(hdf5.C.H5I_VFL)] =         'VFL'          -- type ID for virtual file layer
typeMap[tonumber(hdf5.C.H5I_GENPROP_CLS)] = 'GENPROP_CLS'          -- type ID for generic property list classes
typeMap[tonumber(hdf5.C.H5I_GENPROP_LST)] = 'GENPROP_LST'          -- type ID for generic property lists
typeMap[tonumber(hdf5.C.H5I_ERROR_CLASS)] = 'ERROR_CLASS'          -- type ID for error classes
typeMap[tonumber(hdf5.C.H5I_ERROR_MSG)] =   'ERROR_MSG'          -- type ID for error messages
typeMap[tonumber(hdf5.C.H5I_ERROR_STACK)] = 'ERROR_STACK'          -- type ID for error stacks
typeMap[tonumber(hdf5.C.H5I_NTYPES)] =      'NTYPES'           -- number of library types, MUST BE LAST!

function hdf5._datatypeName(typeID)
    local classID = tonumber(hdf5.C.H5Tget_class(typeID))
    local className = classMap[classID]
    if not className then
        error("Unknown class for type " .. tostring(typeID))
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
        if size == 2 then
            return 'torch.ShortTensor'
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

function hdf5._getObjectType(objectID)
    local typeID = hdf5.C.H5Iget_type(objectID)
    if typeID == hdf5.C.H5I_BADID then
        error("Error getting type for object " .. objectID)
    end
    if typeID == hdf5.C.H5I_DATATYPE then
        return "DATATYPE (" .. hdf5._datatypeName(typeID) .. ")"
    end
    local typeName = typeMap[tonumber(typeID)]
    if not typeName then
        error("Could not get name for type " .. tostring(typeID))
    end
    return typeName
end

function hdf5._describeObject(objectID)
    return "(" .. tostring(objectID) .. " "
           .. hdf5._getObjectName(objectID) .. " "
           .. hdf5._getObjectType(objectID) .. ")"
end

hdf5.H5Z_FILTER_ERROR       = -1      -- no filter
hdf5.H5Z_FILTER_NONE        = 0       -- reserved indefinitely
hdf5.H5Z_FILTER_DEFLATE     = 1       -- deflation like gzip
hdf5.H5Z_FILTER_SHUFFLE     = 2       -- shuffle the data
hdf5.H5Z_FILTER_FLETCHER32  = 3       -- fletcher32 checksum of EDC
hdf5.H5Z_FILTER_SZIP        = 4       -- szip compression
hdf5.H5Z_FILTER_NBIT        = 5       -- nbit compression
hdf5.H5Z_FILTER_SCALEOFFSET = 6       -- scale+offset compression
hdf5.H5Z_FILTER_RESERVED    = 256     -- filter ids below this value are reserved for library use
hdf5.H5Z_FILTER_MAX         = 65535   -- maximum filter id
hdf5.H5Z_FILTER_CONFIG_ENCODE_ENABLED = 0x0001
hdf5.H5Z_FILTER_CONFIG_DECODE_ENABLED = 0x0002

function hdf5._fletcher32Available()
    local avail = hdf5.C.H5Zfilter_avail(hdf5.H5Z_FILTER_FLETCHER32)
    if tonumber(avail) ~= 1 then
        hdf5._logger.warn("Fletcher32 filter not available.")
        return false
    end
    local filterInfo = ffi.new('unsigned int[1]')
    local status = hdf5.C.H5Zget_filter_info (hdf5.H5Z_FILTER_FLETCHER32, filterInfo)
    if bit.band(filterInfo[0], hdf5.H5Z_FILTER_CONFIG_ENCODE_ENABLED) == 0 or
         bit.band(filterInfo[0], hdf5.H5Z_FILTER_CONFIG_DECODE_ENABLED) == 0 then
        hdf5._logger.warn("Fletcher32 filter not available for encoding and decoding.\n")
        return false
    end
    return true
end

function hdf5._deflateAvailable()
    local avail = hdf5.C.H5Zfilter_avail(hdf5.H5Z_FILTER_DEFLATE)
    if tonumber(avail) ~= 1 then
        hdf5._logger.warn("Deflate filter not available.")
        return false
    end
    return true
end
