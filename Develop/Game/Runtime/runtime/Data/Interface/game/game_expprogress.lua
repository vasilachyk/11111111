--[[
	Game Exp Progress LUA script
--]]


-- Global instance
luaExpProgress = {};





-- OnDrawExpProgressBar
function luaExpProgress:OnDrawExpProgressBar()

	local w, h = frmExpProgressBar:GetSize();
	
	gamedraw:SetBitmap( "bmpDockbar");
	gamedraw:Draw( 0, h - 16, w, 16);
	
	local fExpRatio = gamefunc:GetExpRatio();
	gamedraw:SetBitmap( "bmpExpProgress");
	gamedraw:Draw( 0, h - 4, w * fExpRatio, 4);
	
	gamedraw:SetBitmap( "bmpExpMarker");
	local fDelta = w / 10;
	for  x = fDelta, w - 10, fDelta  do
		
		gamedraw:Draw( x - 2, h - 5, 4, 5);
	end
	
	local _x = w * fExpRatio;
	if ( ( w - _x) < 50)  then
	
		_x = _x - 100 - 5;	
		gamedraw:SetTextAlign( "right", "bottom");
	
	else

		_x = _x + 2;
		gamedraw:SetTextAlign( "left", "bottom");
	end
	gamedraw:SetFont( "fntSmallStrong");
	gamedraw:SetColor( 210, 210, 210);
	gamedraw:TextEx( _x, 0, 100, h, math.floor( fExpRatio * 100.0) .. "%");
end
