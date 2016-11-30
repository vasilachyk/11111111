--[[
	Game mail box LUA script
--]]


-- Override base tray script instance
luaTrayMailBox = luaTrayBase:new();





-- OnDraw
function luaTrayMailBox:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	

	if ( gamefunc:IsMailBoxFull() == true)  then
	
		local _col = math.min( 255, 255 + 128.0 * math.sin( gamefunc:GetUpdateTime() * 0.007));
		local _r, _g, _b, _a = gamedraw:SetBitmapColor( 255, _col, _col);
		gamedraw:SetBitmap( "iconMailBox");
		gamedraw:Draw( x, y, w, h);
		gamedraw:SetBitmapColorEx( _r, _g, _b, _a);
		
		gamedraw:SetBitmap( "iconDefExclamation");
		gamedraw:Draw( x + w - 12 - 1, y + 1, 12, 12);
		
	else

		gamedraw:SetBitmap( "iconMailBox");
		gamedraw:Draw( x, y, w, h);
		
		
		if ( gamefunc:IsExistUnreadMail() == true)  then
		
			gamedraw:SetBitmap( "iconDefExclamation");
			gamedraw:Draw( x + w - 12 - 1, y + 1, 12, 12);
		end
	end
end





-- OnClick
function luaTrayMailBox:OnClick( _wnd)
end





-- OnToolTip
function luaTrayMailBox:OnToolTip( _wnd)

	if ( gamefunc:IsMailBoxFull() == true)  then			_wnd:SetToolTip( "편지함이 가득 찼습니다.");
	elseif ( gamefunc:IsExistUnreadMail() == true)  then	_wnd:SetToolTip( "편지함에 읽지 않은 편지가 있습니다.");
	else													_wnd:SetToolTip( "새 편지가 없습니다.");
	end
end
