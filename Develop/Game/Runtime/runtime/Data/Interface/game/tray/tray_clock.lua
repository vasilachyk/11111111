--[[
	Game clock LUA script
--]]


-- Override base tray script instance
luaTrayClock = luaTrayBase:new();


-- Month string
luaTrayClock.strMonth = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };



-- OnDraw
function luaTrayClock:OnDraw( _wnd)

	local x, y, w, h = _wnd:GetClientRect();
	
	gamedraw:SetBitmap( "iconClock");
	gamedraw:Draw( x, y, w, h);


	-- Date
	local _month = tonumber( os.date( "%m", os.time()) );
	local _day = os.date( "%d", os.time());

	gamedraw:SetFont( "fntSmallStrong");
	gamedraw:SetColor( 128, 128, 128);
	gamedraw:SetTextAlign( "center", "top");
	gamedraw:TextEx( x, y + 6, w, 15, luaTrayClock.strMonth[ _month] .. " " .. _day);


	-- Time
	local _hour = tonumber( os.date( "%H", os.time()) );
	if ( _hour > 12)  then  _hour = _hour - 12;
	end
	_hour = string.format( "%02d", _hour);

	local _min = tonumber( os.date( "%M", os.time()) );
	_min = string.format( "%02d", _min);

	local _sec = tonumber( os.date( "%S", os.time()) );

	gamedraw:SetFont( "fntScriptStrong");
	gamedraw:SetColor( 230, 230, 230);
	gamedraw:SetTextAlign( "center", "bottom");
	gamedraw:TextEx( x, y + 17, w * 0.5, 15, _hour);
	gamedraw:TextEx( x + (w * 0.5), y + 17, w * 0.5, 15, _min);

	if ( ( _sec % 2) == 0)  then  gamedraw:TextEx( x, y + 17, w, 15, ":");
	end
end





-- OnToolTip
function luaTrayClock:OnToolTip( _wnd)

	_wnd:SetToolTip( "현재 시간");
end
