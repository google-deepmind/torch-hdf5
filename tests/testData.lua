--[[

Tests for correctness of data writing & reading.

]]

require 'hdf5'
local dir = require 'pl.dir'
local path = require 'pl.path'
local stringx = require 'pl.stringx'

local tester = torch.Tester()
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
    local typeIn = torch.typename(data)
    withTmpDir(function(tmpDir)
        local filename = path.join(tmpDir, "test.h5")
        local writeFile = hdf5.open(filename, 'w')
        tester:assertne(writeFile, nil, "hdf5.open returned nil")
        writeFile:write('data', data)
        writeFile:close()
        local readFile = hdf5.open(filename, 'r')
        os.execute("h5dump " .. filename)
        tester:assertne(readFile, nil, "hdf5.open returned nil")
        got = readFile:read('data'):all()
        tester:assertne(got, nil, "hdf5.read returned nil")
        local typeOut = torch.typename(got)
        tester:asserteq(typeIn, typeOut, "type read not the same as type written: was " .. typeIn .. "; is " .. typeOut)
    end)
    return got
end

local function intTensorEqual(typename, a, b)
    if torch.typename(a) ~= typename or torch.typename(b) ~= typename then
        error("Expected two tensors of type " .. typename .. "; got " .. torch.typename(a) .. ", " .. torch.typename(b))
    end
    return a:add(-b):apply(function(x) return math.abs(x) end):sum() == 0
end

--[[ Not supported yet
function myTests:testCharTensor()
    local k = 0
    local testData = torch.CharTensor(4, 6):apply(function() k = k + 1; return k end)
    local got = writeAndReread(testData)
    tester:assert(intTensorEqual("torch.CharTensor", got, testData), "Data read does not match data written!")
end
]]

function myTests:testByteTensor()
    local k = 0
    local testData = torch.ByteTensor(4, 6):apply(function() k = k + 1; return k end)
    local got = writeAndReread(testData)
    tester:assert(intTensorEqual("torch.ByteTensor", got, testData), "Data read does not match data written!")
end

function myTests:testIntTensor()
    local k = 0
    local testData = torch.IntTensor(4, 6):apply(function() k = k + 1; return k end)
    local got = writeAndReread(testData)
    tester:assert(intTensorEqual("torch.IntTensor", got, testData), "Data read does not match data written!")
end

function myTests:testFloatTensor()
    local k = 0
    local testData = torch.FloatTensor(4, 6):apply(function() k = k + math.pi; return k end)
    testData:div(7)
    local got = writeAndReread(testData)
    tester:assertTensorEq(got, testData, 1e-32, "Data read does not match data written!")
end

function myTests:testDoubleTensor()
    local k = 0
    local testData = torch.DoubleTensor(4, 6):apply(function() k = k + math.pi; return k end)
    testData:div(7)
    local got = writeAndReread(testData)
    tester:assertTensorEq(got, testData, 1e-32, "Data read does not match data written!")
end
tester:add(myTests)
tester:run()
os.exit(#tester.errors)
