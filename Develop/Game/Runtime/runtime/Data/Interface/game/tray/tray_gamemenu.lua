--[[
	Game menu LUA script
--]]


-- Override base tray script instance
luaTrayGameMenu = luaTrayBase:new();





-- OnDraw
function luaTrayGameMenu:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	
	gamedraw:SetBitmap( "iconGameMenu");
	gamedraw:Draw( x, y, w, h);

	gamedraw:SetFont( "fntSmallStrong");
	gamedraw:SetColor( 255, 255, 255);
	gamedraw:SetTextAlign( "center", "bottom");
	gamedraw:TextEx( x, y, w, h - 2, "MENU");
end





-- OnClick
function luaTrayGameMenu:OnClick( _wnd)

	_wnd:TrackPopupMenu( "pmTrayGameMunuPopupMenu");
end
