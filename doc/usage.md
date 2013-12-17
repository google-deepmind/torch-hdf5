# Getting started

## Installation

### OS X

    brew install hdf5
    luarocks install hdf5

### Ubuntu

    sudo apt-get install libhdf5-serial-dev hdf5-tools
    luarocks install hdf5

## Writing from torch

    require 'hdf5'
    local myFile = hdf5.open('/path/to/write.h5', 'w')
    myFile:write('/path/to/data', torch.rand(5, 5))
    myFile:close()

## Reading from torch

    require 'hdf5'
    local myFile = hdf5.open('/path/to/read.h5', 'r')
    myFile:read('/path/to/data'):all()
    myFile:close()

## Reading from Matlab

    h5read /path/to/file.h5 /location/of/data

See the [Matlab documentation](http://www.mathworks.co.uk/help/matlab/hdf5-files.html) for further information.

## Reading from Python

You need to install a library:

    $ pip install h5py

Then:

    import h5py
    myFile = h5py.File('/path/to/file.h5', 'r')

    # The '...' means retrieve the whole tensor
    data = myFile['location']['of']['data'][...]
    print(data)

See also the [h5py manual](http://www.h5py.org/docs/).

## Reading from R

You need to install a library:

    source("http://bioconductor.org/biocLite.R")
    biocLite("rhdf5")

Then:

    library(rhdf5)
    mydata <- h5read("/path/to/file.h5", "/location/of/data")
    str(mydata)

Alternative libraries for R include **'h5r'** and **'ncdf4'**.

## Command-line

There are also a number of handy command-line tools.

### h5ls

Lists specified features of HDF5 file contents.

### h5dump

Examine the contents of an HDF5 file and dump those contents to an ASCII file.

### h5diff

Compare two HDF5 files.

### h5copy

Copies HDF5 objects from a file to a new file

### Other

See [this page](http://www.hdfgroup.org/HDF5/doc/RM/Tools.html) for many more HDF5 tools.

## Elsewhere

Libraries for many other languages and tools exist, too. See [this list](http://en.wikipedia.org/wiki/Hierarchical_Data_Format#Interfaces) for more information.
