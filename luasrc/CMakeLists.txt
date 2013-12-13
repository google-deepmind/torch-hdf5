# install the lua code for the hdf5 package
FILE(GLOB luasrc "*.lua")
ADD_TORCH_PACKAGE(hdf5 "" "${luasrc}")
