--[[
	Game mini map LUA script
--]]


-- Global instance
luaMiniMap = {};


-- Variables
luaMiniMap.m_fChannelBtnTimer = gamefunc:GetUpdateTime();

luaMiniMap.m_nQuestID = 0;

-- Durability item category
luaMiniMap.m_DurabilityItemCategory = 
{
	ITEM_SLOT.BODY,
	ITEM_SLOT.HEAD,
	ITEM_SLOT.LEG,
	ITEM_SLOT.HANDS,
	ITEM_SLOT.FEET,
	ITEM_SLOT.FACE,
	ITEM_SLOT.RWEAPON,
	ITEM_SLOT.LWEAPON,
	ITEM_SLOT.RWEAPON2,
	ITEM_SLOT.LWEAPON2
};





-- RePositionMiniMapFrame
function luaMiniMap:RePositionMiniMapFrame()

	local x, y, w, h = frmMiniMap:GetRect();
	
	local bRightAlign = false;
	if ( ( x + w * 0.5) > ( gamefunc:GetWindowWidth() * 0.5))  then  bRightAlign = true;  end

	local bBottomAlign = false;
	if ( ( y + h * 0.5) > ( gamefunc:GetWindowHeight() * 0.5))  then  bBottomAlign = true;  end
	

	local _w, _h = btnFieldName:GetSize();
	local _x, _y = 0, 0;
	if ( bBottomAlign == true)  then  _y = h - _h;  end
	btnFieldName:SetPosition( _x, _y);
	picFieldName:SetPosition( _x, _y);
	

	local _w, _h = mapMiniMap:GetSize();
	local _x, _y = ( w - _w) * 0.5, 38;
	if ( bBottomAlign == true)  then  _y = h - 35 - _h - 2;  end
	mapMiniMap:SetPosition( _x, _y);
	

	-- External buttons
	local _w, _h = pnlChannel:GetSize();
	local _x, _y = x + w + 10, y;
	if ( bRightAlign == true)  then

		_x = x - _w - 10;

		picChannel:ResetRotate();

    else

		picChannel:ResetRotate();
		picChannel:SetFlipHorizontal();
    end
	if ( bBottomAlign == true)  then  _y = y + h - _h + 2;  end
	pnlChannel:SetPosition( _x, _y);

	local _x, _y, _w, _h = labChannel:GetRect();
	if ( bRightAlign == true)  then		_x = 75;
	else								_x = 1;
	end
	labChannel:SetPosition( _x, _y);


	local _mx, _my, _mw, _mh = mapMiniMap:GetWindowRect();
	_mx = _mx + _mw * 0.5;
	_my = _my + _mh * 0.5;
	
	local _w, _h = sdsTimeWeather:GetSize();
	local _x, _y = _mx + ( w * 0.5) - 22, _my - ( _w * 0.5) - 63;
	if ( bRightAlign == true)  then  _x = _mx - ( w * 0.5) - _w + 22;  end
	sdsTimeWeather:SetPosition( _x, _y);

	local _w, _h = indicatorAutoParty:GetSize();
	local _x, _y = _mx + ( w * 0.5), _my - ( _w * 0.5) - 22;
	if ( bRightAlign == true)  then  _x = _mx - ( w * 0.5) - _w + 5;  end
	indicatorAutoParty:SetPosition( _x, _y);

	local _w, _h = indicatorMail:GetSize();
	local _x, _y = _mx + ( w * 0.5), _my - ( _w * 0.5) + 22;
	if ( bRightAlign == true)  then  _x = _mx - ( w * 0.5) - _w + 5;  end
	indicatorMail:SetPosition( _x, _y);

	local _w, _h = indicatorDurability:GetSize();
	local _x, _y = _mx + ( w * 0.5) - 22, _my - ( _w * 0.5) + 63;
	if ( bRightAlign == true)  then  _x = _mx - ( w * 0.5) - _w + 22;  end
	indicatorDurability:SetPosition( _x, _y);
	
	local _w, _h = sdsFatigue:GetSize();
	local _x, _y = _mx + ( w * 0.5), _my - ( _w * 0.5) + 102;
	if ( bRightAlign == true)  then  _x = _mx - ( w * 0.5) - _w + 63;  end
	sdsFatigue:SetPosition( _x, _y);

	local _w, _h = btnMiniMapZoomIn:GetSize();
	local _x, _y = _mx - 60 - ( _w * 0.5), _my - 76 - ( _h * 0.5);
	if ( bRightAlign == true)  then  _x = _mx + 60 - ( _w * 0.5);  end
	if ( bBottomAlign == true)  then  _y = _my + 76 - ( _h * 0.5);  end
	btnMiniMapZoomIn:SetPosition( _x, _y);
	
	local _w, _h = btnMiniMapZoomOut:GetSize();
	local _x, _y = _mx - 76 - ( _w * 0.5), _my - 60 - ( _h * 0.5);
	if ( bRightAlign == true)  then  _x = _mx + 76 - ( _w * 0.5);  end
	if ( bBottomAlign == true)  then  _y = _my + 60 - ( _h * 0.5);  end
	btnMiniMapZoomOut:SetPosition( _x, _y);
