--[[

Test chunking options.

]]
require 'hdf5'

local path = require 'pl.path'
local totem = require 'totem'
local tester = totem.Tester()
local myTests = {}
local testUtils = hdf5._testUtils

-- Lua 5.2 compatibility
local unpack = unpack or table.unpack

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

function myTests:testChunkedAppend()
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

        -- write the initial data
        h5file:write("data", data, options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")

        -- reopen and verify that the original data is present
        local h5readFile = hdf5.open(h5filename)
        do
            local selection = { 3, { 1, 4 } }
            local read = h5readFile:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read:resize(4), data[selection], 1e-16, "Partial read returned wrong data")
        end
        h5readFile:close()

        -- reopen and verify that the original data is present
        local h5rwFile = hdf5.open(h5filename, 'r+')

        local appendData = torch.zeros(13, 13)
        local k = 13 * 13
        appendData:apply(function(x)
            k = k + 1
            return k
        end)

        -- append data to the file
        h5rwFile:append("data", appendData, options)

        local function ensureBothOldAndNewData(file)
          do --- ensure old data
            local selection = { 3, { 1, 4 } }
            local read = file:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read:resize(4), data[selection], 1e-16, "Partial read returned wrong data")
          end

          do --- ensure new data
            local selection = { 16, { 1, 4 } }
            local read = file:read("data"):partial(unpack(selection))
            tester:assertTensorEq(read:resize(4), appendData[{3, {1, 4}}], 1e-16, "Partial read returned wrong data")
          end
        end

        -- make sure our old and new data is present
        ensureBothOldAndNewData(h5rwFile)
        h5rwFile:close()

        -- reopen to make sure it's still there
        local h5readFile2 = hdf5.open(h5filename)
        ensureBothOldAndNewData(h5readFile2)
        h5readFile2:close()
    end)
end


return tester:add(myTests):run()
