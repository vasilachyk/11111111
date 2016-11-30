--[[
	Character LUA script
--]]


-- Global instance
luaCharacter = {};






-- OnCharacterEvent : global character frame event handler
function OnCharacterEvent( strMsg, sParam, nParam1, nParam2)

	-- GStar ³¡³ª¸é Æó±âµÊ
	--luaCharExpo:OnCharacterEvent( strMsg, sParam, nParam1, nParam2);
	-- GStar ³¡³ª¸é Æó±âµÊ

	-- UI event
	if ( strMsg == "UI")  then								return luaCharacter:OnEventUI( sParam, nParam1, nParam2);
	
	-- Character event
	elseif ( strMsg == "CHARACTER")  then					return luaCharacter:OnEventCharacter( sParam, nParam1, nParam2);
	
	-- Character error
	elseif ( strMsg == "CHARACTER_ERROR")  then				return luaCharacter:OnEventCharacterError( sParam, nParam1, nParam2, 1 );
	
	-- Character Net error
	elseif ( strMsg == "CHARACTER_NET_ERROR")  then			return luaCharacter:OnEventCharacterError( sParam, nParam1, nParam2, 0 );

	-- WORLD_ENTER
	elseif ( strMsg == "WORLD_ENTER")  then					return luaCharacter:OnEventWorldEnter( sParam, nParam1, nParam2);

	-- MODEL_LOADING
	elseif ( strMsg == "MODEL_LOADING")  then				return luaCharacter:OnEventModelLoading( sParam, nParam1, nParam2);

	elseif ( strMsg == "PC_CAFE") then						return luaCharacter:OnPcCafeLogin(sParam, nParam1, nParam2);
	
	elseif ( strMsg == "NOTICE") then						return luaCharacter:OnNotice( sParam, nParam1, nParam2 );
	
	elseif ( strMsg == "GAMEDELIBERATION") then				return luaCharacter:OnGameDeliberation( sParam, nParam1, nParam2 );
		
	
	end


	return false;
end

-- OnNotice
function luaCharacter:OnGameDeliberation( sParam, nParam1, nParam2 )
	
	return luaCharacterFrame:OnGameDeliberation( nParam1, nParam2 );
		
end

-- OnNotice
function luaCharacter:OnNotice( sParam, nParam1, nParam2 )
	
	pCharPresentation:Add( sParam, nParam2 );
	return true;
		
end



-- OnEventUI
function luaCharacter:OnEventUI( sParam, nParam1, nParam2)

	-- sParam : ENTER, LEAVE, LOADING, LOADED

	if ( sParam == "ENTER")  then
	
		-- Show UI
		layerCharSelect:Show( false);
		layerCharCreate:Show( false);
		layerCharCredit:Show( false);
		layerCharFrame:Show( true);

        -- Get random seed
		math.randomseed( os.time());
		
		-- Initialize frame
		luaCharacterFrame:InitCharFrame();

	elseif ( sParam == "LEAVE")  then

		-- Show UI
		layerCharSelect:Show( false);
		layerCharCreate:Show( false);
		layerCharFrame:Show( false);
		layerCharCredit:Show( false);

	elseif ( sParam == "LOADING")  then
		
		-- Show UI
		layerCharSelect:Show( false);
		layerCharCreate:Show( false);
		layerCharFrame:Show( true);
		layerCharCredit:Show( false);

		-- Initialize frame
		luaCharacterFrame:InitCharFrame();

	elseif ( sParam == "LOADED")  then
	
		-- Show UI
		layerCharSelect:Show( false);
		layerCharCreate:Show( false);
		layerCharFrame:Show( true);
		layerCharCredit:Show( false);
	
		-- Update UI
		luaCharacterFrame:SwitchScene( luaCharacter.SwitchToCharSelect);
	end

	
	return true;
end





-- OnEventCharacter
function luaCharacter:OnEventCharacter( sParam, nParam1, nParam2)

	-- sParam : REFRESH, CREATE
	-- nParam1 : Error code
	
	if ( sParam == "REFRESH")  then			luaCharacterSelect:RefreshCharacter();
	elseif ( sParam == "CREATE")  then		luaCharacterCreate:OnEventCreateCharacter( nParam1, nParam2);
	end
	
	return true;
end