end





-- OnNcHitTestMiniMapFrame
function luaMiniMap:OnNcHitTestMiniMapFrame()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local sx, sy, sw, sh = frmMiniMap:GetWindowRect();
	local tx, ty, tw, th = mapMiniMap:GetRect();
	local px, py = gamefunc:GetCursorPos();
	
	local mx = sx + tx + ( tw * 0.5);
	local my = sy + ty + ( th * 0.5);
	if ( (math.pow( px - mx, 2) + math.pow( py - my, 2)) < math.pow( tw * 0.5 + 10, 2) )  then

		EventArgs.hittest = HITTEST.CAPTION;

	elseif ( px > sx  and  px < ( sx + sw))  and  ( ( py > sy  and  py < ( sy + ty - 12))  or  ( py < ( sy + sh)  and  py > ( sy + ty + th + 12)) ) then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end





-- OnNcHitTestMiniMap
function luaMiniMap:OnNcHitTestMiniMap()

	EventArgs.hittest = HITTEST.NOWHERE;
	
	local x, y, w, h = mapMiniMap:GetWindowRect();
	local px, py = gamefunc:GetCursorPos();
	
	local mx = x + ( w * 0.5);
	local my = y + ( h * 0.5);
	if ( (math.pow( px - mx, 2) + math.pow( py - my, 2)) < math.pow( w * 0.5 - 5, 2) )  then

		EventArgs.hittest = HITTEST.CAPTION;
	end

	return true;
end





-- ChangedField
function luaMiniMap:RefreshField()

	luaExpo:RefreshMiniMapRefreshField();

	mapMiniMap:UpdateInfo();
	
	local nCurField = gamefunc:GetCurrentFieldID();
	if ( nCurField <= 0)  then  return;
	end
	

	local strFieldName = gamefunc:GetFieldName( nCurField);
	btnFieldName:SetText( strFieldName);


	if ( gamefunc:IsDynamicField( nCurField) == true)  then
	
		labChannel:SetText( "");
		btnChannel:SetText( STR( "UI_MINIMAP_LEAVEINSTANCEFIELD"));
		btnChannel:SetTimer( 5000, 0);

	else
	
		labChannel:SetText( gamefunc:GetCurrentChannel());
		btnChannel:SetText( STR( "CHANNEL"));
		btnChannel:KillTimer();
	end
end





-- OnTimerChannel
function luaMiniMap:OnTimerChannel()

	btnChannel:KillTimer();
	luaPopupMsg:PopupMsg( btnChannel, STR( "UI_MINIMAP_POPUPLEAVEINSTANCEFIELD"));
end





-- OnDrawChannel
function luaMiniMap:OnDrawChannel()

	local w, h = btnChannel:GetSize();
	local nCurField = gamefunc:GetCurrentFieldID();
	if ( gamefunc:IsDynamicField( nCurField) == true)  then
	
		local _effect = gamedraw:SetEffect( "add");
		local _opacity = gamedraw:SetOpacity( math.max( 0.0, 0.6 * math.sin( gamefunc:GetUpdateTime() * 0.007)));
		gamedraw:SetBitmap( "bmpGauges");
		gamedraw:DrawEx( 30, 8, w - 60, h - 16, 0, 0, 32, 20);
		gamedraw:SetEffect( _effect);
		gamedraw:SetOpacity( _opacity);
		
	else
	
		local fRemained = luaChannel.m_fEnableTimer - gamefunc:GetUpdateTime();
		if ( fRemained < 0)  then  return;
		end

		local fRatio = 1.0 - math.max( 0.0, fRemained / 60000.0);
		local _w = ( w - 60) * fRatio;
		local _effect = gamedraw:SetEffect( "add");
		local _opacity = gamedraw:SetOpacity( 0.5);
		gamedraw:SetBitmap( "bmpGauges");
		gamedraw:DrawEx( 30, 9, _w, h - 18, 0, 60, 32, 20);
		gamedraw:SetColor( 0, 0, 0);
		gamedraw:FillRect( 30 + _w, 9, ( w - 60) - _w, h - 18);
		gamedraw:SetEffect( _effect);
		gamedraw:SetOpacity( _opacity);
	end
end





