local torch = require 'torch'
local stringx = require 'pl.stringx'
local dir = require 'pl.dir'

hdf5._testUtils = {}

function hdf5._testUtils.withTmpDir(func)
    local file = io.popen("mktemp -d -t torch_hdf5_XXXXXX")
    local tmpDir = stringx.strip(file:read("*all"))
    file:close()
    func(tmpDir)
    dir.rmtree(tmpDir)
end

function hdf5._testUtils.deepAlmostEq(a, b, epsilon, msg)
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
            local result, msg, subA, subB = hdf5._testUtils.deepAlmostEq(a[k], v, epsilon, msg)
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
