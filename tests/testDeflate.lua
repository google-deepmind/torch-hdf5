--[[

Test with DEFLATE compression filter.

]]
require 'hdf5'
local path = require 'pl.path'
local totem = require 'totem'
local tester = totem.Tester()
local myTests = {}
local testUtils = hdf5._testUtils

function getFileSize(filePath)
    local file = io.open(filePath, 'r')
    local size = file:seek("end")
    file:close()
    return size
end

function myTests:testDeflate()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local options = hdf5.DataSetOptions()
        options:setChunked(128, 128)
        options:setDeflate()
        h5file:write("data", torch.zeros(2000, 2000), options)
        h5file:close()
        tester:assert(path.isfile(h5filename), "file should exist")
        local size = getFileSize(h5filename)
        tester:assertlt(size, 100000, "writing zero tensor with deflate should produce a small file")
    end)
end

return tester:add(myTests):run()
