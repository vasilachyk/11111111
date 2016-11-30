--[[
	Game GMEtc LUA script
--]]


-- Global instance
luaGMEtc = {};

-- ShowGMEtcTab
function luaGMEtc:ShowGMEtcTab()
	
	--gamedebug:Log( "Å×½ºÆ®" );
	
	pnlEtcMain:Show( true );
	pnlEtcInfoBase:Show( true );
	
end

-- HideGMEtcTab
function luaGMEtc:HideGMEtcTab()
	
	pnlEtcMain:Show( false );
	pnlEtcInfoBase:Show( false );
	
end
