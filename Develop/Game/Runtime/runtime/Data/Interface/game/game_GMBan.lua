--[[
	Game GMBan LUA script
--]]


-- Global instance
luaGMBan = {};

-- ShowGMBanTab
function luaGMBan:ShowGMBanTab()
	
	--gamedebug:Log( "Å×½ºÆ®" );
	
	pnlBanMain:Show( true );
	pnlBanInfoBase:Show( true );
	
end

-- HideGMBanTab
function luaGMBan:HideGMBanTab()
	
	pnlBanMain:Show( false );
	pnlBanInfoBase:Show( false );
	
end
