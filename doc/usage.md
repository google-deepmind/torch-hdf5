# Getting started

## Installation

**** Please note: the central luarocks server has another package called hdf5 (http://colberg.org/lua-hdf5/) - if you use 'luarocks install' you may get that one instead. ****

**** Please note also: torch-hdf5 now requires version 1.8.14 or greater of hdf5! ****

### OS X

    brew tap homebrew/science
    brew install hdf5
    git clone git@github.com:deepmind/torch-hdf5.git
    cd torch-hdf5
    luarocks make hdf5-0-0.rockspec

Note: if `luarocks make` fails with an unsatisfied dependency, the luarocks being used is likely not the one provided by torch. Try using `[torch install directory]/install/bin/luarocks` instead.

### Ubuntu < 13.04

    sudo apt-get install libhdf5-serial-dev hdf5-tools
    git clone git@github.com:deepmind/torch-hdf5.git
    cd torch-hdf5
    luarocks make hdf5-0-0.rockspec

### Ubuntu >= 13.04

    sudo apt-get install libhdf5-serial-dev hdf5-tools
    git clone git@github.com:deepmind/torch-hdf5.git
    cd torch-hdf5
    luarocks make hdf5-0-0.rockspec LIBHDF5_LIBDIR="/usr/lib/x86_64-linux-gnu/"

## Writing from torch

    require 'hdf5'
    local myFile = hdf5.open('/path/to/write.h5', 'w')
    myFile:write('/path/to/data', torch.rand(5, 5))
    myFile:close()

## Reading from torch

    require 'hdf5'
    local myFile = hdf5.open('/path/to/read.h5', 'r')
    local data = myFile:read('/path/to/data'):all()
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

## More advanced usage

### Compression, chunking, and other options

You can optionally pass a `DataSetOptions` object to specify how you want data to be written:

    require 'hdf5'
    local myFile = hdf5.open('/path/to/write.h5', 'w')
    local options = hdf5.DataSetOptions()
    options:setChunked(32, 32)
    options:setDeflate()
    myFile:write('/path/to/data', torch.rand(500, 500), options)
    myFile:close()

### Partial reading

You can read from a dataset without loading the whole thing at once:

    local myFile = hdf5.open('/path/to/read.h5','r')
    -- Specify the range for each dimension of the dataset.
    local data = myFile:read('/path/to/data'):partial({start1, end1}, {start2, end2})
    myFile:close()
    
Note that, for efficiency, hdf5 may still load (but not return) more than just the piece you ask for - depending on what options the file was written with. For example, if the dataset is chunked, it should just load the chunks that overlap with the part you ask for.

### Size of the data

Getting the size of the dataset without loading the data:
	
    local myFile = hdf5.open('/path/to/read.h5','r')
    local dim = myFile:read('/path/to/data'):dataspaceSize()
    myFile:close()

### Tensor Type of the data

Checking the type of torch.Tensor without loading the data:
	
    local myFile = hdf5.open('/path/to/read.h5','r')
    local factory = myFile:read('/path/to/data'):getTensorFactory()
    myFile:close()

## Command-line

There are also a number of handy command-line tools.

### h5ls

Lists specified features of HDF5 file contents.

### h5dump

Examine the contents of an HDF5 file and dump those contents to an ASCII file.

### h5diff

Compare two HDF5 files.

### h5copy

Copies HDF5 objects from a file to a new file

### Other

See [this page](http://www.hdfgroup.org/HDF5/doc/RM/Tools.html) for many more HDF5 tools.

## Elsewhere

Libraries for many other languages and tools exist, too. See [this list](http://en.wikipedia.org/wiki/Hierarchical_Data_Format#Interfaces) for more information.

## Thread-safety

If you want to use HDF5 from multiple threads, you will need a thread-safe build of the underlying HDF5 library. Otherwise, you will get random crashes. See the [HDF5 docs](https://www.hdfgroup.org/hdf5-quest.html#tsafe) for how to build a thread-safe version.
