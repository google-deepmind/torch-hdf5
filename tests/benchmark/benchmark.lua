require 'hdf5'

-- Benchmark writes

print("Size\t\t", "torch.save\t\t", "hdf5\t")
for n = 1, 27 do
    local size = math.pow(2, n)
    local data = torch.rand(size)
    local t = torch.tic()
    torch.save("out.t7", data)
    local normalTime = torch.toc(t)
    t = torch.tic()
    local hdf5file = hdf5.open("out.h5", 'w')
    hdf5file["foo"] = data
    hdf5file:close()
    local hdf5time = torch.toc(t)
    print(n, "\t", normalTime,"\t", hdf5time)
end


-- Benchmark reads

-- TODO
