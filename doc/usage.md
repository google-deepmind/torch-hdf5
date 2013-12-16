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

## Reading from Python

    TODO

## Reading from Matlab

    TODO

## Reading from R

    TODO

