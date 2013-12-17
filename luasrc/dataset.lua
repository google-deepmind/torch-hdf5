local HDF5DataSet = torch.class("hdf5.HDF5DataSet")

function HDF5DataSet:__init(parent, datasetID)
    self._parent = parent
    self._datasetID = datasetID
end

function HDF5DataSet:__tostring()
    return "[HDF5DataSet]" --  TODO  .. self:filename() ..
end

function HDF5DataSet:all()

    local typeID = hdf5.C.H5Dget_type(self._datasetID)
    local nativeType = hdf5.C.H5Tget_native_type(typeID, hdf5.C.H5T_DIR_ASCEND)
    local torchType = hdf5._getTorchType(typeID)
    if not torchType then
        error("Could not find torch type for native type " .. tostring(nativeType))
    end
    if not nativeType then
        error("Cannot find hdf5 native type for " .. torchType)
    end
    local spaceID = hdf5.C.H5Dget_space(self._datasetID)
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
    hdf5.C.H5Dread(self._datasetID, nativeType, hdf5.H5S_ALL, hdf5.H5S_ALL, hdf5.H5P_DEFAULT, dataPtr)
    return tensor

end
