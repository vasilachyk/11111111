--[[
	Game social LUA script
--]]


-- Global instance
luaSocial = {};





-- OnShowSocialFrame
function luaSocial:OnShowSocialFrame()

	-- Show
	if ( frmSocial:GetShow() == true)  then
	
		luaParty:RefreshParty();
		luaGuild:RefreshGuild();
		
		
	-- Hide
	else
	end
	
	
	luaGame:ShowWindow( frmSocial);
end
