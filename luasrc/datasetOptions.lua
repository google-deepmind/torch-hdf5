--[[

Object for specifying HDF5 options to use with a dataset.

]]
local torch = require 'torch'
local stringx = require 'pl.stringx'

-- Lua 5.2 compatibility
local unpack = unpack or table.unpack

local DataSetOptions, parent = torch.class("hdf5.DataSetOptions")

--[[ Constructor. No parameters.

Example:

    options = hdf5.DataSetOptions()
    options:setChunking(32, 32, 32)
    options:setDeflate()

Returns: new DataSetOptions object
]]
function DataSetOptions:__init()
    if hdf5.version[1] >= 1 and hdf5.version[2] >= 8 and hdf5.version[3] >= 14 then
       self._creationProperties = hdf5.C.H5Pcreate(hdf5.C.H5P_CLS_DATASET_CREATE_ID_g)
    else
       self._creationProperties = hdf5.C.H5Pcreate(hdf5.C.H5P_CLS_DATASET_CREATE_g)
    end
    self._chunking = nil
end

--[[ Modify the options, if necessary, to make them compatible with the given data ]]
function DataSetOptions:adjustForData(tensor)
    if self._chunking then
        if #self._chunking ~= tensor:nDimension() then
            error("Chunk size must have same number of dimensions as data! Chunk size has "
            .. tostring(#self._chunking) .. " dimensions; data has " .. tensor:nDimension())
        end

        -- If the data is smaller than the specified chunk size, make the chunk
        -- smaller in that dimension
        for k, size in ipairs(self._chunking) do
            local tensorSize = tensor:size(k)
            if self._chunking[k] > tensorSize then
                self._chunking[k] = tensorSize
            end
        end
        self:setChunked(unpack(self._chunking))
    end
end

--[[ Use chunked mode for writing data. Must be enabled to use compression and
other filters, or for efficient partial I/O. By default, chunking is disabled.

You must specify the chunk size to use. This can have a significant effect on
performance. In particular, using too small a chunk size relative to the data
will slow things down a lot.

Parameters:
 * `size1` - size in first dimension
 * `size2` - size in second dimension, if appropriate
 * `size3` - size in third dimension, if appropriate
 * `...` - more sizes, as needed

You should provide as many sizes as there are dimensions in your data.

Returns:
`self` - the modified DataSetOptions object is returned, thus allowing for chaining of method calls

]]
function DataSetOptions:setChunked(...)
    local chunking = { ... }
    local chunkDims = hdf5.ffi.new("hsize_t[" .. #chunking .. "]")
    for k, size in ipairs(chunking) do
        chunkDims[k-1] = size
    end
    hdf5.C.H5Pset_chunk(self._creationProperties, #chunking, chunkDims)
    self._chunking = chunking
    return self
end

--[[ Use the DEFLATE algorithm (zlib) to compress chunks of data

Parameters:
 * `level` - level of compression to apply (1-10) [default 6]

Returns:
`self` - the modified DataSetOptions object is returned, thus allowing for chaining of method calls

]]
function DataSetOptions:setDeflate(level)
    level = level or 6
    if not hdf5._deflateAvailable() then
        error("DataSetOptions:setDeflate() - DEFLATE is not available, with your build of HDF5")
    end
    hdf5.C.H5Pset_deflate(self._creationProperties, level)
    return self
end

function DataSetOptions:creationProperties()
    return self._creationProperties
end

--[[ Close the DataSetOptions object. This should be done after use to free resources. ]]
function DataSetOptions:close()
    hdf5.H5Pclose(self._creationProperties)
end

function DataSetOptions:__tostring()
    local description = "[DataSetOptions:"
    description = description .. " chunking=" .. (self._chunking and stringx.join("x", self._chunking) or "none")
    description = description .. "]"
    return description
end
