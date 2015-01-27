--[[

# torch-hdf5

Torch support for the HDF5 Hierarchical Data Format.

This format is fast and flexible, and is used by many scientific applications (Matlab, R, Python, etc)

]]
local torch = require 'torch'

hdf5 = {}

local function log(msg)
    local info = debug.getinfo(1, "Sl")
    print(table.concat{info.short_src, ":", info.currentline, " ", msg})
end
hdf5._logger = {
    debug = function() end,
    warn = log,
    error = log,
}

torch.include("hdf5", "config.lua")
if not hdf5._config then
    error("Unable to find torch-hdf5 config.lua")
end

torch.include("hdf5", "ffi.lua")
torch.include("hdf5", "file.lua")
torch.include("hdf5", "dataset.lua")
torch.include("hdf5", "datasetOptions.lua")
torch.include("hdf5", "group.lua")
torch.include("hdf5", "testUtils.lua")

hdf5._debugMode = false
--[[ Call this to enable debug mode. ]]
function hdf5.debugMode()
    hdf5._debugMode = true
    hdf5._logger.debug = log
end
--[[ Return true if we are in debug mode; false otherwise ]]
function hdf5._inDebugMode()
    return hdf5._debugMode
end

--[[ Read an object from a path and wrap it in an instance of the appropriate class

Parameters:
* `parent` - wrapper object immediately above the object being loaded, in the hierarchy
* `locationID` - an HDF5 ID relative to which we are to load the object
* `datapath` - path to the object to load, relative to the given location

Returns: An HDF5Group or HDF5DataSet object

]]
function hdf5._loadObject(parent, locationID, datapath)
    local objectID = hdf5.C.H5Oopen(locationID, datapath, hdf5.H5P_DEFAULT)
    if objectID < 0 then
        error("Unable to read from '" .. datapath .. "' in " .. tostring(parent) .. " - no such data path.")
    end

    local typeID = hdf5.C.H5Iget_type(objectID)
    local status = hdf5.C.H5Oclose(objectID)
    if status < 0 then
        error("hdf5._loadObject: error closing object " .. objectID)
    end

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
