
local DataSetOptions, parent = torch.class("hdf5.DataSetOptions")

function DataSetOptions:__init()
    self._creationProperties = hdf5.C.H5Pcreate(hdf5.C.H5P_CLS_DATASET_CREATE_g)
    self._chunking = nil
end

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

function DataSetOptions:setChunked(...)
    local chunking = { ... }
    local chunkDims = ffi.new("hsize_t[" .. #chunking .. "]")
    for k, size in ipairs(chunking) do
        chunkDims[k-1] = size
    end
    hdf5.C.H5Pset_chunk(self._creationProperties, #chunking, chunkDims)
    self._chunking = chunking
    return self
end

function DataSetOptions:creationProperties()
    return self._creationProperties
end

function DataSetOptions:close()
    hdf5.H5Pclose(self._creationProperties)
end

function DataSetOptions:__tostring()
    local description = "[DataSetOptions:"
    description = description .. " chunking=" .. stringx.join("x", self._chunking)
    description = description .. "]"
    return description
end
