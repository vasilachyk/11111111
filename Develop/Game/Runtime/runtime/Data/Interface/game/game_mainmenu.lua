--[[
	Game main menu LUA script
--]]


-- Global instance
luaMainMenu = {};


-- Variables
luaMainMenu.m_Icons = {};
luaMainMenu.m_IconCount = 0;
luaMainMenu.m_nIconSize = 60;
luaMainMenu.m_nIconMargin = 10;
luaMainMenu.m_fTimer = gamefunc:GetUpdateTime();
luaMainMenu.m_fStartTime = 0;





-- OnLoadedMainMenuButtons
function luaMainMenu:OnLoadedMainMenuButtons( wnd, name, hotkey)

	luaMainMenu.m_Icons[ luaMainMenu.m_IconCount] = {};
	luaMainMenu.m_Icons[ luaMainMenu.m_IconCount].wnd = wnd;
	luaMainMenu.m_Icons[ luaMainMenu.m_IconCount].name = name;
	luaMainMenu.m_Icons[ luaMainMenu.m_IconCount].hotkey = hotkey;
	luaMainMenu.m_Icons[ luaMainMenu.m_IconCount].strength = 0.0;

	luaMainMenu.m_IconCount = luaMainMenu.m_IconCount + 1;
end





-- OnShowMainMenuFrame
function luaMainMenu:OnShowMainMenuFrame()

	-- Show
	if ( frmMainMenu:GetShow() == true)  then
	
		-- Hide controls help frame
		frmControlsHelp1:Show( false);
		frmControlsHelp2:Show( false);
		
		luaMainMenu.m_fTimer = gamefunc:GetUpdateTime();
		
		for  i, icon  in pairs( luaMainMenu.m_Icons)  do
		
			icon.wnd:SetSize( luaMainMenu.m_nIconSize, luaMainMenu.m_nIconSize);
			icon.strength = 0.0;
		end
		
		gamefunc:PlaySound( "interact_round");
	end

	luaMainMenu.m_fStartTime = gamefunc:GetUpdateTime();

	luaGame:ShowWindow( frmMainMenu);
end





-- OnUpdateMainMenuFrame
function luaMainMenu:OnUpdateMainMenuFrame()

	if ( frmMainMenu:GetShow() == false)  then  return;
	end
	

	local curr = gamefunc:GetUpdateTime();
	local elapsed = curr - luaMainMenu.m_fTimer;
	luaMainMenu.m_fTimer = curr;
	
	local x, y, w, h = frmMainMenu:GetClientRect();
	x = x + ( w * 0.5) - (( luaMainMenu.m_nIconSize + luaMainMenu.m_nIconMargin * 2) * ( luaMainMenu.m_IconCount - 1) * 0.5);

	for  i, icon  in pairs( luaMainMenu.m_Icons)  do
	
		if ( icon.wnd:IsMouseOver() == true)  then		icon.strength = math.min( 1.0,  icon.strength + elapsed * 0.01);
		else											icon.strength = math.max( 0.0,  icon.strength - elapsed * 0.01);
		end
		
		local size = luaMainMenu.m_nIconSize + 30 * icon.strength;
		local rx, ry = x  +  ( luaMainMenu.m_nIconSize + luaMainMenu.m_nIconMargin * 2) * i  -  size * 0.5,  30 + luaMainMenu.m_nIconSize - size;
		icon.wnd:SetRect( rx, ry, size, size)
		icon.wnd:SetIconSize( size, size);
	end
end





-- OnDrawMainMenuFrame
function luaMainMenu:OnDrawMainMenuButtons()

	local owner = EventArgs:GetOwner()
	if ( owner:IsMouseOver() == false)  then  return;
	end

	local wnd = _G[ EventArgs:GetOwner():GetName()];
	local bitmap = wnd:GetIcon();
	local w, h = wnd:GetIconSize();
	
	local effect = gamedraw:SetEffect( "add");
	local opacity = gamedraw:SetOpacity( 0.3 + 0.3 * math.sin( gamefunc:GetUpdateTime() * 0.008));
	gamedraw:SetBitmap( bitmap);
	gamedraw:Draw( 0, 0, w, h);
	gamedraw:SetEffect( effect);
	gamedraw:SetOpacity( opacity);
end





-- OnDrawMainMenuFrame
function luaMainMenu:OnDrawMainMenuFrame()

	local x, y, w, h = frmMainMenu:GetClientRect();
	local width = ( luaMainMenu.m_nIconSize + luaMainMenu.m_nIconMargin * 2) * ( luaMainMenu.m_IconCount - 1)
	x = x + ( w * 0.5) - ( width * 0.5);
	y = 20;
	w = width;
	h = 100;
	
	local ratio = math.pow( math.min( 1.0, ( gamefunc:GetUpdateTime() - luaMainMenu.m_fStartTime) / 150), 2);
	if ( frmMainMenu:GetShow() == false)  then  ratio = 1.0 - ratio;
	end
	local _h = h * ratio;
	local _y = y + ( h * 0.5) - ( _h * 0.5);
	
	local opacity = gamedraw:SetOpacity( 0.5);
	gamedraw:SetBitmap( "bmpGradationRight");
	gamedraw:Draw( x - 100, _y, 50, _h);
	gamedraw:SetBitmap( "bmpGradationLeft");
	gamedraw:Draw( x + w + 50, _y, 50, _h);
	gamedraw:SetBitmap( "bmpGradationNone");
	gamedraw:Draw( x - 50, _y, w + 100, _h);
	gamedraw:SetOpacity( opacity);

	gamedraw:SetBitmap( "bmpGlowBar");
	gamedraw:Draw( x - 150, _y - 1, w, 1);
	gamedraw:Draw( x + 150, _y - 1, w, 1);
	gamedraw:Draw( x - 150, _y - 1, w + 300, 1);
	gamedraw:Draw( x - 150, _y + _h - 1, w, 1);
	gamedraw:Draw( x + 150, _y + _h - 1, w, 1);
	gamedraw:Draw( x - 150, _y + _h - 1, w + 300, 1);

	
	gamedraw:SetFont( "fntScriptStrong");
	gamedraw:SetTextAlign( "center", "top");

	for  i, icon  in pairs( luaMainMenu.m_Icons)  do
	
		local rx, ry = x + ( luaMainMenu.m_nIconSize + luaMainMenu.m_nIconMargin * 2) * i - 100,  y + h - 30;
		local rw, rh = 200, 30;

		local strText = icon.name;
		if ( icon.hotkey ~= nil)  then
		
			local vkey = gamefunc:GetVirtualKey( icon.hotkey);
			if ( vkey > 0)  then  strText = strText .. "(" .. gamefunc:GetVirtualKeyStr( vkey) .. ")";
			end
		end

		gamedraw:SetColor( 210 + 45 * icon.strength, 210 - 120 * icon.strength, 210 - 120 * icon.strength);
		gamedraw:TextEx( rx, ry, rw, rh, strText);
	end
end
