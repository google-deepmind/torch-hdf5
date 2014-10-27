--[[

Test chunking options.

]]

require 'hdf5'
local path = require 'pl.path'
local totem = require 'totem'
local tester = totem.Tester()
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

function myTests:testReadPartial()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(4, 4)
        local data = torch.zeros(13, 13)
        local k = 0
        data:apply(function(x)
            k = k + 1
            return k
        end)
        h5file:write("data", data, options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")
        local h5readFile = hdf5.open(h5filename, 'r')
        do
            local selection = { 3, { 1, 4 } }
            local read = h5readFile:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read:resize(4), data[selection], 1e-16, "Partial read returned wrong data")
        end
        do
            local selection = { {1, 13}, { 1, 13 } }
            local read = h5readFile:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read, data[selection], 1e-16, "Partial read returned wrong data")
        end
        do
            local selection = { {12, 13}, { 1, 6 } }
            local read = h5readFile:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read, data[selection], 1e-16, "Partial read returned wrong data")
        end
        do
            local selection = { 13, 13 }
            local read = h5readFile:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read, torch.Tensor{{data[selection]}}, 1e-16, "Partial read returned wrong data")
        end
        do
            local selection = { 13, 13, 1 }
            tester:assertError(function()
                h5readFile:read("data"):partial(unpack(selection))
            end, "should error on bad selection")
        end
        do
            local selection = { 1 }
            tester:assertError(function()
                h5readFile:read("data"):partial(unpack(selection))
            end, "should error on bad selection")
        end
    end)
end

tester:add(myTests):run()
