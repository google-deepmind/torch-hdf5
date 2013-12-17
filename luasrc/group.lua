local HDF5Group = torch.class("hdf5.HDF5Group")

function HDF5Group:__init(parent, groupID)
    self._parent = parent
    self._groupID = groupID

    local groupInfo = hdf5.ffi.new("H5G_info_t[1]")
    local err = hdf5.C.H5Gget_info(self._groupID, groupInfo)
    if err < 0 then
        error("Failed getting group info")
    end
    local nChildren = tonumber(groupInfo[0].nlinks)

    self._children = {}

    for k = 0, nChildren-1 do
        -- TODO close after
        local objectID = hdf5.C.H5Oopen_by_idx(
                self._groupID,
                ".",
                hdf5.C.H5_INDEX_CRT_ORDER,
                hdf5.C.H5_ITER_INC,
                k,
                hdf5.H5P_DEFAULT
            )
        if objectID < 0 then
            error("Unable to open object #" .. k .. " from " .. tostring(self))
        end

        print("OPENED OBJECT", objectID)

    end
end

function HDF5Group:__tostring()
    return "[HDF5Group " .. self._groupID .. "]" --  TODO  .. self:filename() ..
end

function HDF5Group:all()
    local table = {}
    for k, v in pairs(self._children) do
        table[k] = v:all()
    end
    return table

end

function HDF5Group:close()
    -- TODO
end
