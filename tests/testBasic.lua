require 'hdf5'
require 'totem'

local tester = totem.Tester()
local myTests = {}

function myTests:testBasic()
    local filename = "test.h5"
    local testData = torch.ones(4, 4)
    do
        local h = hdf5.open(filename, 'w')
        tester:assertne(h, nil, "hdf5.open returned nil")
        h:set('data', testData)
        h:close()
    end
    do
        local h = hdf5.open(filename, 'r')
        tester:assertne(h, nil, "hdf5.open returned nil")
        local got = h:get('data')
        tester:assertne(got, nil, "hdf5.get returned nil")
        tester:assertTensorEq(got, testData, 1e-16, "Data read does not match data written!")
        h:close()
    end
end

tester:add(myTests):run()
