--[[
	Game player info LUA script
--]]


-- Global instance
luaPlayerInfo = {};


-- Variables
luaPlayerInfo.m_fHP = 0.0;
luaPlayerInfo.m_fEN = 0.0;
luaPlayerInfo.m_fSTA = 0.0;
luaPlayerInfo.m_fTimer = gamefunc:GetUpdateTime();





-- RestoreUIPosition
function luaPlayerInfo:RestoreUIPosition()

	luaGame:RestoreUIPosition( frmPlayerInfo);
	
	local strName = frmPlayerInfo:GetName();
	local w, h = gamefunc:GetAccountParam( strName, "w"), gamefunc:GetAccountParam( strName, "h");
	if ( w == nil)  or  ( h == nil)  then  return;
	end
	
	w, h = tonumber( w), tonumber( h);
	frmPlayerInfo:SetSize( w, h);
end





-- RecordUIPosition
function luaPlayerInfo:RecordUIPosition()

	luaGame:RecordUIPosition( frmPlayerInfo);
	
	local strName = frmPlayerInfo:GetName();
	local w, h = frmPlayerInfo:GetSize();
	
	gamefunc:SetAccountParam( strName, "w", w);
	gamefunc:SetAccountParam( strName, "h", h);
end





-- OnUpdatePlayerInfo
function luaPlayerInfo:OnUpdatePlayerInfo()

	local fCurr = gamefunc:GetUpdateTime();
	local fElapsed = math.max( 1.0, fCurr - luaPlayerInfo.m_fTimer) * 0.008;
	luaPlayerInfo.m_fTimer = fCurr;
	
	local _diff = gamefunc:GetHP() - luaPlayerInfo.m_fHP;
	local _delta = _diff * fElapsed;
	if ( math.abs( _delta) > math.abs( _diff))  then	luaPlayerInfo.m_fHP = gamefunc:GetHP();
	else												luaPlayerInfo.m_fHP = math.min( gamefunc:GetMaxHP(), luaPlayerInfo.m_fHP + _delta);
	end

	local _diff = gamefunc:GetEN() - luaPlayerInfo.m_fEN;
	local _delta = _diff * fElapsed;
	if ( math.abs( _delta) > math.abs( _diff))  then	luaPlayerInfo.m_fEN = gamefunc:GetEN();
	else												luaPlayerInfo.m_fEN = math.min( gamefunc:GetMaxEN(), luaPlayerInfo.m_fEN + _delta);
	end

	local _diff = gamefunc:GetSTA() - luaPlayerInfo.m_fSTA;
	local _delta = _diff * fElapsed;
	if ( math.abs( _delta) > math.abs( _diff))  then	luaPlayerInfo.m_fSTA = gamefunc:GetSTA();
	else												luaPlayerInfo.m_fSTA = math.min( gamefunc:GetMaxSTA(), luaPlayerInfo.m_fSTA + _delta);
	end
end





