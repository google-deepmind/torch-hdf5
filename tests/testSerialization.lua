--[[

Test torch serialization.

]]
require 'hdf5'

local totem = require 'totem'
local tester = totem.Tester()
local myTests = {}
local testUtils = hdf5._testUtils

-- Lua 5.2 compatibility
local unpack = unpack or table.unpack

function myTests:testSerialization()
    testUtils.withTmpDir(function(tmpDir)
        local h5filename = path.join(tmpDir, "foo.h5")
        local h5file = hdf5.open(h5filename)
        local data = torch.zeros(7, 5) 
        h5file:write("data", data)
        local memfile = torch.MemoryFile()
        memfile:binary()
        memfile:writeObject(h5file)
        local storage = memfile:storage()
        memfile:close()

        local stofile = torch.MemoryFile(storage)
        stofile:binary()
        local memh5file = stofile:readObject()
        stofile:close()
        local memdata = memh5file:read("data"):all()

        memh5file:close() 

        tester:assert(data:eq(memdata):sum() == 7*5)
    end)
end

return tester:add(myTests):run()
