require 'hdf5'
local dir = require 'pl.dir'
local pretty = require 'pl.pretty'
local path = require 'pl.path'
local stringx = require 'pl.stringx'
local myTests = {}
local totem = require 'totem'
local tester = totem.Tester()
local dataDir = path.join(path.dirname(debug.getinfo(1).source:sub(2)), "data")

local testUtils = hdf5._testUtils

local function eachReferencePair(func)
    for _, filename in ipairs(dir.getfiles(dataDir, "*.h5")) do
        local basename = path.basename(filename)
        local dirname = path.dirname(filename)
        local name, ext = path.splitext(basename)
        local luaFile = path.join(dirname, name .. ".lua")
        if not path.isfile(filename) or not path.isfile(luaFile) then
            error("Invalid reference data pair: " .. tostring(filename) .. ", " .. tostring(luaFile))
        end
        func(filename, luaFile)
    end
end

local function loadLuaData(luaFile)
    local luaFunc = loadfile(luaFile)
    if not luaFunc then
        error("Could not load lua file " .. luaFile)
    end
    local data = luaFunc()
    if not data then
        error("Got no data from lua file" .. luaFile)
    end
    return data
end

--[[ Write data to an HDF5 file and use the h5diff tool to compare the result
against a reference HDF5 file. ]]
function myTests.testAgainstReferenceWrite()
    eachReferencePair(function(h5file, luaFile)
        testUtils.withTmpDir(function(tmpDir)
            local data = loadLuaData(luaFile)
            local outPath = path.join(tmpDir, "test.h5")
            local outFile = hdf5.open(outPath, 'w')
            outFile:write("/", data)
            outFile:close()

            local diff = "h5diff -c "
            local process = io.popen(diff .. " " .. outPath .. " " .. h5file)
            local output = process:read("*all")
            process:close()


            local match = stringx.strip(output) == ""
            if not match then
                print("Expected\n========")
                os.execute("h5dump " .. h5file)
                print("Got\n===")
                os.execute("h5dump " .. outPath)
                print("h5diff output:\n" .. output)
            end
            tester:assert(match, "Mismatch for test case " .. h5file .. " / " .. luaFile)
        end)
    end)
end

--[[ Read data from a reference HDF5 file and compare it against a reference
copy of the data ]]
function myTests.testAgainstReferenceRead()
    eachReferencePair(function(h5file, luaFile)
        local data = loadLuaData(luaFile)
        local referenceFile = hdf5.open(h5file, 'r')
        local referenceData = referenceFile:all()
        local result, msg, a, b = testUtils.deepAlmostEq(referenceData, data, 1e-16)
        tester:assert(result, "data read is not the same as data written: " .. tostring(msg) .. " in "
                              .. pretty.write(a) .. " (GOT)\n-- VS --\n"
                              .. pretty.write(b) .. " (EXPECTED)\n")
    end)
end

return tester:add(myTests):run()
