require 'hdf5'
require 'totem'
local path = require 'pl.path'

local tester = totem.Tester()
local myTests = {}

local function withTmpDir(func)
    local file = io.popen("mktemp -d -t torch_hdf5_XXXXXX")
    local tmpDir = stringx.strip(file:read("*all"))
    file:close()
    func(tmpDir)
    dir.rmtree(tmpDir)
end

local function writeAndReread(data)
    local got
    withTmpDir(function(tmpDir)
        local filename = path.join(tmpDir, "test.h5")
        local writeFile = hdf5.open(filename, 'w')
        tester:assertne(writeFile, nil, "hdf5.open returned nil")
        writeFile:set('data', data)
        writeFile:close()
        local readFile = hdf5.open(filename, 'r')
        os.execute("h5dump " .. filename)
        tester:assertne(readFile, nil, "hdf5.open returned nil")
        got = readFile:get('data')
        tester:assertne(got, nil, "hdf5.get returned nil")
    end)
    return got
end

local function intTensorEqual(a, b)
    if torch.typename(a) ~= 'torch.IntTensor' or torch.typename(b) ~= 'torch.IntTensor' then
        error("Expected two tensors; got " .. torch.typename(a) .. ", " .. torch.typename(b))
    end
    return a:add(-b):apply(function(x) return math.abs(x) end):sum() == 0
end

function myTests:testIntTensor()
    local k = 0
    local testData = torch.IntTensor(4, 6):apply(function() k = k + 1; return k end)
    local got = writeAndReread(testData)
    tester:assert(intTensorEqual(got, testData), "Data read does not match data written!")
end

--[[
function myTests:testFloatTensor()
    local k = 0
    local testData = torch.IntTensor(4, 6):apply(function() k = k + math.pi; return k end)
    local got = writeAndReread(testData)
    tester:assertTensorEq(got, testData, 1e-32, "Data read does not match data written!")
end
]]

--[[
function myTests:testDoubleTensor()
    local k = 0
    local testData = torch.IntTensor(4, 6):apply(function() k = k + math.pi; return k end)
    local got = writeAndReread(testData)
    tester:assertTensorEq(got, testData, 1e-32, "Data read does not match data written!")
end

--]]
tester:add(myTests):run()
