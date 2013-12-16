import h5py

f = h5py.File("test.h5", 'r')
dset = f['dset']

print(dset[...])


lua = """

require 'hdf5'

hdf5.open("in.h5", 'r')


"""

# TODO
