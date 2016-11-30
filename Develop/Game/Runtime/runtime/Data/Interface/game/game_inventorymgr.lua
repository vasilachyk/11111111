--[[
	Game inventorymgr LUA script
--]]


-- Global instance
luaInventorymgr = {};





function luaInventorymgr:RefreshInventory()

	luaInventory:RefreshInventory();
	luaExInventory:RefreshInventory();
	
end