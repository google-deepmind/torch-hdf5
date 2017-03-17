--[[

Test multithreaded reading using torch threads.
Required torch-threads, install with "luarocks install threads".
And hdf5 compiled with --enable-threadsafe.

]]
require 'hdf5'
local threads = require'threads'

local totem = require 'totem'
local tester = totem.Tester()
local myTests = {}
local testUtils = hdf5._testUtils

-- Lua 5.2 compatibility
local unpack = unpack or table.unpack

function myTests:testThreads()
    testUtils.withTmpDir(function(tmpDir)
        local mainfile = hdf5.open('./data/twoTensors.h5','r')
        local nthreads = 2
        local data = nil
        local worker = function(h5file)
            torch.setnumthreads(1)
            return h5file:read("data" .. __threadid):all()
        end
        local pool = threads.Threads(nthreads, function(threadid) require'torch' require'hdf5'end)
        pool:specific(true)

        for i=1,nthreads do
            pool:addjob(i, worker, function(_data) data = _data end, mainfile)
        end
        for i=1,nthreads do
            pool:dojob()
            tester:assert(data and data:size(1)==10)
        end

        mainfile:close()
    end)
end

return tester:add(myTests):run()
