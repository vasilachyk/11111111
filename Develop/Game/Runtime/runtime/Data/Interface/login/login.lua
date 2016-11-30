--[[
	Login LUA script
--]]


-- Global instance
luaLogin = {};





-- OnLoginEvent : global login frame event handler
function OnLoginEvent( strMsg, sParam, nParam1, nParam2)

	if ( strMsg == "UI")  then					return luaLogin:OnEventUI( sParam, nParam1, nParam2);
	elseif ( strMsg == "LOGIN")  then			return luaLogin:OnEventLogin( sParam, nParam1, nParam2);
	elseif ( strMsg == "LOGIN_ERROR")  then		return luaLogin:OnEventLoginError( sParam, nParam1, nParam2);
	elseif ( strMsg == "WORLDLIST")  then		return luaLogin:OnEventWorldList( sParam, nParam1, nParam2);
	end

	return false;
end

-- OnEventUI
function luaLogin:OnGameDeliberation( sParam, nParam1, nParam2)

	return luaLoginFrame:OnGameDeliberation( nParam1, nParam2 );
	
end



-- OnEventUI
function luaLogin:OnEventUI( sParam, nParam1, nParam2)

	-- sParam : ENTER, LEAVE, LOADING, LOADED
	
	if ( sParam == "ENTER")  then
	
		-- Show UI
		layerLogin:Show( false);
		layerLoginFrame:Show( true);
		layerLoginLoading:Show( false);
		
		-- Change scene
		gamefunc:ChangeCampaignScene( 0);
		
		-- Initialize frame
		luaLoginFrame:InitLoginFrame();

	elseif ( sParam == "LEAVE")  then
	
		-- Show UI
--		layerLogin:Show( false);
		layerLoginFrame:Show( false);
		layerLoginLoading:Show( false);
		frmServerEnter:Show(false);		
	
	elseif ( sParam == "LOADING")  then
	
		-- Show UI
		layerLogin:Show( false);
		layerLoginFrame:Show( true);
		layerLoginLoading:Show( true);

		-- Initialize frame
		luaLoginFrame:InitLoginFrame();

	elseif ( sParam == "LOADED")  then
	
		-- Show UI
		layerLogin:Show( true);
		layerLoginFrame:Show( true);
		layerLoginLoading:Show( false);

		-- Screen fadeout
		luaLoginFrame:FadeOut();
		
		-- Update UI
		luaLoginConnect:EnterIDLogin();

	elseif ( sParam == "ID")  then
	
		-- Show UI
		layerLogin:Show( true);
		layerLoginFrame:Show( true);
		layerLoginLoading:Show( false);

		-- Screen fadeout
		luaLoginFrame:FadeOut();
		
		-- Update UI
		luaLoginConnect:EnterIDLogin();
		
	elseif ( sParam == "BEGIN")  then
	
		-- Show UI
		layerLogin:Show( true);
		layerLoginFrame:Show( true);
		layerLoginLoading:Show( false);
		
		frmLogin:Show( false);
		frmLoginBtm:Show( false);
		-- Update UI
		luaLoginConnect:EnterIDLogin();
		
	end
	
	return true;
end





-- OnEventLogin
function luaLogin:OnEventLogin( sParam, nParam1, nParam2)

	-- sParam : CONNECTED, FAILED, DISCONNECTED

	if ( sParam == "CONNECTED")  then
		local width, height = frmServerEnter:GetParent():GetSize();
		local x, y, w, h = frmServerEnter:GetRect();
		frmServerEnter:SetPosition( ( width - w) * 0.5, ( height - h) * 0.5);
		frmServerEnter:DoModal();
		
	elseif ( sParam == "FAILED")  then
		
		frmServerEnter:Show(false);		
	end		
	
	return true;
end





-- OnEventLoginError
function luaLogin:OnEventLoginError( sParam, nParam1, nParam2)

	if ( sParam == "END")  then
		frmLoginErrorMsgBox:Show( false);
	else		
		luaLoginConnect:OpenLoginErrorMsgFrame( sParam, nParam1 );
	end
	
	return true;
end





-- OnEventWorldList
function luaLogin:OnEventWorldList( sParam, nParam1, nParam2)

	if ( sParam == "REFRESH")  then  luaLoginConnect:RefreshServerList();
	end
	
	return true;
end
