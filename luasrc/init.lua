--[[

# torch-hdf5

Torch support for the HDF5 Hierarchical Data Format.

This format is fast and flexible, and is used by many scientific applications (Matlab, R, Python, etc)

]]

hdf5 = {}

require 'logroll'
hdf5._logger = logroll.print_logger()

torch.include("hdf5", "ffi.lua")
torch.include("hdf5", "file.lua")
torch.include("hdf5", "dataset.lua")
torch.include("hdf5", "group.lua")

function hdf5._loadObject(parent, locationID, datapath)
    local objectID = hdf5.C.H5Oopen(locationID, datapath, hdf5.H5P_DEFAULT)
    if objectID < 0 then
        error("Unable to read from '" .. datapath .. "' in " .. tostring(parent) .. " - no such data path.")
    end

    local typeID = hdf5.C.H5Iget_type(objectID)

    if typeID == hdf5.C.H5I_GROUP then
        local groupID = hdf5.C.H5Gopen2(locationID, datapath, hdf5.H5P_DEFAULT)
        if groupID < 0 then
            error("Unable to read group from '" .. datapath .. "' in " .. tostring(parent) .. "!")
        end
        local group = hdf5.HDF5Group(parent, groupID)
        return group
    elseif typeID == hdf5.C.H5I_DATASET then
        local datasetID = hdf5.C.H5Dopen2(locationID, datapath, hdf5.H5P_DEFAULT);
        if datasetID < 0 then
            error("Unable to read dataset from '" .. datapath .. "' in " .. tostring(parent) .. "!")
        end
        local dataset = hdf5.HDF5DataSet(parent, datasetID)
        return dataset
    else
        error("Unsupported data type at " .. datapath)
    end
end

function hdf5.debugMode()
    hdf5._logger.level = 0
end

return hdf5
