--[[
	Game channel LUA script
--]]


-- Global instance
luaChannel = {};


-- Enabled change channel timer
luaChannel.m_fEnableTimer = gamefunc:GetUpdateTime();


-- Timer
luaChannel.m_fProgressTimer = 0;





-- OnShowChannelFrame
function luaChannel:OnShowChannelFrame()

	-- Show
	if ( frmChannel:GetShow() == true)  then
	
		frmMoveToChannel:Show( false);
		
		local x = ( gamefunc:GetWindowWidth() - frmChannel:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmChannel:GetHeight()) * 0.5;
		frmChannel:SetPosition( x, y);
		

		btnChannel:Enable( false);
		lcChannel:DeleteAllItems();
		btnRefreshChannelList:Enable( false);
		btnMoveToChannel:Enable( false);

		luaChannel:RefreshChannelList();
		luaChannel:RequestChannelList();
		
		
	-- Hide
	else

		btnChannel:Enable( true);
	end
	
	
	luaGame:ShowWindow( frmChannel);
end





-- RefreshChannelList
function luaChannel:RefreshChannelList()

	if ( frmChannel:GetShow() == false)  then  return;
	end
	
	
	btnRefreshChannelList:Enable( true);
	
	
	local nCurSel = lcChannel:GetCurSel();
	lcChannel:DeleteAllItems();
	
	
	-- Update current channel
	local nCurChannel = gamefunc:GetCurrentChannel();
	local strMessage = "{FONT name=\"fntScript\"}" .. FORMAT( "UI_CHANNEL_CURRENTCHANNEL", nCurChannel);
	tvwChannelMessage:SetText( strMessage);
	
	
	-- Update channel list
	for  i = 0, (gamefunc:GetChannelListCount() - 1)  do
	
		local nID = gamefunc:GetChannelID( i);
		local nState = gamefunc:GetChannelState( i);
		
		local strName = STR( "CHANNEL") .. tostring( nID);
		if ( nID == nCurChannel)  then  strName = strName .. " (" .. STR( "UI_CHANNEL_CURRENTLOCATION") .. ")";
		end

		local strState = "";
		if ( nState == CHANNEL_STATE.GOOD)  then			strState = STR( "UI_CHANNEL_STATE_GOOD");
		elseif ( nState == CHANNEL_STATE.BUSY)  then		strState = STR( "UI_CHANNEL_STATE_BUSY");
		elseif ( nState == CHANNEL_STATE.FULL)  then		strState = STR( "UI_CHANNEL_STATE_FULL");
		end
		
		local nIndex = lcChannel:AddItem( strName, "bmpChannel");
		lcChannel:SetItemText( nIndex, 1, strState);
		lcChannel:SetItemData( nIndex, nID);
		
		if ( nState == CHANNEL_STATE.GOOD)  then			lcChannel:SetItemColor( nIndex, 1, 120, 160, 100);
		elseif ( nState == CHANNEL_STATE.BUSY)  then		lcChannel:SetItemColor( nIndex, 1, 160, 120, 55);
		elseif ( nState == CHANNEL_STATE.FULL)  then		lcChannel:SetItemColor( nIndex, 1, 170, 60, 50);
		end


		if ( nID == nCurChannel)  then  lcChannel:SetItemColor( nIndex, 0, 170, 60, 50);
		end
	end
	
	lcChannel:SetCurSel( nCurSel);
end





-- RequestChannelList
function luaChannel:RequestChannelList()

	btnRefreshChannelList:Enable( false);
	
	gamefunc:RequestChannelList();
end





-- OnUpdateRemainedTimeProgress
function luaChannel:OnUpdateRemainedTimeProgress()

    local fRemained = math.max( 0.0, luaChannel.m_fEnableTimer - gamefunc:GetUpdateTime());
    if ( fRemained == 0)  then

      pcChannelRemainedTime:SetPos( 0);
      lbChannelRemainedTime:SetText( "");

    else

      local fRatio = 1.0 - math.min( 1.0, fRemained / 60000.0);
      pcChannelRemainedTime:SetPos( 1000.0 * fRatio);
      lbChannelRemainedTime:SetText( FORMAT( "UI_CHANNEL_REMAINEDTIME", math.floor( fRemained / 1000.0) + 1));
    end
end





-- OnUpdateMoveToChannelButton
function luaChannel:OnUpdateMoveToChannelButton()

	local bEnable = true;

	if ( gamefunc:IsChannelChangeable() == false)  then						bEnable = false;
	elseif ( gamefunc:GetUpdateTime() < luaChannel.m_fEnableTimer)  then	bEnable = false;
	end

	
	if ( bEnable == true)  then
		
		bEnable = false;

		local nCurSel = lcChannel:GetCurSel();
		if ( nCurSel >= 0)  then
		
			local nID = lcChannel:GetItemData( nCurSel);
			if ( nID >= 0)  and  ( nID ~= gamefunc:GetCurrentChannel())  then  bEnable = true;
			end
		end
	end
	

	btnMoveToChannel:Enable( bEnable);
end





-- OnClickRefreshChannelList
function luaChannel:OnClickRefreshChannelList()

	luaChannel:RequestChannelList();
end

















-- OpenShowMoveToChannelFrame
function luaChannel:OpenShowMoveToChannelFrame()

	local nCurSel = lcChannel:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcChannel:GetItemData( nCurSel);
	if ( nID < 0)  then  return;
	end
	
	luaChannel.m_fProgressTimer = gamefunc:GetUpdateTime();

	gamefunc:MoveToChannel( nID);
	
	
	-- Reposition frame
	local x, y = frmMoveToChannel:GetParent():GetPosition();
	local w, h = frmMoveToChannel:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmMoveToChannel:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
    

	frmChannel:Show( false);
	frmMoveToChannel:Show( true);

	gamefunc:ShowCursor( true);
end





-- OnUpdateMoveToChannelProgress
function luaChannel:OnUpdateMoveToChannelProgress()

	local nPos = gamefunc:GetUpdateTime() - luaChannel.m_fProgressTimer;
	pcMoveToChannelProgress:SetPos( nPos);
end





-- CancelMoveToChannel
function luaChannel:CancelMoveToChannel()

	gamefunc:CancelMoveToChannel();
end





-- OnChannelChanged
function luaChannel:OnChannelChanged( nChannelID)
	
	frmChannel:Show( false);
	frmMoveToChannel:Show( false);


	-- Success
	if ( nChannelID >= 0)  then

		luaChannel.m_fEnableTimer = gamefunc:GetUpdateTime() + 60000;
	end
end
