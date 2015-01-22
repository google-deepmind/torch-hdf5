package = 'hdf5'
version = '0-0'

source = {
   url = 'git://github.com/d11/torch-hdf5.git',
   branch = 'master'
}

description = {
  summary = "Interface to HDF5 library",
  homepage = "http://d11.github.io/torch-hdf5",
  detailed = "Read and write Torch tensor data to and from Hierarchical Data Format files.",
  license = "BSD",
  maintainer = "Dan Horgan <danhgn+github@gmail.com>"
}

dependencies = { 'torch >= 7.0', 'penlight', 'totem' }
build = {
   type = "command",
   build_command = [[
cmake -E make_directory build;
cd build;
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)"; 
$(MAKE)
   ]],
   install_command = "cd build && $(MAKE) install"
}
