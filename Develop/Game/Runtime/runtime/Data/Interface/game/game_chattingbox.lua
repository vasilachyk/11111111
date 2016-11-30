--[[
	Game chatting box LUA script
--]]


-- Global instance
luaChattingBox = {};


-- Tab ID
luaChattingBox.m_nTabID = 0;


-- Click item
luaChattingBox.CLICKITEM = { NONE = 0, CHATBOX = 1, ADDER = 2, REMOVER = 3, PROPERTY = 4 };


-- Default ID
DEFAULT_CHATBOXID = 1000;
DEFAULT_CHATTABID = 1000;





-- ActivateChatInput
function luaChattingBox:ActivateChatInput( bActivate)

	cmwChattingBox:ActivateChatInput( bActivate);

	if ( bActivate == true) or ( 0 < GetVisibledWindow() ) then
		gamefunc:ShowCursor(true);
	else
		gamefunc:ShowCursor(false);
	end
end





-- ChattingMessage
function luaChattingBox:ChattingMessage( nType, strMessage)

	cmwChattingBox:AddChat( nType, strMessage);
end





-- RestoreChattingBox
function luaChattingBox:RestoreChattingBox()

	local _ids = gamefunc:GetAccountParam( "ChattingBoxProp", "id");
	
	if ( _ids == nil)  or  ( _ids == "")  then
	
		luaChattingBox:Reset();
		return;
	end
	
	for  _boxid  in  string.gfind( _ids, "%d+")  do

		-- Create chatting box
		local x = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "x");
		local y = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "y");
		local w = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "w");
		local h = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "h");
		cmwChattingBox:CreateChatBox( _boxid, x, y, w, h);


		-- Create chatting tab
		local _tabs = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "tab");
		if ( _tabs ~= nil)  then

			for  _tabid  in  string.gfind( _tabs, "%d+")  do
			
				local strTabName = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "name");
				cmwChattingBox:CreateChatTab( _boxid, _tabid, strTabName, "");
				
				-- Set text size
				local textsize = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "textsize");
				if ( textsize ~= nil)  then  cmwChattingBox:SetTextSize( _tabid, textsize);
				end
				

				-- Add type filters
				local general = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "general");
				if ( general == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.GENERAL);
				end

				local system = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "system");
				if ( system == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.SYSTEM);
				end

				local whisper = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "whisper");
				if ( whisper == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.WHISPER);
				end

				local field = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "field");
				if ( field == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.FIELD);
				end

				local shouting = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "shouting");
				if ( shouting == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.SHOUTING);
				end

				local party = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "party");
				if ( party == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.PARTY);
				end

				local guild = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "guild");
				if ( guild == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.GUILD);
				end

				local auction = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "auction");
				if ( auction == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.AUCTION);
				end

				local channel = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "channel");
				if ( channel == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.CHANNEL);
				end
				
				local battle = gamefunc:GetAccountParam( "ChattingTab_" .. _tabid, "battle");
				if ( battle == "1")  then  cmwChattingBox:AddTypeFilter( _tabid, CHATFILTER_TYPE.BATTLE);
				end
			end


			-- Selected tab
			local nCurSel = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "select");
			if ( nCurSel ~= nil)  then  cmwChattingBox:SetTabCurSel( _boxid, nCurSel);
			end
		end
	end
	
	
	-- Fixed
	local _fixed = gamefunc:GetAccountParam( "ChattingBoxProp", "fixed");
	if ( _fixed ~= nil)  and  ( _fixed == "1")  then  cmwChattingBox:SetFixed( true);
	end

	-- Opacity
	local _opacity = gamefunc:GetAccountParam( "ChattingBoxProp", "opacity");
	cmwChattingBox:SetOpacity( _opacity);
end





