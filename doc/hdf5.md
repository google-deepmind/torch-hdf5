# Notes on HDF5

## General benefits

### Portability

There are libraries for Python, R, C, C++, Matlab, and other software. The
behaviour is also be reliable and consistent across hardware platforms,
endian-ness, and so on.

### Thoroughly Tested

HDF5 is used by [a wide range of large scientific institutions](http://www.hdfgroup.org/HDF5/users5.html).

### Tools

There are already tools available for inspecting, comparing and editing HDF5 files.

### Flexible & Extensible

We can store entire collections of data and metadata in one place, and in a semantically sensible way.

### Partial I/O

We can read and write only the data that we need.

### Concurrency

Potential for concurrent I/O in future, via Parallel HDF5.

## Special Features

Transferred from [h5py docs](http://www.h5py.org/docs/high/dataset.html#special-features).

### Chunked storage

HDF5 can store data in “chunks” indexed by B-trees, as well as in the
traditional contiguous manner. This can dramatically increase I/O performance
for certain patterns of access; for example, reading every n-th element along
the fastest-varying dimension.

### Compression

Transparent lossless compression can substantially reduce the storage space
needed for the dataset. Beginning with h5py 1.1, three techniques are
available, “gzip”, “lzf” and “szip”.

### Scale/offset storage & lossy compression

HDF5 1.8 introduces compression based on truncation to a fixed number of bits
after scaling and shifting data. This can be used, for instance, to do the
following:

- Losslessly store 12-bit integer data using only 12 bits of storage per value.
- Lossily store 16-bit integer data using 12 bits of storage per value.
- Lossily store floating-point data with a fixed number of digits after the
  decimal place.

### Error-Detection

All versions of HDF5 include the fletcher32 checksum filter, which enables
read-time error detection for datasets. If part of a dataset becomes corrupted,
a read operation on that section will immediately fail with an exception.

### Resizing

Datasets can be resized, up to a maximum value provided at creation time.