-- OnDrawPlayerInfo
function luaPlayerInfo:OnDrawPlayerInfo()

	local x, y, w, h = frmPlayerInfo:GetRect();
	
	local bRightAlign = false;
	if ( ( x + w * 0.5) > ( gamefunc:GetWindowWidth() * 0.5))  then  bRightAlign = true;  end

	local bBottomAlign = false;
	if ( ( y + h * 0.5) > ( gamefunc:GetWindowHeight() * 0.5))  then  bBottomAlign = true;  end
	

	-- Draw info bar
	local _x, _y = 0, 0;
	if ( bBottomAlign == true)  then  _y = h - 32;  end
	gamedraw:SetBitmap( "bmpPlayerInfo");
	gamedraw:DrawEx( _x, _y, 32, 32, 0, 0, 64, 64);
	gamedraw:DrawEx( _x + 32, _y, w - 64, 32, 64, 0, 384, 64);
	gamedraw:DrawEx( _x + w - 32, _y, 32, 32, 448, 0, 64, 64);
	

	-- Draw Emblem
	local _x, _y = 0, 0;
	if ( bRightAlign == true)  then  _x = w - 50;  end
	if ( bBottomAlign == true)  then  _y = h - 50;  end
	gamedraw:SetBitmap( "bmpEmblemSlot");
	gamedraw:Draw( _x, _y, 50, 50);
	gamedraw:SetBitmap( "iconEmblem");
	gamedraw:Draw( _x + 5, _y + 5, 40, 40);


	-- Draw level
	local _x, _y = 55, 8;
	if ( bRightAlign == true)  then  _x = 20;  end
	if ( bBottomAlign == true)  then  _y = h - 32 + 8;  end
	gamedraw:SetBitmap( "bmpPlayerLevel");
	gamedraw:Draw( _x, _y, 32, 16);
	gamedraw:SetFont( "fntSubScript");
	gamedraw:SetColor( 230, 230, 230);
	gamedraw:SetTextAlign( "center", "center");
	gamedraw:TextEx( _x, _y, 32, 16, gamefunc:GetLevel());


	-- Draw name
	local _x, _y = 95, 4;
	if ( bRightAlign == true)  then  _x = 20 + 40;  end
	if ( bBottomAlign == true)  then  _y = h - 32 + 4;  end
	gamedraw:SetFont( "fntScriptStrong");
	gamedraw:SetColor( 230, 230, 230);
	gamedraw:SetTextAlign( "left", "center");
	gamedraw:TextEx( _x, _y, 150, 24, gamefunc:GetName());


	-- Draw HP/EN/STA
	local width = w - 70;
	local _x, _y = 55, 28;
	local _h = math.floor( ( h - _y - 50) / 3);
	if ( bRightAlign == true)  then  _x = 17;  end
	if ( bBottomAlign == true)  then  _y = 0;  end
	
	local _gauges = {};
	_gauges[ 0] = {};
	_gauges[ 0].name = "HP";
	_gauges[ 0].max = gamefunc:GetMaxHP();
	_gauges[ 0].current = luaPlayerInfo.m_fHP;

	_gauges[ 1] = {};
	_gauges[ 1].name = "EP";
	_gauges[ 1].max = gamefunc:GetMaxEN();
	_gauges[ 1].current = luaPlayerInfo.m_fEN;

	_gauges[ 2] = {};
	_gauges[ 2].name = "SP";
	_gauges[ 2].max = gamefunc:GetMaxSTA();
	_gauges[ 2].current = luaPlayerInfo.m_fSTA;
	
	gamedraw:SetBitmap( "bmpGauges2");
	
	local _font1, _font2 = "fntSubScript", "fntSmall";
	if ( _h > 15)  then			_font1 = "fntLargeStrong";		_font2 = "fntScriptStrong";
	elseif ( _h > 10)  then		_font1 = "fntRegularStrong";	_font2 = "fntSubScriptStrong";
	end
	
	for  i = 0, 2  do

		-- Background
		gamedraw:DrawEx( _x - 6, _y, 7, 10,						0, 300, 30, 40);
		gamedraw:DrawEx( _x - 6, _y + 10, 7, _h,				0, 340, 30, 20);
		gamedraw:DrawEx( _x - 6, _y + 10 + _h, 7, 10,			0, 360, 30, 40);

		gamedraw:DrawEx( _x + 1, _y, width - 2, 10,				30, 300, 40, 40);
		gamedraw:DrawEx( _x + 1, _y + 10, width - 2, _h,		30, 340, 40, 20);
		gamedraw:DrawEx( _x + 1, _y + 10 + _h, width - 2, 10,	30, 360, 40, 40);
	
		gamedraw:DrawEx( _x + width - 1, _y, 7, 10,				70, 300, 30, 40);
		gamedraw:DrawEx( _x + width - 1, _y + 10, 7, _h,		70, 340, 30, 20);
		gamedraw:DrawEx( _x + width - 1, _y + 10 + _h, 7, 10,	70, 360, 30, 40);


		local len = width * ( _gauges[ i].current / _gauges[ i].max);
		if ( len < 7)  then
		
			local _w = 30.0 * ( len / 7.0);
			gamedraw:DrawEx( _x, _y, len, 10,					0, i * 100, _w, 40);
			gamedraw:DrawEx( _x, _y + 10, len, _h,				0, i * 100 + 40, _w, 20);
			gamedraw:DrawEx( _x, _y + 10 + h, len, 10,			0, i * 100 + 60, _w, 40);

		else

			gamedraw:DrawEx( _x, _y, 7, 10,						0, i * 100, 30, 40);
			gamedraw:DrawEx( _x, _y + 10, 7, _h,				0, i * 100 + 40, 30, 20);
			gamedraw:DrawEx( _x, _y + 10 + _h, 7, 10,			0, i * 100 + 60, 30, 40);


			local _len = math.min( len, width - 7) - 7;
			gamedraw:DrawEx( _x + 7, _y, _len, 10,				30, i * 100, 40, 40);
			gamedraw:DrawEx( _x + 7, _y + 10, _len, _h,			30, i * 100 + 40, 40, 20);
			gamedraw:DrawEx( _x + 7, _y + 10 + _h, _len, 10,		30, i * 100 + 60, 40, 40);
			
			
			if ( len > (width - 7))  then
			
				local _len = 7 - ( width - len);
				local _w = 30.0 * ( _len / 7.0);
				gamedraw:DrawEx( _x + width - 7, _y, _len, 10,			70, i * 100, _w, 40);
				gamedraw:DrawEx( _x + width - 7, _y + 10, _len, _h,		70, i * 100 + 40, _w, 20);
				gamedraw:DrawEx( _x + width - 7, _y + 10 + _h, _len, 10,	70, i * 100 + 60, _w, 40);
			end
		end


		gamedraw:SetFont( _font1);
		gamedraw:SetColorEx( 255, 255, 255, 160);
		gamedraw:SetTextAlign( "left", "center");
		gamedraw:TextEx( _x + 3, _y, width, 20 + _h, _gauges[ i].name);

		gamedraw:SetFont( _font2);
		gamedraw:SetColorEx( 255, 255, 255, 210);
		gamedraw:SetTextAlign( "right", "center");
		gamedraw:TextEx( _x - 3, _y, width, 20 + _h, math.floor( _gauges[ i].current) .. " / " .. _gauges[ i].max);


		_y = _y + 15 + _h;
	end
end





-- OnSizePlayerInfo
function luaPlayerInfo:OnSizePlayerInfo()

    local x, y, w, h = EventArgs:GetItemRect();
    local bRetVal = false;

    if ( w < 256)  then       w = 256;  bRetVal = true;
    elseif ( w > 600)  then   w = 600;  bRetVal = true;
    end
    
    if ( h < 90)  then        h = 90;   bRetVal = true;
    elseif ( h > 200)  then   h = 200;  bRetVal = true;
    end

    EventArgs:SetItemRect( x, y, w, h);

    return bRetVal;
end





-- OnNcHitTestPlayerInfo
function luaPlayerInfo:OnNcHitTestPlayerInfo()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = frmPlayerInfo:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	if ( px >= x)  and  ( px < (x + w))  and  ( py >= y)  and  ( py < (y + h))  then
	
		if ( px < (x + 7))  or  ( px > (x + w - 7))  or  ( py < (y + 7))  or  ( py > (y + h - 7))  then
		
			return false;
			
		else

			EventArgs.hittest = HITTEST.CAPTION;
		end
	end

	return true;
end