-- RecordChattingBox
function luaChattingBox:RecordChattingBox()

	-- Delete parameters
	local _ids = gamefunc:GetAccountParam( "ChattingBoxProp", "id");
	if ( _ids ~= nil)  then
	
		for  _boxid  in  string.gfind( _ids, "%d+")  do
		
			local _tabs = gamefunc:GetAccountParam( "ChattingBox_" .. _boxid, "tab");
			if ( _tabs ~= nil)  then

				for  _tabid  in  string.gfind( _tabs, "%d+")  do
				
					gamefunc:DeleteAccountParam( "ChattingTab_" .. _tabid);
				end
			end
			
			gamefunc:DeleteAccountParam( "ChattingBox_" .. _boxid);
		end
	end


	-- Record chatting box info
	local strBoxID = "";
	for  _box = 0, ( cmwChattingBox:GetChatBoxCount() - 1)  do
	
		-- Chatting box ID
		local nBoxID = cmwChattingBox:GetChatBoxID( _box);
		
		-- Chatting box rectangle
		local x, y, w, h = cmwChattingBox:GetChatBoxRect( _box);
		gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "x", x);
		gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "y", y);
		gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "w", w);
		gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "h", h);
		

		-- Selected tab		
		local nCurSel = cmwChattingBox:GetTabCurSel( nBoxID);
		if ( nCurSel > 0)  then  gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "select", nCurSel);
		end

		
		-- Chatting tab			
		local strTabID = "";
		for  _tab = 0, ( cmwChattingBox:GetChatBoxTabCount( nBoxID) - 1)  do
		
			-- Tab ID
			local nTabID = cmwChattingBox:GetChatBoxTabID( nBoxID, _tab);
			
			
			-- Tab name
			local strTabName = cmwChattingBox:GetChatTabName( nTabID);
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "name", strTabName);


			-- Set text size
			local textsize = cmwChattingBox:GetTextSize( nTabID);
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "textsize", textsize);
			

			-- Type filter
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "general", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "system", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "whisper", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "field", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "shouting", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "party", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "guild", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "auction", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "channel", "");
			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "battle", "");
			
			for i = 0, ( cmwChattingBox:GetTypeFilterCount( nTabID) - 1)  do
			
				local nFilter = cmwChattingBox:GetTypeFilter( nTabID, i);
				if ( nFilter == CHATFILTER_TYPE.GENERAL)  then			gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "general", "1");
				elseif ( nFilter == CHATFILTER_TYPE.SYSTEM)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "system", "1");
				elseif ( nFilter == CHATFILTER_TYPE.WHISPER)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "whisper", "1");
				elseif ( nFilter == CHATFILTER_TYPE.FIELD)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "field", "1");
				elseif ( nFilter == CHATFILTER_TYPE.SHOUTING)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "shouting", "1");
				elseif ( nFilter == CHATFILTER_TYPE.PARTY)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "party", "1");
				elseif ( nFilter == CHATFILTER_TYPE.GUILD)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "guild", "1");
				elseif ( nFilter == CHATFILTER_TYPE.AUCTION)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "auction", "1");
				elseif ( nFilter == CHATFILTER_TYPE.CHANNEL)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "channel", "1");
				elseif ( nFilter == CHATFILTER_TYPE.BATTLE)  then		gamefunc:SetAccountParam( "ChattingTab_" .. nTabID, "battle", "1");
				end
			end


			if ( _tab > 0)  then  strTabID = strTabID .. ",";
			end
			strTabID = strTabID .. nTabID;
		end


		gamefunc:SetAccountParam( "ChattingBox_" .. nBoxID, "tab", strTabID);


		if ( _box > 0)  then  strBoxID = strBoxID .. ",";
		end
		strBoxID = strBoxID .. nBoxID;
	end


	gamefunc:SetAccountParam( "ChattingBoxProp", "id", strBoxID);
	gamefunc:SetAccountParam( "ChattingBoxProp", "opacity", cmwChattingBox:GetOpacity());
	
	local _fixed = "";
	if ( cmwChattingBox:IsFixed() == true)  then  _fixed = "1";
	end
	gamefunc:SetAccountParam( "ChattingBoxProp", "fixed", _fixed);
end