-- OnClickChannel
function luaMiniMap:OnClickChannel()

	if (gamefunc:IsServerModeExpo() == true) then
		luaExpo:RefreshMiniMapRefreshField();
		return
	end

	local nCurField = gamefunc:GetCurrentFieldID();
	if ( gamefunc:IsDynamicField( nCurField) == true)  then
	
		local x, y = frmConfirmLeaveDynamicChannel:GetParent():GetPosition();
		local w, h = frmConfirmLeaveDynamicChannel:GetSize();
		local width, height = gamefunc:GetWindowSize();
		frmConfirmLeaveDynamicChannel:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
		frmConfirmLeaveDynamicChannel:DoModal();
		
	else
	
        frmMainMenu:Show( false);
        frmChannel:Show( not frmChannel:GetShow());
	end
end





-- RefreshTimeAndWeather
function luaMiniMap:RefreshTimeAndWeather()

	local nDayTime = gamefunc:GetDayTime();
	local nWeather = gamefunc:GetWeather();
	sdsTimeWeather:SetCurScene( nDayTime * 6 + nWeather);
	
	local strText = "";
	if ( nDayTime == DAYTIME_TYPE.DAWN)  then				strText = STR( "DAYTIME_DAWN");
	elseif ( nDayTime == DAYTIME_TYPE.DAYTIME)  then		strText = STR( "DAYTIME_DAYTIME");
	elseif ( nDayTime == DAYTIME_TYPE.SUNSET)  then			strText = STR( "DAYTIME_SUNSET");
	elseif ( nDayTime == DAYTIME_TYPE.NIGHT)  then			strText = STR( "DAYTIME_NIGHT");
	end

	strText = strText .. " : ";
	if ( nWeather == WEATHER_TYPE.SUNNY)  then				strText = strText .. STR( "WEATHER_SUNNY");
	elseif ( nWeather == WEATHER_TYPE.CLOUDY)  then			strText = strText .. STR( "WEATHER_CLOUDY");
	elseif ( nWeather == WEATHER_TYPE.RAINY)  then			strText = strText .. STR( "WEATHER_RAINY");
	elseif ( nWeather == WEATHER_TYPE.HEAVY_RAINY)  then	strText = strText .. STR( "WEATHER_HEAVY_RAINY");
	elseif ( nWeather == WEATHER_TYPE.SNOWY)  then			strText = strText .. STR( "WEATHER_SNOWY");
	elseif ( nWeather == WEATHER_TYPE.HEAVY_SNOWY)  then	strText = strText .. STR( "WEATHER_HEAVY_SNOWY");
	end
	
	sdsTimeWeather:SetToolTip( strText);
end





function luaMiniMap:OnTimerDurabilityIndicator()

	for  i, nSlot  in pairs( luaMiniMap.m_DurabilityItemCategory)  do
	
		local nID = gamefunc:GetEquippedItemID( nSlot);
		if ( nID > 0)  then
		
			local _durability = gamefunc:GetEquippedItemDurability( nSlot);
			local _maxdurability = gamefunc:GetItemMaxDurability( nID);
			if ( _maxdurability > 0)  and  ( (_durability / _maxdurability) < 0.2)  then
			
				indicatorDurability:Show( true);
				return;
			end
		end
	end

	indicatorDurability:Show( false);
end





-- OnDrawDurabilityIndicator
function luaMiniMap:OnDrawDurabilityIndicator()

	local x, y, w, h = indicatorDurability:GetClientRect();
	local c = math.min( 255, 255 - 90 * math.sin( gamefunc:GetUpdateTime() * 0.005));
	local r, g, b = gamedraw:SetBitmapColor( 255, c, c);
	gamedraw:SetBitmap( "iconDurability");
	gamedraw:Draw( x, y, w, h);
	gamedraw:SetBitmapColor( r, g, b);
end





-- OnTimerMailIndicator
function luaMiniMap:OnTimerMailIndicator()

	local bShow = false;
	local strTooltip = "";
	if ( gamefunc:IsExistUnreadMail() == true)  then
	
		bShow = true;
		strTooltip = STR( "UI_MAILBOX_ARRIVEDNEW");

	elseif ( gamefunc:IsMailBoxFull() == true)  then
	
		bShow = true;
		strTooltip = STR( "UI_MAILBOX_FULLED.");
	
	end
	
	indicatorMail:Show( bShow);
	indicatorMail:SetToolTip( strTooltip);
end





-- OnDrawMailIndicator
function luaMiniMap:OnDrawMailIndicator()

	local x, y, w, h = indicatorMail:GetClientRect();
	gamedraw:SetBitmap( "iconMailIndicator");

	if ( gamefunc:IsMailBoxFull() == true)  then

		local c = math.min( 255, 255 - 90 * math.sin( gamefunc:GetUpdateTime() * 0.005));
		local r, g, b = gamedraw:SetBitmapColor( 255, c, c);
		gamedraw:Draw( x, y, w, h);
		gamedraw:SetBitmapColor( r, g, b);
	
	elseif ( gamefunc:IsExistUnreadMail() == true)  then
	
		gamedraw:Draw( x, y, w, h);
	end
