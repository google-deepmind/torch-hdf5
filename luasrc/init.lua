--[[

# torch-hdf5

Torch support for the HDF5 Hierarchical Data Format.

This format is fast and flexible, and is used by many scientific applications (Matlab, R, Python, etc)

]]

hdf5 = {}

require 'logroll'
hdf5._logger = logroll.print_logger()

torch.include("hdf5", "ffi.lua")

function hdf5.debugMode()
    hdf5._logger.level = 0
end

return hdf5
