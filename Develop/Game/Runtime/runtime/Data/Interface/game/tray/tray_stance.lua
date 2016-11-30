--[[
	Game stance LUA script
--]]


-- Override base tray script instance
luaTrayStance = luaTrayBase:new();





-- OnDraw
function luaTrayStance:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	
	gamedraw:SetBitmap( "iconStance");
	gamedraw:Draw( x, y, w, h);
	
	
	local nVKey = gamefunc:GetVirtualKey( "CHANGESTANCE");
	local strKey = gamefunc:GetVirtualKeyStr( nVKey);

	if ( gamefunc:IsBattleStance() == true)  then	gamedraw:SetColor( 255, 0, 0);
	else											gamedraw:SetColor( 255, 220, 0);
	end

	gamedraw:SetFont( "fntScriptStrong");
	gamedraw:SetTextAlign( "left", "top");
	gamedraw:TextEx( x, y, w, h, strKey);
end





-- OnClick
function luaTrayStance:OnClick( _wnd)

	gamefunc:SetBattleStance( not gamefunc:IsBattleStance());
end





-- OnToolTip
function luaTrayStance:OnToolTip( _wnd)

	if ( gamefunc:IsBattleStance() == true)  then		_wnd:SetToolTip( "전투 상태 해제");
	else												_wnd:SetToolTip( "전투 상태");
	end
end