-- Reset
function luaChattingBox:Reset()

	-- Delete all chatting tabs
	for  _box = ( cmwChattingBox:GetChatBoxCount() - 1), 0, -1  do
	
		local nBoxID = cmwChattingBox:GetChatBoxID( _box);
		for  _tab = ( cmwChattingBox:GetChatBoxTabCount( nBoxID) - 1), 0, -1  do
		
			local nTabID = cmwChattingBox:GetChatBoxTabID( nBoxID, _tab);
			cmwChattingBox:DeleteChatTab( nTabID);
		end
	end
	

	-- Set chatting tabs
	cmwChattingBox:CreateChatTab( DEFAULT_CHATBOXID, DEFAULT_CHATTABID, STR( "UI_CHATTING_DEFAULT_ALL"), "");
	cmwChattingBox:CreateChatTab( DEFAULT_CHATBOXID, DEFAULT_CHATTABID+1, STR( "UI_CHATTING_DEFAULT_SYSTEM"), "");
	cmwChattingBox:CreateChatTab( DEFAULT_CHATBOXID, DEFAULT_CHATTABID+2, STR( "UI_CHATTING_DEFAULT_BATTLE"), "");
	cmwChattingBox:CreateChatTab( DEFAULT_CHATBOXID, DEFAULT_CHATTABID+3, STR( "UI_CHATTING_DEFAULT_GENERAL"), "");
	cmwChattingBox:SetTabCurSel( DEFAULT_CHATBOXID, DEFAULT_CHATTABID);

	
	-- Set chatting filters
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID, CHATFILTER_TYPE.BATTLE);
	
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.GENERAL);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.BATTLE);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.WHISPER);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.FIELD);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.SHOUTING);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.PARTY);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.GUILD);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.AUCTION);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+1, CHATFILTER_TYPE.CHANNEL);
	
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.GENERAL);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.SYSTEM);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.WHISPER);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.FIELD);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.SHOUTING);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.PARTY);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.GUILD);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.AUCTION);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+2, CHATFILTER_TYPE.CHANNEL);
	
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+3, CHATFILTER_TYPE.SYSTEM);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+3, CHATFILTER_TYPE.BATTLE);
	cmwChattingBox:AddTypeFilter( DEFAULT_CHATBOXID+3, CHATFILTER_TYPE.AUCTION);
	
	
	-- Record current settings
	luaChattingBox:RecordChattingBox();
end





-- AddTypeFilterExcept
function luaChattingBox:AddTypeFilterExcept(nTabID, nType)

	cmwChattingBox:ClearTypeFilter(nTabID);
	
	if ( nType ~= CHATFILTER_TYPE.GENERAL)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.GENERAL);	end
	if ( nType ~= CHATFILTER_TYPE.SYSTEM)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.SYSTEM);	end
	if ( nType ~= CHATFILTER_TYPE.BATTLE)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.BATTLE);	end
	if ( nType ~= CHATFILTER_TYPE.WHISPER)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.WHISPER);	end
	if ( nType ~= CHATFILTER_TYPE.FIELD)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.FIELD);	end
	if ( nType ~= CHATFILTER_TYPE.SHOUTING)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.SHOUTING);end
	if ( nType ~= CHATFILTER_TYPE.PARTY)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.PARTY);	end
	if ( nType ~= CHATFILTER_TYPE.GUILD)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.GUILD);	end
	if ( nType ~= CHATFILTER_TYPE.AUCTION)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.AUCTION);	end
	if ( nType ~= CHATFILTER_TYPE.CHANNEL)  then  	cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.CHANNEL);	end
	if ( nType ~= CHATFILTER_TYPE.GM)  then  		cmwChattingBox:AddTypeFilter( nTabID, CHATFILTER_TYPE.GM);		end
end





-- OnItemClickChattingBox
function luaChattingBox:OnItemClickChattingBox()

	luaChattingBox.m_nTabID = EventArgs:GetItemIndex();
	if ( luaChattingBox.m_nTabID == 0)  then  return;
	end

	
	local nClickItem = EventArgs:GetItemSubItem();
	if ( nClickItem == luaChattingBox.CLICKITEM.REMOVER)  then
	
		cmwChattingBox:DeleteChatTab( luaChattingBox.m_nTabID);
	
	elseif ( nClickItem == luaChattingBox.CLICKITEM.PROPERTY)  then
	
		luaChattingBox:RefreshChatBoxPropertyFrame();
		frmChatBoxProperty:Show( true);
	end
end





-- OnItemRClickChattingBox
function luaChattingBox:OnItemRClickChattingBox()

	luaChattingBox.m_nTabID = EventArgs:GetItemIndex();
	if ( luaChattingBox.m_nTabID == 0)  then  return;
	end
	
	if ( cmwChattingBox:IsFixed() == true)  then	btnChatBoxFixed:SetText( STR( "UI_CHATTING_UNLOCKCHATTINGBOX"));
	else											btnChatBoxFixed:SetText( STR( "UI_CHATTING_LOCKCHATTINGBOX"));
	end

	cmwChattingBox:TrackPopupMenu( "pmChattingBoxPopupMenu");
end





-- SetEditText
function luaChattingBox:SetEditText( strText)

	cmwChattingBox:SetEditText( strText);
end















-- OnShowChatBoxPropertyFrame
function luaChattingBox:OnShowChatBoxPropertyFrame()

	local bShow = frmChatBoxProperty:GetShow();
	
	if ( bShow == true)  then
	
		local x = ( gamefunc:GetWindowWidth() - frmChatBoxProperty:GetWidth()) * 0.5;
		local y = ( gamefunc:GetWindowHeight() - frmChatBoxProperty:GetHeight()) * 0.5;
		frmChatBoxProperty:SetPosition( x, y);
	end
