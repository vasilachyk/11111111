--[[
	Expo LUA script
--]]


-- Global instance
luaCharExpo = {};



function luaCharExpo:OnCharacterEvent( strMsg, sParam, nParam1, nParam2)

	if (gamefunc:IsServerModeExpo() == false) then
		return
	end
	
	-- UI event
	if ( strMsg == "UI")  then
		if ( sParam == "LOADED")  then
			btnCreateCharacter:Show( false);
			btnDeleteCharacter:Show( false);
			btnExitGame:Show(false);
			
		end
	-- Character event
	elseif ( strMsg == "CHARACTER")  then
		
	-- Character error
	elseif ( strMsg == "CHARACTER_ERROR")  then

	-- WORLD_ENTER
	elseif ( strMsg == "WORLD_ENTER")  then
	
	end

end
