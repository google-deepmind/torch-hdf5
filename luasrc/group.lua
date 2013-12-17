local HDF5Group = torch.class("hdf5.HDF5Group")

function HDF5Group:__init(parent, groupID)
    assert(parent)
    assert(groupID)
    self._parent = parent
    self._groupID = groupID

    hdf5._logger.debug("Creating HDF5Group with name: " .. hdf5._getObjectName(groupID))

    local groupInfo = hdf5.ffi.new("H5G_info_t[1]")
    local err = hdf5.C.H5Gget_info(self._groupID, groupInfo)
    if err < 0 then
        error("Failed getting group info")
    end
    local nChildren = tonumber(groupInfo[0].nlinks)

    -- Create a wrapper object for each child of this group
    self._children = {}
    hdf5.C.H5Literate(
            self._groupID,
            hdf5.C.H5_INDEX_NAME,
            hdf5.C.H5_ITER_NATIVE,
            ffi.new("hsize_t *"),
            function(baseGroupID, linkName, linkInfo, data)
                linkName = ffi.string(linkName)
                self._children[linkName] = hdf5._loadObject(self, baseGroupID, linkName)
                return 0
            end,
            ffi.new("void *")
        )
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
    -- close this group and all children
end
