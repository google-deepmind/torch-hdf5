--[[

Test chunking options.

]]

require 'hdf5'
local path = require 'pl.path'
local tester = torch.Tester()
local myTests = {}
local testUtils = hdf5._testUtils

function myTests:testChunked()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(4, 4)
        h5file:write("data", torch.Tensor(7, 5), options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")
    end)
end

function myTests:testChunkedBadSize()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(4, 4, 4)
        tester:assertError(function() h5file:write("data", torch.Tensor(7, 5), options) end, "should error with dimension mismatch")
        h5file:close()
    end)
end

function myTests:testChunkedTooSmall()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(4, 4)
        h5file:write("data", torch.Tensor(2, 2), options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")
    end)
end

tester:add(myTests)
tester:run()
os.exit(#tester.errors)