-- OnEventCharacterError( Quit = 0 )
function luaCharacter:OnEventCharacterError( sParam, nParam1, nParam2, Quit )

	tvwCharacterErrorMsg:SetText( sParam);
	btnCharacterErrorOk:SetUserData( Quit );
		
	frmCharacterErrorMsgBox:DoModal();
		
	return true;
end





function luaCharacter:OnEventWorldEnter( sParam, nParam1, nParam2)

	if ( sParam == "SHOW")  then
	
		local width, height = frmWorldEnter:GetParent():GetSize();
		local x, y, w, h = frmWorldEnter:GetRect();
		frmWorldEnter:SetPosition( ( width - w) * 0.5, ( height - h) * 0.5);
		frmWorldEnter:DoModal();
		
	elseif ( sParam == "HIDE")  then
	
		frmWorldEnter:Show( false);
		
	elseif ( sParam == "PROGRESS_MSG" ) then
		
		local msg = gamefunc:GetResultString( nParam1 );
		labWorldEnterProgressMsg:SetText( msg );
		
	end
	
	return true;
end



function luaCharacter:OnEventModelLoading( sParam, nParam1, nParam2)

		if ( sParam == "SHOW")  then
	
		local width, height = frmModelLoading:GetParent():GetSize();
		local x, y, w, h = frmModelLoading:GetRect();
		frmModelLoading:SetPosition( ( width - w) * 0.5, ( height - h) * 0.5);
		frmModelLoading:Show( true );
		
	elseif ( sParam == "HIDE")  then
	
		frmModelLoading:Show( false);
		
	elseif ( sParam == "PROGRESS_MSG" ) then
		
		local msg = gamefunc:GetResultString( nParam1 );
		labModelLoadingProgressMsg:SetText( msg );
		
	end
	
end



-- SwitchToCharSelect
function luaCharacter:SwitchToCharSelect()

	layerCharSelect:Enable( true);
	layerCharSelect:Show( true);
	layerCharCreate:Enable( false);
	layerCharCreate:Show( false);
	layerCharCredit:Enable( false);
	layerCharCredit:Show( false);
	pnlCharCredit:Show( false );

	luaCharacterSelect:EnterCharSel();
	
	luaCharacterCreate:LeaveCharCreate();
	luaCredit:LeaveCredit();
	
end





-- SwitchToCharCreate
function luaCharacter:SwitchToCharCreate()

	layerCharSelect:Enable( false);
	layerCharSelect:Show( false);
	layerCharCreate:Enable( true);
	layerCharCreate:Show( true);

	luaCharacterSelect:LeaveCharSel();
	luaCredit:LeaveCredit();
	
	luaCharacterCreate:EnterCharCreate();
	
end





-- SwitchToLogin
function luaCharacter:SwitchToLogin()

	layerCharSelect:Enable( false);
	layerCharSelect:Show( false);
	layerCharCreate:Enable( false);
	layerCharCreate:Show( false);

	luaCharacterSelect:LeaveCharSel();
	luaCharacterCreate:LeaveCharCreate();
	luaCredit:LeaveCredit();
	gamefunc:LoginDisconnect();
end

-- SwitchToCredit
function luaCharacter:SwitchToCredit()

	layerCharSelect:Enable( false);
	layerCharSelect:Show( false);
	layerCharCreate:Enable( false);
	layerCharCreate:Show( false);
	
	luaCredit:EnterCredit();

	luaCharacterSelect:LeaveCharSel();
	
end



-- SwitchToVideo
function luaCharacter:SwitchToVideo()

	layerCharSelect:Enable( false);
	layerCharSelect:Show( false);
	layerCharCreate:Enable( false);
	layerCharCreate:Show( false);
	
	layerCharCredit:Enable( true );
	layerCharCredit:Show( true );
	pnlGameVideo:Show( true );
	
	gamevideo:Open("Data\\Video\\raiderz_intro_korean.avi", false);
	gamevideo:SetFocus();

	luaCharacterSelect:LeaveCharSel();
	
end



function luaCharacter:OnPcCafeLogin( sParam, nParam1, nParam2 )
	if ( sParam == "SERVICE_ENABLE")  then
		TextViewPCCafeLogo:Show( nParam1 );
		return true;
	end

	return false;
end