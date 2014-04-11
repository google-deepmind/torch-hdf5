require 'hdf5'
require 'randomkit'
local file = hdf5.open("test.h5", 'w')
local entries = 50000
local width = 200
local height = 150
local options = hdf5.DataSetOptions()
options:setChunked(1, width, height)

local dataset = file:create("/data", entries, width, height, options)
local t0 = torch.tic()

for k = 1, entries do
    local data = torch.rand(1, width, height)
    dataset:write(data, k, 1, 1)
    if k % 500 == 0 then
        print(tostring(k) .. "/" .. tostring(entries))
        collectgarbage()
    end
end

file:close()

local duration = torch.toc(t0)
print("wrote " .. tostring(entries) .. " entries")
print("duration:", duration)
print("entries/s", entries/duration)

local read_count = 250000

print("reading " .. read_count .. " random entries")
file = hdf5.open("test.h5", 'r')
dataset = file:read("/data")
t0 = torch.tic()

for k = 1, read_count do
    local index = randomkit.randint(1, entries)
    local data = dataset:partial(index, {1, width}, {1, height})
end

duration = torch.toc(t0)
print("duration:", duration)
print("entries/s", entries/duration)

