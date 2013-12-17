require 'hdf5'
local pretty = require 'pl.pretty'

local myTests = {}
local tester = torch.Tester()

-- TODO dedup this
local function withTmpDir(func)
    local file = io.popen("mktemp -d -t torch_hdf5_XXXXXX")
    local tmpDir = stringx.strip(file:read("*all"))
    file:close()
    func(tmpDir)
    dir.rmtree(tmpDir)
end
local function writeAndReread(location, data)
    local got
    local typeIn = type(data)
    if typeIn == 'userdata' then 
        typeIn = torch.typename(data) or typeIn
    end
    withTmpDir(function(tmpDir)
        local filename = path.join(tmpDir, "test.h5")
        local writeFile = hdf5.open(filename, 'w')
        tester:assertne(writeFile, nil, "hdf5.open returned nil")
        writeFile:write(location, data)
        writeFile:close()
        local readFile = hdf5.open(filename, 'r')
        os.execute("h5dump " .. filename)
        tester:assertne(readFile, nil, "hdf5.open returned nil")
        got = readFile:read(location):all()
        tester:assertne(got, nil, "hdf5.read returned nil")
        local typeOut = torch.typename(got) or type(got)
        tester:asserteq(typeIn, typeOut, "type read not the same as type written: was " .. typeIn .. "; is " .. typeOut)
    end)
    return got
end

local function deepAlmostEq(a, b, epsilon, msg)
    local typeA = torch.typename(a) or type(a)
    local typeB = torch.typename(b) or type(b)
    if typeA ~= typeB then
        return false, "type mismatch", a, b
    end
    if typeA == 'table' then
        for k, v in pairs(a) do
            if not b[k] then
                return false, "mismatching table keys", a, b
            end
        end
        for k, v in pairs(b) do
            if not a[k] then
                return false, "mismatching table keys", a, b
            end
            local result, msg, subA, subB
            if not result then
                return false, msg, subA, subB
            end
        end
    end
    if typeA:sub(-6, -1) == 'Tensor' then
        local diff = a:add(-b):apply(function(x) return math.abs(x) end):sum()
        if diff > epsilon then
            return false, "tensor values differ by " .. diff .. " > " .. epsilon, a, b
        end
    end

    return true
end

function myTests:testWriteTableRoot()
    local testData = { data = torch.rand(4, 6) }
    local dataPath = "/"
    print("WROTE", testData)
    local got = writeAndReread(dataPath, testData)
    print("GOT", got)
    local result, msg, a, b = deepAlmostEq(got, testData, 1e-16)
    tester:assert(result, "data read is not the same as data written: " .. msg .. " in " .. pretty.write(a) .. " (GOT)\n-- VS --\n" .. pretty.write(b) .. " (EXPECTED)\n")
end

tester:add(myTests)
tester:run()
os.exit(#tester.errors)
