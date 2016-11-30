--[[
	Game cursor LUA script
--]]


-- Override base tray script instance
luaTrayCursor = luaTrayBase:new();





-- OnDraw
function luaTrayCursor:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	
	gamedraw:SetBitmap( "iconCursor");
	gamedraw:Draw( x, y, w, h);
	
	
	local nVKey = gamefunc:GetVirtualKey( "TOGGLEMOUSE");
	local strKey = gamefunc:GetVirtualKeyStr( nVKey);

	if ( gamefunc:IsShowCursor() == true)  then		gamedraw:SetColor( 255, 0, 0);
	else											gamedraw:SetColor( 255, 220, 0);
	end

	gamedraw:SetFont( "fntScriptStrong");
	gamedraw:SetTextAlign( "left", "top");
	gamedraw:TextEx( x, y, w, h, strKey);
end





-- OnClick
function luaTrayCursor:OnClick( _wnd)

	gamefunc:ShowCursor( false);
end





-- OnToolTip
function luaTrayCursor:OnToolTip( _wnd)

	_wnd:SetToolTip( "커서 감추기");
end
