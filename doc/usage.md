# Getting started

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

## Reading from Python

You need to install a library:

    $ pip install h5py

Then:

    import h5py
    myFile = h5py.File('/path/to/file.h5', 'r')

    # The '...' means retrieve the whole tensor
    data = myFile['location']['of']['data'][...]
    print(data)

## Reading from R

You need to install a library:

    source("http://bioconductor.org/biocLite.R")
    biocLite("rhdf5")

Then:

    library(rhdf5)
    mydata <- h5read("/path/to/file.h5", "/location/of/data")
    str(mydata)

Alternative libraries for R include 'h5r' and 'ncdf4'.

## Elsewhere

Libraries for many other languages and tools exist, too. See [this list](http://en.wikipedia.org/wiki/Hierarchical_Data_Format#Interfaces) for more information.
