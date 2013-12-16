--[[

# torch-hdf5

Torch support for the HDF5 Hierarchical Data Format.

This format is fast and flexible, and is used by many scientific applications (Matlab, R, Python, etc)

]]

hdf5 = {}

torch.include("hdf5", "ffi.lua")

return hdf5