end





-- RefreshChatBoxPropertyFrame
function luaChattingBox:RefreshChatBoxPropertyFrame()

	edtChatBoxName:SetText( cmwChattingBox:GetChatTabName( luaChattingBox.m_nTabID) );

	local _index = selChatTextSize:GetItemFromValue( cmwChattingBox:GetTextSize( luaChattingBox.m_nTabID));
	selChatTextSize:SetCurSel( _index);

	btnChatFilterGeneral:SetCheck( true);
	btnChatFilterSystem:SetCheck( true);
	btnChatFilterBattle:SetCheck( true);
	btnChatFilterWhisper:SetCheck( true);
	btnChatFilterField:SetCheck( true);
	btnChatFilterShouting:SetCheck( true);
	btnChatFilterParty:SetCheck( true);
	btnChatFilterGuild:SetCheck( true);
	btnChatFilterAuction:SetCheck( true);
	btnChatFilterChannel:SetCheck( true);

	for i = 0, (cmwChattingBox:GetTypeFilterCount( luaChattingBox.m_nTabID) - 1)  do
	
		local nFilter = cmwChattingBox:GetTypeFilter( luaChattingBox.m_nTabID, i);
		
		if ( nFilter == CHATFILTER_TYPE.GENERAL)  then			btnChatFilterGeneral:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.SYSTEM)  then		btnChatFilterSystem:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.BATTLE)  then		btnChatFilterBattle:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.WHISPER)  then		btnChatFilterWhisper:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.FIELD)  then		btnChatFilterField:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.SHOUTING)  then		btnChatFilterShouting:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.PARTY)  then		btnChatFilterParty:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.GUILD)  then		btnChatFilterGuild:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.AUCTION)  then		btnChatFilterAuction:SetCheck( false);
		elseif ( nFilter == CHATFILTER_TYPE.CHANNEL)  then		btnChatFilterChannel:SetCheck( false);
		end
	end
	
	
	btnFixedChattingBox:SetCheck( cmwChattingBox:IsFixed());
	sldChattingBoxOpacity:SetScrollValue( cmwChattingBox:GetOpacity() * 100);
end





-- ApplyChatBoxProperty
function luaChattingBox:ApplyChatBoxProperty()

	cmwChattingBox:SetChatTabName( luaChattingBox.m_nTabID, edtChatBoxName:GetText() );
	cmwChattingBox:SetTextSize( luaChattingBox.m_nTabID, selChatTextSize:GetItemValue( selChatTextSize:GetCurSel()) );
	cmwChattingBox:ClearTypeFilter( luaChattingBox.m_nTabID);
	
	
	if ( btnChatFilterGeneral:GetCheck() == false)  then	cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.GENERAL);
	end
	
	if ( btnChatFilterSystem:GetCheck() == false)  then		cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.SYSTEM);
	end
	
	if ( btnChatFilterBattle:GetCheck() == false)  then		cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.BATTLE);
	end
	
	if ( btnChatFilterWhisper:GetCheck() == false)  then	cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.WHISPER);
	end
	
	if ( btnChatFilterField:GetCheck() == false)  then		cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.FIELD);
	end

	if ( btnChatFilterShouting:GetCheck() == false)  then	cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.SHOUTING);
	end
	
	if ( btnChatFilterParty:GetCheck() == false)  then		cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.PARTY);
	end
	
	if ( btnChatFilterGuild:GetCheck() == false)  then		cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.GUILD);
	end
	
	if ( btnChatFilterAuction:GetCheck() == false)  then	cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.AUCTION);
	end
	
	if ( btnChatFilterChannel:GetCheck() == false)  then	cmwChattingBox:AddTypeFilter( luaChattingBox.m_nTabID, CHATFILTER_TYPE.CHANNEL);
	end
	

	cmwChattingBox:SetFixed( btnFixedChattingBox:GetCheck());
	cmwChattingBox:SetOpacity( sldChattingBoxOpacity:GetScrollValue() * 0.01);
end














-- PopupMenuChangeProperty
function luaChattingBox:PopupMenuChangeProperty()

	frmChatBoxProperty:Show( false);


	if ( luaChattingBox.m_nTabID > 0)  then
	
		luaChattingBox:RefreshChatBoxPropertyFrame();

		frmChatBoxProperty:Show( true);
	end
end





-- PopupMenuDeleteChatTab
function luaChattingBox:PopupMenuDeleteChatTab()

	cmwChattingBox:DeleteChatTab( luaChattingBox.m_nTabID);
end
