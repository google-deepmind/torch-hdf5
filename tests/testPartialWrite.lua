--[[

Test partial writes

]]

require 'hdf5'
-- hdf5.debugMode() -- TODO
local path = require 'pl.path'
local tester = torch.Tester()
local testUtils = hdf5._testUtils
local myTests = {}

function myTests:testCreate()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(4, 4)
        h5file:create("data", 10, 11, options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")

        local loaded = hdf5.open(h5filename)
        local data = loaded:read("data"):all()
        tester:asserteq(data:size(1), 10, "unexpected size in first dimension")
        tester:asserteq(data:size(2), 11, "unexpected size in second dimension")
        tester:assertTensorEq(data, torch.zeros(10, 11), 1e-16, "expected zeros")

        local ones = torch.ones(2, 2)
        loaded:read("data"):write(ones, 2, 2)
        local expected = torch.zeros(10, 11)
        expected[{{2, 3}, {2, 3}}]:fill(1)
        local got = loaded:read("data"):all()
        tester:assertTensorEq(expected, got, 1e-16, "expected zeros with a block of ones")
        loaded:close()
        local reopened = hdf5.open(h5filename)
        local reloaded = reopened:read("data"):all()
        tester:assertTensorEq(expected, reloaded, 1e-16, "expected zeros with a block of ones")
        reopened:close()
    end)
end


tester:add(myTests)
tester:run()
os.exit(#tester.errors)
