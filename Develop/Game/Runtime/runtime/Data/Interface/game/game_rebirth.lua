--[[
	Game rebirth LUA script
--]]


-- Global instance
luaRebirth = {};


luaRebirth.HEIGHT_POSITION = { 130, 225, 320 };


-- Current selected rebirth menu
luaRebirth.m_nCurSelRebirth = nil;
luaRebirth.nItemCount	= 0;



-- OnShowRebirthFrame
function luaRebirth:OnShowRebirthFrame()

	-- Show
	if ( frmRebirth:GetShow() == true)  then
	
		luaRebirth.m_nCurSelRebirth = nil;
		
		
		-- Reset progress bar
		pcAutoRebirthProgressBar:SetPos( 0);
		lbRebirthTime:SetText( "");
		
	
		-- Refresh rebirth frame
		luaRebirth:RefreshRebirth();
		luaRebirth:CenterPosition();
		
		
		frmChannel:Show( false);
			
	-- Hide	
	else

		frmRebirth:KillTimer();	
	end
	
	
	luaGame:ShowWindow( frmRebirth);
end





-- RefreshRebirth
function luaRebirth:RefreshRebirth()
	if (luaExpo:IsServerModeExpo()) then
		luaExpo:RefreshRebirth();
		return;
	end

	luaRebirth.nItemCount	= 0;

	-- In the attle arena
	if ( gamefunc:IsBattleArena() == true)  then
	
		pnlNearSoulBinding:Show( false);
		pnlSoulBinding:Show( false);
		
		pnlSafetyZone:Show( false);
		
		luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
		pnlCurrentPosition:Show( true);
		pnlCurrentPosition:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);
		

	-- In the quest PvP area
	elseif ( gamefunc:IsInQuestPvpArea() == true)  then
	
		pnlNearSoulBinding:Show( false);
		pnlSoulBinding:Show( false);
		pnlCurrentPosition:Show( false);
		
	
		-- Rebirth at check point
		luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
		pnlSafetyZone:Show( true);
		pnlSafetyZone:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);
			
		local strName = gamefunc:GetFieldName( nCheckPointFieldID);
		tvxCheckPointField:SetText( STR( "UI_REBIRTH_SAFEAREA") .. " : " .. STR( "UI_REBIRTH_CAMPENTRANCE"));
		
		
		-- Rebirth at current position
		local nItemID = gamefunc:GetRebirthItemID();
		if ( nItemID > 0)  then

			luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
			pnlCurrentPosition:Show( true);
			pnlCurrentPosition:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);


			local strName = gamefunc:GetItemName( nItemID);
			local strImage = gamefunc:GetItemImage( nItemID);
			local strText = "{ALIGN ver=\"vcenter\"}{BITMAP name=\"" .. strImage .. "\" w=20 h=20}{FONT name=\"fntScript\"}" .. strName;
			tvxRebirthItem:SetText( strText);
			
			local strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil);
			tvxRebirthItem:SetToolTip( strToolTip);

		else
		
			pnlCurrentPosition:Show( false);
			
			
			-- Set marker
			if ( luaRebirth.m_nCurSelRebirth == pnlCurrentPosition)  then  luaRebirth.m_nCurSelRebirth = nil;
			end
		end
	
	
		-- Set marker
		if ( luaRebirth.m_nCurSelRebirth == nil)  then  luaRebirth.m_nCurSelRebirth = pnlSafetyZone;
		end
		

	-- General rebirth	
	else

		if ( gamefunc:IsDynamicField( gamefunc:GetCurrentFieldID()) == false)  then
		
			luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
			pnlNearSoulBinding:Show( true);
			pnlNearSoulBinding:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);
		else
			pnlNearSoulBinding:Show( false);
		end


		-- Rebirth at soul bind
		local nSoulBindFieldID = gamefunc:GetSoulBindFieldID();
		if ( true)  then
		
			luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
			pnlSoulBinding:Show( true);
			pnlSoulBinding:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);


			local strName = gamefunc:GetFieldName( nSoulBindFieldID);
			local strText = "{ALIGN ver=\"vcenter\"}{COLUMN h=20}{FONT name=\"fntScript\"}" .. STR( "UI_REBIRTH_BINDINGSITE") .. " : " .. strName;
			tvxSoulBindField:SetText( strText);
		end
		
		
		
		-- Rebirth at check point
		local nCheckPointFieldID = gamefunc:GetCheckPointFieldID();
		if  ( nCheckPointFieldID > 0)  and  ( gamefunc:IsDynamicField( gamefunc:GetCurrentFieldID()) == true)  then
		
			luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
			pnlSafetyZone:Show( true);
			pnlSafetyZone:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);
			
			
			local strName = gamefunc:GetFieldName( nCheckPointFieldID);
			local strText = "{ALIGN ver=\"vcenter\"}{COLUMN h=20}{FONT name=\"fntScript\"}" .. STR( "UI_REBIRTH_SAFEAREA") .. " : " .. strName;
			tvxCheckPointField:SetText( strText);
			
		else
		
			pnlSafetyZone:Show( false);
		end
				
		
		-- Rebirth at current position
		local nItemID = gamefunc:GetRebirthItemID();
		if ( nItemID > 0)  then

			luaRebirth.nItemCount = luaRebirth.nItemCount + 1;
			pnlCurrentPosition:Show( true);
			pnlCurrentPosition:SetPosition( 10, luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount]);


			local strName = gamefunc:GetItemName( nItemID);
			local strImage = gamefunc:GetItemImage( nItemID);
			local strText = "{ALIGN ver=\"vcenter\"}{BITMAP name=\"" .. strImage .. "\" w=20 h=20}{FONT name=\"fntScript\"}" .. strName;
			tvxRebirthItem:SetText( strText);
			
			local strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil);
			tvxRebirthItem:SetToolTip( strToolTip);

		else
		
			pnlCurrentPosition:Show( false);
			
			
			-- Set marker
			if ( luaRebirth.m_nCurSelRebirth == pnlCurrentPosition)  then  luaRebirth.m_nCurSelRebirth = nil;
			end
		end


		-- Set marker
		if ( luaRebirth.m_nCurSelRebirth == nil)  then
		
			if ( pnlCurrentPosition:GetShow() == true ) then luaRebirth.m_nCurSelRebirth = pnlCurrentPosition;
			elseif ( pnlNearSoulBinding:GetShow() == true ) then luaRebirth.m_nCurSelRebirth = pnlNearSoulBinding;
			elseif ( pnlSafetyZone:GetShow() == true ) then luaRebirth.m_nCurSelRebirth = pnlSafetyZone;
			elseif ( true ) then luaRebirth.m_nCurSelRebirth = pnlSoulBinding;			
			end
		end
	end

	local x, y, w, h = luaRebirth.m_nCurSelRebirth:GetRect();
	boxSelMarkerRebirth:SetRect( x, y, w, h);

	
	local w, h = frmRebirth:GetSize();
	h = luaRebirth.HEIGHT_POSITION[ luaRebirth.nItemCount] + 100 + 65;
	frmRebirth:SetSize( w, h);

