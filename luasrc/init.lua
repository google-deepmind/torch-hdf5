--[[

# torch-hdf5

Torch support for the HDF5 Hierarchical Data Format.

This format is fast and flexible, and is used by many scientific applications (Matlab, R, Python, etc)

]]

hdf5 = {}

require 'logroll'
hdf5._logger = logroll.print_logger()

torch.include("hdf5", "config.lua")
if not hdf5._config then
    error("Unable to find torch-hdf5 config.lua")
end

torch.include("hdf5", "ffi.lua")
torch.include("hdf5", "file.lua")
torch.include("hdf5", "dataset.lua")
torch.include("hdf5", "group.lua")

--[[ Call this to enable debug mode. ]]
function hdf5.debugMode()
    hdf5._logger.level = 0
end
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
        local dataspaceID = hdf5.C.H5Dget_space(datasetID)
        if dataspaceID < 0 then
            error("Unable to get dataspace for dataset '" .. datapath .. "' in " .. tostring(parent) .. "!")
        end
        local dataset = hdf5.HDF5DataSet(parent, datasetID, dataspaceID)
        return dataset
    else
        error("Unsupported data type at " .. datapath)
    end
end

--[[ Shorthand for [hdf5.HDF5File.open()](#hdf5.HDF5File.open). ]]
function hdf5.open(...)
    return hdf5.HDF5File.open(...)
end

return hdf5