end





-- OnDrawAutoPartyIndicator
function luaMiniMap:OnDrawAutoPartyIndicator()

	local x, y, w, h = indicatorAutoParty:GetClientRect();

	gamedraw:SetFont( "fntSubScriptStrong");
	gamedraw:SetTextAlign( "right", "bottom");
	gamedraw:SetBitmap( "iconAutoParty");
	
	local nState = gamefunc:GetAutoPartyState();
	if ( nState == AUTOPARTY_STATE.AS_OFF)  then

		local r, g, b = gamedraw:SetBitmapColor( 128, 128, 128);
		gamedraw:Draw( x, y, w, h);
		gamedraw:SetBitmapColor( r, g, b);
	
	elseif ( nState == AUTOPARTY_STATE.AS_PAUSE)  then
	
		gamedraw:Draw( x, y, w, h);

	elseif ( nState == AUTOPARTY_STATE.AS_STANDBY)  then
	
		gamedraw:Draw( x, y, w, h);
--		gamedraw:SetColor( 250, 100, 100);
--		gamedraw:TextEx( x, y, w, h, STR( "UI_MINIMAP_AUTOPARTYSTANDBY"));
		
	elseif ( nState == AUTOPARTY_STATE.AS_LOOKUP)  then
	
		local c = math.min( 255, 255 - 100 * math.sin( gamefunc:GetUpdateTime() * 0.008));
		local r, g, b = gamedraw:SetBitmapColor( 255, c, c);
		gamedraw:Draw( x, y, w, h);
		gamedraw:SetBitmapColor( r, g, b);
		gamedraw:SetColor( 250, 100, 100);
		gamedraw:TextEx( x, y, w, h, STR( "UI_MINIMAP_AUTOPARTYSEARCHING"));
	end
end





-- OnClickAutoPartyIndicator
function luaMiniMap:OnClickAutoPartyIndicator()

	if ( gamefunc:IsPartyJoined() == true)  and  ( gamefunc:AmIPartyLeader() == false)  then  return;
	end
	
	local nState = (gamefunc:GetAutoPartyState() + 1) % 4;
	
	if ( nState == AUTOPARTY_STATE.AS_PAUSE)  then
	
		nState = AUTOPARTY_STATE.AS_STANDBY;
		if ( luaAutoParty.bEnterSensor == true)  then  nState = AUTOPARTY_STATE.AS_LOOKUP;
		end
		
	elseif ( nState == AUTOPARTY_STATE.AS_STANDBY)  then
	
		if ( luaAutoParty.bEnterSensor == true)  then

			nState = AUTOPARTY_STATE.AS_LOOKUP;

			local strMessage = FORMAT( "UI_GAME_SEARCHINGAUTOPARTY", gamefunc:GetQuestName( luaMiniMap.m_nQuestID));
			luaPopupMsg:PopupMsg( indicatorAutoParty, strMessage);
		end
		
	elseif ( nState == AUTOPARTY_STATE.AS_LOOKUP)  then

		if ( luaAutoParty.bEnterSensor == true)  then

			local strMessage = FORMAT( "UI_GAME_SEARCHINGAUTOPARTY", gamefunc:GetQuestName( luaMiniMap.m_nQuestID));
			luaPopupMsg:PopupMsg( indicatorAutoParty, strMessage);
		else
			nState = AUTOPARTY_STATE.AS_OFF;
		end
	end
	
	
	if (nState == AUTOPARTY_STATE.AS_OFF)  then	btnAutoParty:SetCheck( gameoption:AutoPartyMatch( false));
	else																btnAutoParty:SetCheck( gameoption:AutoPartyMatch( true));
	end

	gamefunc:SetAutoPartyState( nState);
	
	
	nState = gamefunc:GetAutoPartyState();
end







-- RefreshFatigue
function luaMiniMap:RefreshFatigue()

	local nFatigue = gamefunc:GetFatigue();
	sdsFatigue:SetCurScene( nFatigue);
	
	local strFatigue = "피로도" .. " : ";
	if ( nFatigue == FATIGUE_TYPE.VERYGOOD)  then			strFatigue = strFatigue .. "매우 좋음";
	elseif ( nFatigue == FATIGUE_TYPE.GOOD)  then			strFatigue = strFatigue .. "좋음";
	elseif ( nFatigue == FATIGUE_TYPE.NORMAL)  then			strFatigue = strFatigue .. "보통";
	elseif ( nFatigue == FATIGUE_TYPE.BAD)  then			strFatigue = strFatigue .. "나쁨";
	elseif ( nFatigue == FATIGUE_TYPE.TOOBAD)  then			strFatigue = strFatigue .. "매우 나쁨";
	end
	
	sdsFatigue:SetToolTip( strFatigue);
end