end





-- CenterPosition
function luaRebirth:CenterPosition()
	
	-- Move window to center position	
	local x = ( gamefunc:GetWindowWidth() - frmRebirth:GetWidth()) * 0.5;
	local y = ( gamefunc:GetWindowHeight() - frmRebirth:GetHeight()) * 0.5;
	frmRebirth:SetPosition( x, y);
	frmRebirth:SetTimer( 1000, 0);
end






-- OnTimerRebirthFrame
function luaRebirth:OnTimerRebirthFrame()

	luaRebirth:RefreshRebirth();

	local nTime = gamefunc:GetRebirthRemainTime();
	local strTime = luaGame:ConvertTimeToStr( nTime)
	lbRebirthTime:SetText( FORMAT( "UI_REBIRTH_REMAINEDTIME", strTime));

	pcAutoRebirthProgressBar:SetPos( 300 - nTime);
end





-- OnClickRebirthMenu
function luaRebirth:OnClickRebirthMenu( _wnd)

	if ( _wnd == nil)  then  return;
	end
	
	local x, y, w, h = _wnd:GetRect();
	boxSelMarkerRebirth:SetRect( x, y, w, h);
	
	luaRebirth.m_nCurSelRebirth = _wnd;
end





-- OnClickRebirthBtn
function luaRebirth:OnClickRebirthBtn()
	if (luaExpo:IsServerModeExpo()) then
		luaExpo:OnClickRebirthBtn();
		return;
	end
	
	if ( luaRebirth.m_nCurSelRebirth == pnlSoulBinding)  then			gamefunc:RequireRebirth( 1);
	elseif ( luaRebirth.m_nCurSelRebirth == pnlNearSoulBinding)  then	gamefunc:RequireRebirth( 4);
	elseif ( luaRebirth.m_nCurSelRebirth == pnlSafetyZone)  then		gamefunc:RequireRebirth( 2);
	elseif ( luaRebirth.m_nCurSelRebirth == pnlCurrentPosition)  then	gamefunc:RequireRebirth( 3);
	end
end
