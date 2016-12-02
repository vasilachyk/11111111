--[[
	Game LUA script
--]]


-- Global instance
luaGame = {};


-- Registered window manager
luaGame.m_RegisteredWindow = {};


-- Counts of visibled window
luaGame.m_nShowWindowCount = 0;
	
	
-- Color
COLOR_RED		= "{COLOR r=170 g=60 b=50}";
COLOR_BLUE		= "{COLOR r=100 g=160 b=160}";
COLOR_GREEN		= "{COLOR r=120 g=160 b=100}";
COLOR_YELLOW	= "{COLOR r=220 g=220 b=55}";
COLOR_ORANGE	= "{COLOR r=160 g=120 b=55}";





-- OnGameEvent : global game frame event handler
function OnGameEvent( strMsg, sParam, nParam1, nParam2)

	local bRetVal = false;
	

	-- UI event
	if ( strMsg == "UI")  then								bRetVal = luaGame:OnEventUI( sParam, nParam1, nParam2);

	-- Pressed virtual key
	elseif ( strMsg == "VKEY_DOWN")  then					bRetVal = luaGame:OnEventVKeyDown( sParam, nParam1, nParam2);
	
	-- Action state
	elseif ( strMsg == "ACTION")  then						bRetVal = luaGame:OnEventAction( sParam, nParam1, nParam2);

	-- Chatting box
	elseif ( strMsg == "CHATTINGBOX")  then					bRetVal = luaGame:OnEventChattingBox( sParam, nParam1, nParam2);

	-- Chatting message
	elseif ( strMsg == "CHATTINGMSG")  then					bRetVal = luaGame:OnEventChattingMsg( sParam, nParam1, nParam2);

	-- Presentation message
	elseif ( strMsg == "PRESENTATION")  then				bRetVal = luaGame:OnEventPresentation( sParam, nParam1, nParam2);

	-- Guide message
	elseif ( strMsg == "GUIDEMSG")  then					bRetVal = luaGame:OnEventGuideMsg( sParam, nParam1, nParam2);

	-- Map Sign
	elseif ( strMsg == "MAPSIGN")  then						bRetVal = luaGame:OnEventMapSign( sParam, nParam1, nParam2);

	-- Character info
	elseif ( strMsg == "CHARINFO")  then					bRetVal = luaGame:OnEventCharInfo( sParam, nParam1, nParam2);

	-- Item
	elseif ( strMsg == "ITEM")  then						bRetVal = luaGame:OnEventItem( sParam, nParam1, nParam2);

	-- Palette slot info
	elseif ( strMsg == "PALETTE")  then						bRetVal = luaGame:OnEventPalette( sParam, nParam1, nParam2);

	-- Quest info
	elseif ( strMsg == "QUEST")  then						bRetVal = luaGame:OnEventQuest( sParam, nParam1, nParam2);

	-- Recipe info
	elseif ( strMsg == "RECIPE")  then						bRetVal = luaGame:OnEventRecipe( sParam, nParam1, nParam2);

	-- Shop
	elseif ( strMsg == "SHOP")  then						bRetVal = luaGame:OnEventShop( sParam, nParam1, nParam2);
	
	-- Trade
	elseif ( strMsg == "TRADE")  then						bRetVal = luaGame:OnEventTrade( sParam, nParam1, nParam2);
	
	-- Party
	elseif ( strMsg == "PARTY")  then						bRetVal = luaGame:OnEventParty( sParam, nParam1, nParam2);

	-- AutoParty
	elseif ( strMsg == "AUTOPARTY")  then					bRetVal = luaGame:OnEventAutoParty( sParam, nParam1, nParam2);
	
	-- Guild
	elseif ( strMsg == "GUILD")  then						bRetVal = luaGame:OnEventGuild( sParam, nParam1, nParam2);
	
	-- Mail box
	elseif ( strMsg == "MAILBOX")  then						bRetVal = luaGame:OnEventMailBox( sParam, nParam1, nParam2);

	-- Challenged to duel
	elseif ( strMsg == "DUEL")  then						bRetVal = luaGame:OnEventDuel( sParam, nParam1, nParam2);	

	-- Interaction
	elseif ( strMsg == "INTERACTION_PC")  then				bRetVal = luaGame:OnEventInteractionPC( sParam, nParam1, nParam2);
	elseif ( strMsg == "INTERACTION_NPC")  then				bRetVal = luaGame:OnEventInteractionNPC( sParam, nParam1, nParam2);
	
	-- Dialog with NPC
	elseif ( strMsg == "DIALOG_NPC")  then					bRetVal = luaGame:OnEventDialogNPC( sParam, nParam1, nParam2);

	-- Accept quest
	elseif ( strMsg == "ACCEPT_QUEST")  then				bRetVal = luaGame:OnEventAcceptQuest( sParam, nParam1, nParam2);

	-- Reward quest item
	elseif ( strMsg == "REWARD_QUEST")  then				bRetVal = luaGame:OnEventRewardQuest( sParam, nParam1, nParam2);

	-- Looting
	elseif ( strMsg == "LOOTING")  then						bRetVal = luaGame:OnEventLooting( sParam, nParam1, nParam2);

	-- Assign looting
	elseif ( strMsg == "ASSIGNLOOTING")  then				bRetVal = luaGame:OnEventAssignLooting( sParam, nParam1, nParam2);
	
	-- Crafting
	elseif ( strMsg == "CRAFTING")  then					bRetVal = luaGame:OnEventCrafting( sParam, nParam1, nParam2);
	
	-- Enemy Info
	elseif ( strMsg == "ENEMYINFO")  then					bRetVal = luaGame:OnEventEnemyInfo( sParam, nParam1, nParam2);	

	-- Target Info
	elseif ( strMsg == "TARGETINFO")  then					bRetVal = luaGame:OnEventTargetInfo( sParam, nParam1, nParam2);	

	-- Progress Bar
	elseif ( strMsg == "ACTIONPROGRESSBAR")  then			bRetVal = luaGame:OnEventActionProgressBar( sParam, nParam1, nParam2);

	-- Buff viewer
	elseif ( strMsg == "BUFF")  then						bRetVal = luaGame:OnEventBuff( sParam, nParam1, nParam2);

	-- Field event
	elseif ( strMsg == "FIELD")  then						bRetVal = luaGame:OnEventField( sParam, nParam1, nParam2);

	-- Channel event
	elseif ( strMsg == "CHANNEL")  then						bRetVal = luaGame:OnEventChannel( sParam, nParam1, nParam2);

	-- Environment event
	elseif ( strMsg == "ENVIRONMENT")  then					bRetVal = luaGame:OnEventEnvironment( sParam, nParam1, nParam2);

	-- Rebirth
	elseif ( strMsg == "REBIRTH")  then						bRetVal = luaGame:OnEventRebirth( sParam, nParam1, nParam2);	

	-- Message box
	elseif ( strMsg == "MESSAGEBOX")  then					bRetVal = luaGame:OnEventMessageBox( sParam, nParam1, nParam2);

	-- Battle Arena
	elseif ( strMsg == "BATTLEARENA")  then					bRetVal = luaGame:OnEventBattleArena( sParam, nParam1, nParam2);	

	-- Mission progress box
	elseif ( strMsg == "MISSIONPROG")  then					bRetVal = luaGame:OnEventMissionProgress( sParam, nParam1, nParam2);	
	
	-- Challenger Quest
	elseif ( strMsg == "CHALLENGERQUEST")  then				bRetVal = luaGame:OnEventChallengerQuest( sParam, nParam1, nParam2);

	-- Talent
	elseif ( strMsg == "TALENT")  then						bRetVal = luaGame:OnEventTalent( sParam, nParam1, nParam2);
	
	-- Enchang
	elseif ( strMsg == "ENCHANT") then						bRetVal = luaGame:OnEventEnchant( sParam, nParam1, nParam2);

	-- Error Message box
	elseif ( strMsg == "ERROR_MESSAGEBOX")  then			bRetVal = luaGame:OnEventErrorMessageBox( sParam, nParam1, nParam2);

	-- Dyeing
	elseif ( strMsg == "DYEING")  then						bRetVal = luaGame:OnEventDyeing( sParam, nParam1, nParam2);

	-- Help
	elseif ( strMsg == "HELP")  then						bRetVal = luaGame:OnHelp( sParam, nParam1 );
	
	-- Tutorial Close All
	elseif ( strMsg == "CLOSEHELP")  then					bRetVal = luaGame:OnHelpClose( sParam );
	
	-- UI Show 상태 검사
	elseif ( strMsg == "ISSHOWUI")  then					bRetVal = luaGame:IsShowUI( sParam );
	
	-- Tutorial Update 가능 검사
	elseif ( strMsg == "ISUPDATETUTORIAL")  then			bRetVal = luaGame:IsUpdateTutorial();
	
	-- Cross Hair
	elseif ( strMsg == "CROSSHAIR") then					bRetVal = luaGame:OnCrossHair( sParam, nParam1, nParam2);
	
	-- Storage
	elseif ( strMsg == "STORAGE") then						bRetVal = luaGame:OnStorage( sParam, nParam1, nParam2);

	end
	
	luaExpo:OnGameEvent( strMsg, sParam, nParam1, nParam2);
	
	return bRetVal;
end





-- OnEventUI
function luaGame:OnEventUI( sParam, nParam1, nParam2)

	-- sParam : ENTER, LEAVE, LOADING, LOADED, HIDE_ALL_WINDOW
	
	if ( sParam == "ENTER")  then
	
        layerGame0:SendUserArgument( "RESTORE_UI", true);
        layerGame1:SendUserArgument( "RESTORE_UI", true);
        layerGame2:SendUserArgument( "RESTORE_UI", true);
		
	elseif ( sParam == "LEAVE")  then
	
		layerGame0:SendUserArgument( "RECORD_UI", true);
		layerGame1:SendUserArgument( "RECORD_UI", true);
		layerGame2:SendUserArgument( "RECORD_UI", true);

		layerGame0:Show( false);
		layerGame1:Show( false);
		layerGame2:Show( false);
		layerGameLoading:Show( false);
		gamefunc:ShowCursor( false);

	elseif ( sParam == "PREPARE")  then
	
		layerGame0:Show( false);
		layerGame1:Show( false);
		layerGame2:Show( false);
		layerGameLoading:Show( true);
		gamefunc:ShowCursor( true);
		luaGameLoading:ShowLoadingContext(false, nParam1)
	
	elseif ( sParam == "LOADING")  then
	
		layerGame0:Show( false);
		layerGame1:Show( false);
		layerGame2:Show( false);
		layerGameLoading:Show( true);
		gamefunc:ShowCursor( true);
		luaGameLoading:ShowLoadingContext(true)	
		luaGameLoading:ResetLoadingProgress(nParam1);

	elseif ( sParam == "LOADED")  then
	
		layerGame0:Show( true);
		layerGame1:Show( true);
		layerGame2:Show( true);
		layerGameLoading:Show( false);
		gamefunc:ShowCursor( false);
				
	elseif ( sParam == "HIDE_ALL_WINDOW")  then
	
		local bRetVal = luaGame:HideAllWindows();
		
		gamefunc:ShowCursor( false);
		return bRetVal;		
	end

	return true;
end





-- OnEventVKeyDown
function luaGame:OnEventVKeyDown( sParam, nParam1, nParam2)
	
	-- sParam : key name
	-- nParam1 : key index

	-- Event key
	if ( sParam == "TOGGLEMOUSE")  then
		return false;
		
	elseif ( sParam == "PALETTE")  then
		rawget( _G, "psPalette" .. nParam1):DoUsePaletteSlot();
		return true;
	end
	-- Show window event key	
	local _window = nil;
	if ( sParam == "MAINMENU")  then
	
		if (luaGame.m_nShowWindowCount < 1) then	_window = frmMainMenu;
		else										luaGame:HideAllWindows( true);
		end
		
	elseif ( sParam == "CHARACTER")  then		_window = frmCharacter;
	elseif ( sParam == "INVENTORY")  then		_window = frmInventory;
	elseif ( sParam == "JOURNAL")  then			_window = frmJournal;
	elseif ( sParam == "SOCIAL")  then			_window = frmSocial;
	elseif ( sParam == "TALENT")  then			_window = frmTalent;	luaMessageBox:DeleteMessageBoxType("levelup");
	elseif ( sParam == "MAP")  then				_window = frmMap;
	elseif ( sParam == "CONTROLSHELP")  then
	
		if ( nParam1 == 1)  then				_window = frmControlsHelp1;
		elseif ( nParam1 == 2)  then  			_window = frmControlsHelp2;
		end
	end
	
	if ( _window == nil)  then  return false;
	end
	
	
	local bShow = not _window:GetShow();
	_window:Show( bShow);

	return true;
end





-- OnEventAction
function luaGame:OnEventAction( sParam, nParam1, nParam2)
	
	-- sParam : INTERACTION, DIE
	
	if ( sParam == "INTERACTION")  then
		-- nParam1 : 1 = begin, 0 = end	
		if ( nParam1 == 0)  then
	
			frmDialogNpc:Show( false);
			frmInteractionNpc:Show( false);
			frmInteractionPc:Show( false);
			frmAcceptQuest:Show( false);
			frmRewardQuest:Show( false);
			frmShop:Show( false);
			frmCrafting:Show( false);
			frmMailBox:Show( false);
			frmTrade:Show( false);
		end
	elseif ( sParam == "DIE")  then
	
		luaTutorialHelpTrigger:OnDie();
	end
	
	return true;
end





-- OnEventChattingBox
function luaGame:OnEventChattingBox( sParam, nParam1, nParam2)
	
	-- sParam : ADD, REMOVE, ACTIVATEINPUT
	-- nParam1 : chatting box ID  or  0(deactivate)  or  1(activate) or 2(activate_and_add_slash)
	
	if ( sParam == "ADD")  then				luaChattingBox:AddChattingBox( nParam1);
	elseif ( sParam == "REMOVE")  then		luaChattingBox:RemoveChattingBox( nParam1);
	elseif ( sParam == "ACTIVATEINPUT")  then
		if ( nParam1 > 0)  then				
			luaChattingBox:ActivateChatInput( true);
			luaChattingBox:SetEditText( "");
		else
			luaChattingBox:ActivateChatInput( false);
		end
	end
	
	return true;
end





-- OnEventChattingMsg
function luaGame:OnEventChattingMsg( sParam, nParam1, nParam2)

	-- sParam : message
	-- nParam1 : type
	
	local strMsg = "";	
	if ( nParam1 == CHATFILTER_TYPE.GENERAL)  then			strMsg = "{COLOR r=255 g=255 b=255}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.SYSTEM)  then		strMsg = "{COLOR r=0 g=246 b=255}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.WHISPER)  then		strMsg = "{COLOR r=252 g=0 b=255}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.SHOUTING) then		strMsg = "{COLOR r=255 g=0 b=0}" .. sParam;										
	elseif ( nParam1 == CHATFILTER_TYPE.PARTY)  then		strMsg = "{COLOR r=147 g=160 b=255}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.GUILD)  then		strMsg = "{COLOR r=0 g=255 b=12}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.AUCTION)  then		strMsg = "{COLOR r=0 g=166 b=80}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.FIELD)  then		strMsg = "{COLOR r=255 g=174 b=0}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.CHANNEL)  then		strMsg = "{COLOR r=198 g=156 b=109}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.ANNOUNCE)  then		strMsg = "{COLOR r=247 g=148 b=28}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.GM) then			strMsg = "{COLOR r=247 g=148 b=28}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.SOCIAL)  then
		nParam1 = CHATFILTER_TYPE.SYSTEM;
		strMsg = "{COLOR r=201 g=113 b=80}" .. sParam;
	elseif ( nParam1 == CHATFILTER_TYPE.BATTLE)  then		strMsg = "{COLOR r=254 g=136 b=136}" .. sParam;
	end
	
	if ( string.sub(sParam, 2, 5) == "[GM]" ) then
		strMsg = "{COLOR r=247 g=148 b=28}" .. sParam;
	end
	
	luaChattingBox:ChattingMessage( nParam1, strMsg);
	
	
	if ( nParam1 == CHATFILTER_TYPE.ANNOUNCE)  then
	
		pbPresentationUpper:Clear();
		pbPresentationUpper:Add( sParam, 0);
	end
	
	return true;
end





-- OnEventPresentation
function luaGame:OnEventPresentation( sParam, nParam1, nParam2)

	-- sParam : message
	-- nParam1 : upper or lower
	-- nParam2 : icon index

	if ( nParam1 == PRESENTATION_TYPE.UPPER)  then
	
		pbPresentationUpper:Clear();
		pbPresentationUpper:Add( sParam, nParam2);
	
	elseif ( nParam1 == PRESENTATION_TYPE.LOWER) then
	
		pbPresentationLower:Clear();
		pbPresentationLower:Add( sParam, nParam2);	
	end
	
	return true;
end





-- OnEventGuideMsg
function luaGame:OnEventGuideMsg( sParam, nParam1, nParam2)

	-- sParam : not use
	-- nParam1 : GUIDEMSG_TYPE
	-- nParam2 : icon index

	local sMsg = "";
	
	local strInteractionKey = gamefunc:GetDisplayKeyString("NPCINTERACTION");
	
	if ( nParam1 == GUIDEMSG_TYPE.LEVEL_UP ) then 
	
		local nLevel = gamefunc:GetLevel();
		local strTalentUIKey = gamefunc:GetDisplayKeyString("TALENT");
		sMsg = FORMAT( "UI_GAME_LEVELUP", nLevel, strTalentUIKey);
		
	elseif ( nParam1 == GUIDEMSG_TYPE.LUA_RECV_INVITE_PARTY ) then 

		local strName = gamefunc:GetRequesterName();
		sMsg = FORMAT( "UI_GAME_PARTYINVITATION", strInteractionKey, strName);
		
	elseif ( nParam1 == GUIDEMSG_TYPE.LUA_RECV_INVITE_GUILD ) then 

		local strName = gamefunc:GetRequesterName();
		sMsg = FORMAT( "UI_GAME_GUILDINVITATION", strInteractionKey, strName);
		
	elseif ( nParam1 == GUIDEMSG_TYPE.LUA_RECV_TRADE_REQUESTED ) then 

		local strName = gamefunc:GetRequesterName();
		sMsg = FORMAT( "UI_GAME_TRADEREQUEST", strInteractionKey, strName);
		
	elseif ( nParam1 == GUIDEMSG_TYPE.LUA_RECV_DUEL_CHALLENGED ) then 

		local strName = gamefunc:GetRequesterName();
		sMsg = FORMAT( "UI_GAME_DUELREQUEST", strInteractionKey, strName);

	elseif ( nParam1 == GUIDEMSG_TYPE.CAN_LOOT ) then 
	
		sMsg = FORMAT( "UI_GAME_LOOTITEM", strInteractionKey, strName);
		
	elseif ( nParam1 == GUIDEMSG_TYPE.CAN_INTERACT_TO_NPC ) then 

		sMsg = FORMAT( "UI_GAME_INTERACTION", strInteractionKey, strName);
	end
	
	
	if ( sMsg ~= "" ) then
		
		local COLOR_GREEN	= "{COLOR r=100 g=230 b=50}";
		sMsg = COLOR_GREEN .. sMsg .. "{/COLOR}";
		pbPresentationLower:Clear();
		pbPresentationLower:Add( sMsg, nParam2);
		
	end
	
	return true;
end





-- OnEventMapSign
function luaGame:OnEventMapSign( sParam, nParam1, nParam2)

	-- sParam : message

	pbMapSign:Clear();
	pbMapSign:Add( sParam, 0);
	
	return true;
end





-- OnEventCharInfo
function luaGame:OnEventCharInfo( sParam, nParam1, nParam2)

	-- sParam : STATUS, LEVEL, TALENTPOINT, EXPERIENCE, MONEY, FACTION, INVENTORY, EQUIPPEDITEM
	if (sParam == "STATUS")  or  (sParam == "TALENTPOINT")  then
		luaCharacter:RefreshCharacterInfo();
	elseif (sParam == "LEVEL") then
		luaCharacter:RefreshCharacterInfo();
		
		luaTutorialHelpTrigger:OnLevelUp();
		
		local strString = STR( "UI_GAME_MSG_LEVELUP");
		local strKey = gamefunc:GetDisplayKeyString( "TALENT");
		luaMessageBox:MessageBoxEx( strString, 8640000, "levelup", nil, strKey, luaGame.OnCallbackLevelUp);
		
	elseif (sParam == "EXPERIENCE")  then

		
	elseif (sParam == "MONEY")  then
	
		local strSound = gamefunc:GetMoneyPutDownSound();
		gamefunc:PlaySound( strSound);
		
		luaInventory:RefreshMoney();
		luaStorage:RefreshMoney();
		
	elseif (sParam == "FACTION")  then
		luaCharacter:RefreshFactionInfo();
		
	elseif (sParam == "INVENTORY")  then
		luaInventory:RefreshInventory();
		
	elseif (sParam == "EQUIPPEDITEM")  then
		luaCharacter:RefreshEquippedItemSlot();
		luaCharacter:RefreshCharacterInfo();
		
	elseif (sParam == "TALENT")  then
		luaTutorialHelpTrigger:OnTrainTalent();
		luaCharacter:RefreshCharacterLearnedTalent();
	
	elseif (sParam == "FATIGUE")  then
		luaMiniMap:RefreshFatigue();
		
	end
	
	return true;
end


function luaGame:OnCallbackLevelUp( nParam)

	if ( nParam > 0 ) then frmTalent:Show( true);
	end
end



-- OnEventItem
function luaGame:OnEventItem( sParam, nParam1, nParam2)

	-- sParam : GAIN
	-- nParam1 : Inven Slot ID
	-- nParam2 : quantity

	-- sParam : LOSS
	-- nParam1 : item ID
	-- nParam2 : quantity

	if ( sParam == "GAIN")  then			jiJournalIndicator:RefreshAll();
	elseif ( sParam == "LOSS")  then		jiJournalIndicator:RefreshAll();
	end
	
	return true;
end





-- OnEventPalette
function luaGame:OnEventPalette( sParam, nParam1, nParam2)

	-- sParam : REFRESH
	-- nParam1 : Breakable parts palette

	if ( sParam == "REFRESH")  then
	
		local bBpartsChanged = false;
		if ( nParam1 > 0)  then		bBpartsChanged = true;		end
		
		local bIsBPartsPalette = false;
		if ( nParam2 > 0)  then		bIsBPartsPalette = true;	end

		luaPalette:RefreshPaletteSlot( bBpartsChanged, bIsBPartsPalette);
	end
	
	return true;
end





-- OnEventQuest
function luaGame:OnEventQuest( sParam, nParam1, nParam2)

	-- sParam : RECIEVE, COMPLETE, FAIL, REWARD, OBJECTIVE, DISMISS
	-- nParam1 : Quest ID
	
	if ( sParam == "SHARE")  then
	
		local nCount = table.getn(g_nQuestShare);
		for i = 1, nCount do
			if (nParam1 == g_nQuestShare[i]) then return;
			end
		end
	
		table.insert( g_nQuestShare, nParam1);
	
		local strName = gamefunc:GetRequesterName();
		local strQuestName = gamefunc:GetQuestName( nParam1);
		local strString = FORMAT( "UI_GAME_SHAREDQUEST", strName, strQuestName);
		luaMessageBox:MessageBox( strString, 0, strQuestName, "", luaGame.OnCallbackRequestToShare);

	end


	luaQuest:RefreshQuest();
	

	if ( sParam == "RECIEVE")  then
	
		if ( gamefunc:GetLevel() == 1)  and  ( jiJournalIndicator:IsEmpty() == true)  then
		
			luaPopupMsg:PopupMsg( jiJournalIndicator, STR( "UI_JOURNALIND_NEWBIEHELP"));
		end

		gamefunc:AddJournal( JOURNALOBJ_TYPE.QUEST, nParam1);
		jiJournalIndicator:AddItem( JOURNALOBJ_TYPE.QUEST, nParam1);
		
	elseif ( sParam == "REWARD")  then
	
		gamefunc:RemoveJournal( JOURNALOBJ_TYPE.QUEST, nParam1);
		jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.QUEST, nParam1);

	elseif ( sParam == "COMPLETE")  then
	
		local strQuestName = gamefunc:GetQuestName( nParam1);
		pbPresentationLower:Add( FORMAT( "UI_GAME_COMPLETEDQUEST", strQuestName), 0);
		jiJournalIndicator:RefreshItem( JOURNALOBJ_TYPE.QUEST, nParam1);

	elseif ( sParam == "FAIL")  then
	
		local strQuestName = gamefunc:GetQuestName( nParam1);
		pbPresentationLower:Add( FORMAT( "UI_GAME_FAILEDQUEST", strQuestName), 0);
		jiJournalIndicator:RefreshItem( JOURNALOBJ_TYPE.QUEST, nParam1);
		
	elseif ( sParam == "OBJECTIVE")  then
	
		local nQuestID = nParam1;
		local nQObjID = nParam2;
		
		jiJournalIndicator:RefreshItem( JOURNALOBJ_TYPE.QUEST, nQuestID);

		-- 오브젝트 진행사항 출력
		local nQObjIndex = gamefunc:GetQuestObjectiveIndex( nQuestID, nQObjID);
		
		if (nQObjIndex ~= -1) then
		
			local nQObjType = gamefunc:GetQuestObjectiveType( nQuestID, nQObjIndex);
			
			if (nQObjType == QUESTOBJECT_TYPE.DESTROY)  or  (nQObjType == QUESTOBJECT_TYPE.COLLECT) then

				if (gamefunc:IsPlayerQuestCompleted( nQuestID) == false) then
					local nCurProgress = gamefunc:GetPlayerQuestObjectiveProgress( nQuestID, nQObjIndex);
					local nProgress = gamefunc:GetQuestObjectiveProgress( nQuestID, nQObjIndex);

					local strQuestName = gamefunc:GetQuestName( nQuestID);
					local strQObjName = gamefunc:GetQuestObjectiveText( nQuestID, nQObjIndex);
					local strText = strQObjName .. " ( " .. nCurProgress .. " / " .. nProgress .. " )";
					
					pbPresentationLower:AddAndSetLifeTime( strText, 0, 3);
				end

			end
		end
	elseif  ( sParam == "DISMISS")  then
	
		gamefunc:RemoveJournal( JOURNALOBJ_TYPE.QUEST, nParam1);
		jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.QUEST, nParam1);
	end

	return true;
end




function luaGame:OnCallbackRequestToShare( nParam)

	if ( nParam > 0 ) then frmJournal:Show( true);
	end
end



-- OnEventRecipe
function luaGame:OnEventRecipe( sParam, nParam1, nParam2)

	-- sParam : REFRESH, DELETE
	
	if ( sParam == "REFRESH")  then
		luaRecipe:RefreshRecipe();
		luaCrafting:RefreshCrafting();
		
	elseif ( sParam == "DELETE")  then
		gamefunc:RemoveJournal( JOURNALOBJ_TYPE.RECIPE, nParam1);
		jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.RECIPE, nParam1);
		
	end
	
	return true;
end





-- OnEventShop
function luaGame:OnEventShop( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH
	
	if ( sParam == "BEGIN")  then			frmShop:Show( true);
	elseif ( sParam == "END")  then			frmShop:Show( false);
	elseif ( sParam == "REFRESH")  then		luaShop:RefreshShop();
	end
		
	return true;
end





-- OnEventTrade
function luaGame:OnEventTrade( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH, SUCCESS, CANCEL, REQUESTED

	if ( sParam == "BEGIN")  then			frmTrade:Show( true);
	elseif ( sParam == "END")  then			frmTrade:Show( false);	
	elseif ( sParam == "REFRESH")  then		luaTrade:RefreshTrade();
	elseif ( sParam == "SUCCESS")  then		luaTrade:OnEventSuccessTrading( true);
	elseif ( sParam == "CANCEL")  then		luaTrade:OnEventSuccessTrading( false);
	elseif ( sParam == "CANCELED")  then	luaMessageBox:DeleteMessageBoxType( "trade");
	elseif ( sParam == "REQUESTED")  then
	
		local strName = gamefunc:GetRequesterName();
		local strString = FORMAT( "UI_GAME_REQUESTEDTRADE", strName);
		local strConfirmMsg = FORMAT( "UI_GAME_CONFIRMREQUESTEDTRADE", strName);
		luaMessageBox:MessageBox( strString, 60000, "trade", strConfirmMsg, luaGame.OnCallbackRequestToTrade);
	end

	return true;
end


function luaGame:OnCallbackRequestToTrade( nParam)

	if ( nParam > 0)  then		gamefunc:ConfirmRequestToTrade( true);
	else						gamefunc:ConfirmRequestToTrade( false);
	end
end





-- OnEventParty
function luaGame:OnEventParty( sParam, nParam1, nParam2)

	-- sParam : REFRESH, INVITED
	
	if ( sParam == "REFRESH")  then

		luaParty:RefreshParty();
		luaPartySetting:Refresh()
		
	elseif ( sParam == "INVITED")  then
	
		local strName = gamefunc:GetRequesterName();
		local strString = FORMAT( "UI_GAME_INVITEDPARTY", strName);
		local strConfirmMsg = FORMAT( "UI_GAME_CONFIRMINVITEDPARTY", strName);
		luaMessageBox:MessageBox( strString, 60000, "party", strConfirmMsg, luaGame.OnCallbackInviteParty);
		
		gamefunc:OutputGuideMsg( GUIDEMSG_TYPE.LUA_RECV_INVITE_PARTY);
		
	elseif ( sParam == "CANCELED")  then
		luaMessageBox:DeleteMessageBoxType( "party");
	end

	return true;
end


function luaGame:OnCallbackInviteParty( nParam)

	if ( nParam > 0)  then		gamefunc:ConfirmInviteToParty( true);
	else						gamefunc:ConfirmInviteToParty( false);
	end
end





-- OnEventGuild
function luaGame:OnEventGuild( sParam, nParam1, nParam2)

	-- sParam : REFRESH, INVITED

	if ( sParam == "CREATE")  then
	
		luaGuild:OnShowfrmMakeGuild();

	elseif ( sParam == "DESTROY")  then
		
		luaGuild:OnShowfrmConfirmGuild("Destroy");
		
	elseif ( sParam == "REFRESH")  then
	
		luaGuild:RefreshGuild();
		
	elseif ( sParam == "INVITED")  then
	
		local strName = gamefunc:GetRequesterName();
		local strString = FORMAT( "UI_GAME_INVITEDGUILD", strName);
		local strConfirmMsg = FORMAT( "UI_GAME_CONFIRMINVITEDGUILD", strName);
		luaMessageBox:MessageBox( strString, 60000, "guild", strConfirmMsg, luaGame.OnCallbackInviteGuild);
		
	elseif ( sParam == "CANCELED")  then
	
		luaMessageBox:DeleteMessageBoxType( "guild");
		
	elseif ( sParam == "STORAGESHOW")  then
	
		frmGuildStorage:Show( true);
		
	elseif ( sParam == "STORAGEREFRESH")  then
		
		luaGuildStorage:Refresh();	
	
	end
	
	return true;
end


function luaGame:OnCallbackInviteGuild( nParam)

	if ( nParam > 0)  then		gamefunc:ConfirmInviteToGuild( true);
	else						gamefunc:ConfirmInviteToGuild( false);
	end
end





-- OnEventDuel
function luaGame:OnEventDuel( sParam, nParam1, nParam2)

	-- sParam : CHALLENGED, CANCELED
	
	if ( sParam == "CHALLENGED")  then
	
		local strName = gamefunc:GetRequesterName();
		local strString = FORMAT( "UI_GAME_REQUESTEDDUEL", strName);
		local strConfirmMsg = FORMAT( "UI_GAME_CONFIRMREQUESTEDDUEL", strName);
		luaMessageBox:MessageBox( strString, 60000, "duel", strConfirmMsg, luaGame.OnCallbackChallengedToDuel);
		
	elseif ( sParam == "CANCELED")  then
	
		luaMessageBox:DeleteMessageBoxType( "duel");
	end
	
	return true;
end


function luaGame:OnCallbackChallengedToDuel( nParam)

	if ( nParam > 0)  then		gamefunc:ConfirmChallengeToDuel( true);
	else						gamefunc:ConfirmChallengeToDuel( false);
	end
end





-- OnEventAutoParty
function luaGame:OnEventAutoParty( sParam, nParam1, nParam2)

	if ( sParam == "ENTER")  then
	
--		luaAutoParty:EnterSensor(nParam1);
		luaAutoParty.bEnterSensor = true;
		luaMiniMap.m_nQuestID = nParam1;

		if ( gamefunc:IsPartyJoined() == false)  or  ( gamefunc:AmIPartyLeader() == true)  then
		
			if ( gamefunc:GetAutoPartyState() == AUTOPARTY_STATE.AS_STANDBY)  then
			
				gamefunc:SetAutoPartyState( AUTOPARTY_STATE.AS_LOOKUP);
				
				local strMessage = FORMAT( "UI_GAME_SEARCHINGAUTOPARTY", gamefunc:GetQuestName( nParam1));
				luaPopupMsg:PopupMsg( indicatorAutoParty, strMessage);
			end
		end
	
	elseif ( sParam == "LEAVE")  then
	
--		luaAutoParty:LeaveSensor(nParam1);
		luaAutoParty.bEnterSensor = false;
		luaMiniMap.m_nQuestID = 0;

		if (gamefunc:IsPartyJoined() == false) or (gamefunc:AmIPartyLeader() == true)  then
			if (AUTOPARTY_STATE.AS_LOOKUP == gamefunc:GetAutoPartyState()) then
				gamefunc:SetAutoPartyState(AUTOPARTY_STATE.AS_STANDBY);
			end
		end

	end
	
	return true;
end





-- OnEventMailBox
function luaGame:OnEventMailBox( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH, READ, SEND, DELETE, RECIEVED, ATTACH, DETACH
	
	if ( sParam == "BEGIN")  then				frmMailBox:Show( true);
	elseif ( sParam == "END")  then				frmMailBox:Show( false);
	elseif ( sParam == "REFRESH")  then			luaMailBox:RefreshMailBox();
	elseif ( sParam == "READ")  then			luaMailBox:OnReadMail();
	elseif ( sParam == "SEND")  then			luaMailBox:OnSendMail( nParam1);
	elseif ( sParam == "DELETE")  then			luaMailBox:OnDeleteMail();
	elseif ( sParam == "RECIEVED")  then
	
		luaMailBox:OnRecievedNewMail();
		
		if ( strText ~= nil)  then  luaPopupMsg:PopupMsg( indicatorMail, STR( "UI_MAILBOX_ARRIVEDNEW"));
		end
		
	elseif ( sParam == "TAKE_ITEM")  then		luaMailBox:OnTakeMailItem( nParam1);
	elseif ( sParam == "TAKE_MONEY")  then		luaMailBox:OnTakeMailMoney();
	elseif ( sParam == "ATTACH_ITEM")  then		luaMailBox:OnAttachedItem( nParam1, nParam2);
	elseif ( sParam == "DETACH_ITEM")  then		luaMailBox:OnDetachedItem( nParam1, nParam2);
	end
		
	return true;
end





-- OnEventInteractionPC
function luaGame:OnEventInteractionPC( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END
	
	if ( sParam == "BEGIN")  then			frmInteractionPc:Show( true);
	elseif ( sParam == "END")  then			frmInteractionPc:Show( false);
	end
	
	return true;
end





-- OnEventInteractionNPC
function luaGame:OnEventInteractionNPC( sParam, nParam1, nParam2)

	-- sParam : PREINTERACT, BEGIN, END
	
	if ( sParam == "PREINTERACT")  then
	
		return luaMessageBox:QueryExistRunHotKey();

	elseif ( sParam == "BEGIN")  then
	
		frmInteractionNpc:Show( true);

	elseif ( sParam == "END")  then
	
		frmInteractionNpc:Show( false);
		frmDialogNpc:Show( false);
		frmAcceptQuest:Show( false);
		frmRewardQuest:Show( false);
	end
	
	return true;
end





-- OnEventDialogNPC
function luaGame:OnEventDialogNPC( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END

	if ( sParam == "BEGIN")  then			frmDialogNpc:Show( true);
	elseif ( sParam == "END")  then			frmDialogNpc:Show( false);
	end
	
	return true;
end





-- OnEventAcceptQuest
function luaGame:OnEventAcceptQuest( sParam, nParam1, nParam2)
	
	-- sParam : BEGIN, END
	-- nParam1 : Quest ID

	if ( sParam == "BEGIN")  then
	
		luaAcceptQuest:SetQuestID( nParam1);
		frmAcceptQuest:Show( true);
		
	elseif ( sParam == "END")  then
	
		frmAcceptQuest:Show( false);

	else
		return false;
	end
	
	return true;
end





-- OnEventRewardQuest
function luaGame:OnEventRewardQuest( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END
	-- nParam1 : Quest ID

	if ( sParam == "BEGIN")  then
	
		luaRewardQuest:SetQuestID( nParam1);
		frmRewardQuest:Show( true);
		
	elseif ( sParam == "END")  then
	
		frmRewardQuest:Show( false);

	else
	
		return false;
	end
	
	return true;
end





-- OnEventLooting
function luaGame:OnEventLooting( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH

	if ( sParam == "BEGIN")  then			frmLooting:Show( true);
	elseif ( sParam == "END")  then			frmLooting:Show( false);
	elseif ( sParam == "REFRESH")  then		luaLooting:RefreshLooting();
	end
	
	return true;
end





-- OnEventAssignLooting
function luaGame:OnEventAssignLooting( sParam, nParam1, nParam2)

	-- sParam : REFRESH
	-- nParam1 : looting count

	if ( sParam == "REFRESH")  then
	
		if (  frmAssignLooting:GetShow() == true)  then
		
			luaAssignLooting:RefreshAssignLooting();

		else
		
			if ( nParam1 > 0)  then

				local strString = FORMAT( "UI_GAME_EXISTLOOTITEMS", nParam1);
				luaMessageBox:MessageBox( strString, 0, "assignlooting", nil, luaGame.OnCallbackAssignLooting);
			
			else
		
				luaMessageBox:DeleteMessageBoxType( "assignlooting");
			end
		end
	end
	
	
	return true;
end


function luaGame:OnCallbackAssignLooting( sParam, nParam1, nParam2)

	if ( frmAssignLooting:GetShow() == true)  then		luaAssignLooting:RefreshAssignLooting();
	else												frmAssignLooting:Show( true);
	end
end





-- OnEventCrafting
function luaGame:OnEventCrafting( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH. COLLECTED
	
	if ( sParam == "BEGIN")  then			frmCrafting:Show( true);
	elseif ( sParam == "END")  then			frmCrafting:Show( false);
	elseif ( sParam == "REFRESH")  then		luaCrafting:RefreshCrafting();
	elseif ( sParam == "COLLECTED")  then	
	

		local nRecipeID = nParam1;
		local nRecipeCount = nParam2;
		luaRecipe.m_nMaterialCollectedRecipeID = nRecipeID;
		
		local strRecipeItemName = COLOR_ORANGE .. gamefunc:GetRecipeItemName( nRecipeID);
		if (1 < nRecipeCount) then
			strRecipeItemName = FORMAT( "UI_GAME_RECIPECOUNT", strRecipeItemName, nRecipeCount - 1);
		end		
		strRecipeItemName = strRecipeItemName .. "{/COLOR}{CR}";
									
		local strString = FORMAT( "UI_GAME_EXISTCRAFTITEMS", strRecipeItemName);
		luaMessageBox:MessageBox( strString, 10000, "crafting", nil, luaGame.OnCallbackCollectCrafting);
	end
		
	return true;
end


function luaGame:OnCallbackCollectCrafting()

	--luaJournal:DirectView( JOURNALOBJ_TYPE.RECIPE, luaRecipe.m_nMaterialCollectedRecipeID);
	
end





-- OnEventEnemyInfo
function luaGame:OnEventEnemyInfo( sParam, nParam1, nParam2)

	-- sParam : REFRESH, DISAPPEAR
	
	if ( sParam == "REFRESH")  then			luaEnemyInfo:RefreshEnemyInfo();
	end
	
	return true;
end





-- OnEventTargetInfo
function luaGame:OnEventTargetInfo( sParam, nParam1, nParam2)

	-- sParam : REFRESH, DISAPPEAR
	
	if ( sParam == "REFRESH")  then			luaTargetInfo:RefreshTargetInfo();
	elseif ( sParam == "HIDE")  then		luaTargetInfo:HideTargetInfo();
	end
	
	return true;
end





-- OnEventActionProgressBar
function luaGame:OnEventActionProgressBar( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, CASTING
	-- nParam1 : type of action
	-- nParam2 : arrival time
		
	if ( sParam == "BEGIN")  then
	
		local strAction = STR( "UI_GAME_ACTION_CONTINUE");
		if ( nParam1 == ACTIONPROGRESS_TYPE.LOOTING_ITEM)  then			strAction = STR( "UI_GAME_ACTION_LOOTING");
		elseif ( nParam1 == ACTIONPROGRESS_TYPE.INTERACTION)  then		strAction = STR( "UI_GAME_ACTION_CONTINUE");
		elseif ( nParam1 == ACTIONPROGRESS_TYPE.USE_ITEM)  then			strAction = STR( "UI_GAME_ACTION_USING");
		end
		
		luaActionProgressBar:BeginActionProgressBar( strAction, nParam2);
		
	elseif ( sParam == "END")  then
	
		luaActionProgressBar:EndActionProgressBar();
		
	elseif ( sParam == "CASTING") then
	
		local strAction = STR( "UI_GAME_ACTION_SPELLING");
		luaActionProgressBar:BeginActionProgressBar( strAction, nParam2);
		luaActionProgressBar:OnAutoEndDiable();
	end
	
	return ture;
end





-- OnEventTalent
function luaGame:OnEventTalent( sParam, nParam1, nParam2)

	-- sParam : REFRESH

	luaTalent:OnRefreshTalent();
		
	return true;
end





-- OnEventBuff
function luaGame:OnEventBuff( sParam, nParam1, nParam2)

	-- sParam : ADD, REMOVE, CLEAR
	-- nParam1 : buff id
	
	if ( bfvBuffViewer == nil)  then		return false;
	elseif ( sParam == "ADD")  then			bfvBuffViewer:Add( nParam1);
	elseif ( sParam == "REMOVE")  then		bfvBuffViewer:Remove( nParam1);
	elseif ( sParam == "CLEAR")  then		bfvBuffViewer:Clear();
	end
	
	return true;
	
end





-- OnEventField
function luaGame:OnEventField( sParam, nParam1, nParam2)

	-- sParam : CHANGED
	-- nParam1 : Field ID
	
	if ( sParam == "CHANGED")  then
		
		luaMap:RefreshMapInfo();
		luaMiniMap:RefreshField( nParam1);

		-- 튜토리얼 필드일 경우 인터페이스 처리
		if (gamefunc:IsCurrentTutorialField()) then
			pnlChannel:Show(false);
		else
			pnlChannel:Show(true);
		end
		
		if (gamefunc:GetCurrentFieldID() == 1090000) then
			picHelpKey:Show(true);
		else
			picHelpKey:Show(false);		
		end

	elseif ( sParam == "REFRESH")  then
	
		local bBol = false;
		for  i = 0, (cmbFieldList:GetItemCount() - 1)  do
	
			local nID = cmbFieldList:GetItemData( i);
		
			if ( nID == nParam1)  then
				cmbFieldList:SetCurSel( i);	
				bBol = true;						
			end
		end

		if ( bBol == false ) then
			local strName = gamefunc:GetFieldName( nParam1);
			cmbFieldList:SetText( strName);
		end
	end
	
	return true;
end





-- OnEventChannel
function luaGame:OnEventChannel( sParam, nParam1, nParam2)

	-- sParam : CHANGED, RECIEVED_LIST
	-- nParam1 : channel ID
	
	if ( sParam == "CHANGED")  then				luaChannel:OnChannelChanged( nParam1);
	elseif ( sParam == "RECIEVED_LIST") then	luaChannel:RefreshChannelList();
	end
		
	return true;
end





-- OnEventEnvironment
function luaGame:OnEventEnvironment( sParam, nParam1, nParam2)

	-- sParam : DAYTIME, WEATHER
	-- nParam1 : ID
	
	if ( sParam == "DAYTIME")  then
	
		luaMiniMap:RefreshTimeAndWeather();

	elseif ( sParam == "WEATHER")  then

		luaMiniMap:RefreshTimeAndWeather();
	end
	
	gamefunc:CheckBGM()
	
	return true;
end





-- OnEventRebirth
function luaGame:OnEventRebirth( sParam, nParam1, nParam2)

	if ( sParam == "BEGIN")  then			frmRebirth:Show( true);
	elseif ( sParam == "END")  then			frmRebirth:Show( false);
	end
	
	return true;
end





-- OnEventMessageBox
function luaGame:OnEventMessageBox( sParam, nParam1, nParam2)

	luaMessageBox:MessageBox( sParam, nParam1);

	return true;
end





-- OnEventEnchant
function luaGame:OnEventEnchant( sParam, nParam1, nParam2)

	-- sParam : BEGIN, RESULT, END
	
	if ( sParam == "BEGIN")  then
	
	elseif ( sParam == "RESULT")  then
	
		if ( nParam1 == 0)  then			-- Success
		else								-- Fail
		end
		
	elseif ( sParam == "END")  then			luaEnchant:CloseEnchantFrame();
	end
end




function luaGame:OnEventErrorMessageBox( sParam, nParam1, nParam2)

	tvwErrorMsg:SetText( sParam);
	frmErrorMsgBox:DoModal();

	return true;
end





-- OnEventBattleArena
function luaGame:OnEventBattleArena( sParam, nParam1, nParam2)

	if ( sParam == "SHOW")			then luaBattleArea:OnShow();
	elseif ( sParam == "REFRESH")	then luaBattleArea:OnRefresh();	
	elseif ( sParam == "HIDE")		then luaBattleArea:OnHide();
	end
	
	return true;
end





-- OnEventMissionProgress
function luaGame:OnEventMissionProgress( sParam, nParam1, nParam2)

	-- sParam : TIMELIMIT, QUESTPVP, END

	if ( sParam == "TIMELIMIT")  then		luaMissionProgress:OpenMissionProgressFrame( MISSION_TYPE.TIMELIMIT, gamefunc:GetUpdateTime() + nParam1);
	elseif ( sParam == "QUESTPVP")  then	luaMissionProgress:OpenMissionProgressFrame( MISSION_TYPE.QUESTPVP, nParam1, nParam2);
	elseif ( sParam == "END")  then			luaMissionProgress:CloseMissionProgressFrame();
	end
	
	return true;
end





-- OnEventChallengerQuest
function luaGame:OnEventChallengerQuest( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END, REFRESH
	
	if ( sParam == "BEGIN")  then			frmChallengerQuest:Show( true);
	elseif ( sParam == "END")  then			frmChallengerQuest:Show( false);
	elseif ( sParam == "REFRESH")  then		luaChallengerQuest:Refresh();
	end
		
	return true;
end





-- OnEventDyeing
function luaGame:OnEventDyeing( sParam, nParam1, nParam2)

	-- sParam : BEGIN, END
	
	if ( sParam == "BEGIN")  then			
	elseif ( sParam == "END")  then			luaDyeing:CloseDyeingFrame();
	end

	return true;
end





-- OnHelp
function luaGame:OnHelp( sParam, nParam1, nParam2 )

	-- sParam : TUTORIAL, POPUPHELP
	
	if( "TUTORIAL" == sParam )			then
		luaPopupTutorial:OpenPopupTutorialFrame( sParam, nParam1 );
	elseif( "POPUPHELP" == sParam )		then
		luaPopupHelp:OpenPopupHelpFrame( sParam, nParam1 );
	end
	
	return true;
end

-- OnHelpClose
function luaGame:OnHelpClose( sParam )

	-- sParam : TUTORIAL, POPUPHELP
	
	if( "TUTORIAL" == sParam )			then
		luaPopupTutorial:ClosePopupTutorialFrame();
	elseif( "POPUPHELP" == sParam )		then
		luaPopupHelp:ClosePopupHelpFrame();
	else
		luaPopupTutorial:ClosePopupTutorialFrame();
		luaPopupHelp:ClosePopupHelpFrame();
	end

	return true;
end

-- IsShowUI()
function luaGame:IsShowUI( sParam )
	
	-- sParam : BEGIN, END
	
	local _window = nil;
	
	if( "MAP" == sParam )					then
		_window = frmMap;
	elseif( "TALENT" == sParam )			then
		_window = frmTalent;
	end
		
	if ( _window == nil)  then  return false;
	end	
		
	return _window:GetShow();
end

-- IsUpdateTutorial()
function luaGame:IsUpdateTutorial()

	if( luaPopupTutorial.m_nState == luaPopupTutorial.STATE.SHOW )		then
		return true;
	elseif( luaPopupHelp.m_nState == luaPopupHelp.STATE.SHOW )			then
		return true;
	else
		return false;
	end
	 
end

-- CrossHair
function luaGame:OnCrossHair(sParam, nParam1, nParam2)

	-- sParam : START, PICK, END
	
	if ( sParam == "START")  then
	
		luaCrossHair:OnStart( nParam1, nParam2 );
		
		return true;

	elseif ( sParam == "PICK")  then
	
		luaCrossHair:OnPick( nParam1, nParam2 );

		return true;
		
	elseif ( sParam == "AWAYS")  then

		luaCrossHair:OnAways( nParam1, nParam2 );

		return true;

	elseif ( sParam == "END")  then
	
		luaCrossHair:OnEnd();
	
		return true;

	end
	
	return false;
end







-- Storage
function luaGame:OnStorage(sParam, nParam1, nParam2)

	if ( sParam == "SHOW")  then
	
		frmStorage:Show( true);
		
		return true;
	elseif ( sParam == "REFRESH")  then
	
		luaStorage:Refresh();	
	end
	
	return false;
end








--[[
	Game global functions
--]]


-- RegisterWindow
function luaGame:RegisterWindow( _window, _holdbtn)

	_holdbtn = _holdbtn  or  0;

	if ( _window == nil)  then  return;
	end
	
	luaGame.m_RegisteredWindow[ _window] = _holdbtn;
end





-- ShowWindow
function luaGame:ShowWindow( _window)

	if ( _window:GetShow() == true)  then
	
		if ( _window:IsStatic() == false)  then

			local x, y, w, h = _window:GetRect();
			if ( x > (gamefunc:GetWindowWidth() - 50))  then	x = gamefunc:GetWindowWidth() - 50;
			elseif ( (x + w) < 50)  then						x = 50 - w;
			end
			
			if ( y > (gamefunc:GetWindowHeight() - 100))  then	y = gamefunc:GetWindowHeight() - 100;
			elseif ( y < 0)  then								y = 0;
			end
			
			_window:SetPosition( x, y);
		end
		
		_window:BringToTop();
		_window:SetFocus();
		
		luaGame.m_nShowWindowCount = luaGame.m_nShowWindowCount + 1;

		if ( luaGame.m_nShowWindowCount > 0)  then
		
			if ( gamefunc:IsMyPlayerMoving() == false)  then
			
				gamefunc:ShowCursor( true);
				
			else
			
				for  _wnd, _hold  in pairs( luaGame.m_RegisteredWindow)  do
				
					if ( _wnd:GetShow() == true)  and  ( ( _hold == 0)  or  ( _hold:GetCheck() == false))  then
					
						gamefunc:ShowCursor( true);
						break;
					end
				end
			end
		end

	else

		luaGame.m_nShowWindowCount = luaGame.m_nShowWindowCount - 1;
		
		if ( luaGame.m_nShowWindowCount <= 0)  then  gamefunc:ShowCursor( false);
		end

		-- For debug
		if ( luaGame.m_nShowWindowCount < 0)  then
		  gamedebug:Log( "보이는 윈도우 개수 카운트가 0보다 작습니다.  다음이 원인 일 수 있습니다. : " .. _window:GetName());
		end
	end
end





-- HideAllWindows
function luaGame:HideAllWindows( bHideHold)

	bHideHold = bHideHold  or  false;

	local bRetVal = false;
	for _window, _holdbtn  in pairs( luaGame.m_RegisteredWindow)  do
	

		if ( bHideHold == true)  or  ( _holdbtn == 0)  or  ( _holdbtn:GetCheck() == false)  then

			if ( _window:Show( false) == true)  then  bRetVal = true;
			end
		end
	end
	
	return bRetVal;
end





-- GetVisibledWindow
function GetVisibledWindow()

	return luaGame.m_nShowWindowCount;
end





-- RestoreUIPosition
function luaGame:RestoreUIPosition( _wnd)

	if ( _wnd == nil)  then  return;
	end
	
	local strName = _wnd:GetName();
	local x, y = gamefunc:GetAccountParam( strName, "x"), gamefunc:GetAccountParam( strName, "y");
	if ( x == nil)  or  ( y == nil)  then  return;
	end
	
	x, y = tonumber( x), tonumber( y);
	local width, height = gamefunc:GetWindowSize();
	local w, h = _wnd:GetSize();
	
	if ( x > ( width - 30))  then		x = width - 30;
	elseif ( ( x + w) < 30)  then		x = 30 - w;
	end
	
	if ( y > ( height - 30))  then		y = height - 30;
	elseif ( ( y + h) < 30)  then		y = 30 - h;
	end

	_wnd:SetPosition( x, y);
end





-- RecordUIPosition
function luaGame:RecordUIPosition( _wnd)

	if ( _wnd == nil)  then  return;
	end

	local strName = _wnd:GetName();
	local x, y = _wnd:GetPosition();
	
	gamefunc:SetAccountParam( strName, "x", x);
	gamefunc:SetAccountParam( strName, "y", y);
end





-- GetReferenceTypeData
function luaGame:GetReferenceTypeData( strRefText)

	if ( strRefText == nil)  then  return "", "";
	end

	local _first, _end = string.find( strRefText, "://");
	if ( _first == nil)  then  return "", "";
	end
	
	local strType = string.sub( strRefText,  0, _first - 1);
	if ( strType == nil)  then  strType = "";
	end

	local strData = string.sub( strRefText, _end + 1, string.len( strRefText));
	if ( strData == nil)  then  strData = "";
	end

	local nIndex = -1;
	_first, _end = string.find( strData, "&");
	if ( _first ~= nil)  then
	
		local strTmp = strData;
	
		strData = string.sub( strTmp,  0, _first - 1);
		if ( strData == nil)  then  strData = "";
		end
		
		local strIndex = string.sub( strTmp, _end + 1, string.len( strTmp));
		if ( strIndex ~= nil)  then  nIndex = tonumber( strIndex);
		end
	end
	
	return strType, strData, nIndex;
end





-- ConvertMoneyToStr : Convert money to string
function luaGame:ConvertMoneyToStr( nCopper, unitFont)

	nCopper = nCopper or 0;
	if ( nCopper < 0)  then  nCopper = 0;
	end

	local _gold = math.floor( nCopper / 10000);
	local _silver = math.floor( nCopper / 100) - ( _gold * 100);
	local _copper = nCopper % 100;
	local strString = "";
	
	if ( _gold > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		if ( unitFont == nil)  then		strString = strString .. _gold .. STR( "GOLDPOINT");
		else							strString = strString .. "{COLOR r=230 g=180 b=20}" .. _gold .. "{FONT name=\"" .. unitFont .. "\"} " .. STR( "GOLDPOINT") .. "{/FONT}{/COLOR}";
		end
	end
	
	if ( _silver > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		if ( unitFont == nil)  then		strString = strString .. _silver .. STR( "SILVERPOINT");
		else							strString = strString .. "{COLOR r=200 g=200 b=200}" .. _silver .. "{FONT name=\"" .. unitFont .. "\"} " .. STR( "SILVERPOINT") .. "{/FONT}{/COLOR}";
		end
	end
	
	if ( nCopper == 0)  or  ( _copper > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		if ( unitFont == nil)  then		strString = strString .. _copper .. STR( "COPPERPOINT");
		else							strString = strString .. "{COLOR r=200 g=120 b=60}" .. _copper .. "{FONT name=\"" .. unitFont .. "\"} " .. STR( "COPPERPOINT") .. "{/FONT}{/COLOR}";
		end
	end

	return strString;
end





-- ConvertTimeToStr
function luaGame:ConvertTimeToStr( nSec, unitFont)

	nSec = nSec  or  0;

	local _day = math.floor( nSec / 86400);
	local _hour = math.floor( nSec / 3600) - ( _day * 24);
	local _min = math.floor( nSec / 60) - ( _hour * 60) - ( _day * 1440);
	local _sec = nSec % 60;
	local strString = "";

	if ( _day > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		strString = strString .. _day;
		
		if ( unitFont == nil)  then		strString = strString .. STR( "UNIT_DAY");
		else							strString = strString .. "{FONT name=\"" .. unitFont .. "\"}" .. STR( "UNIT_DAY") .. "{/FONT}";
		end
	end

	if ( _hour > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		strString = strString .. _hour;
		
		if ( unitFont == nil)  then		strString = strString .. STR( "UNIT_HOUR");
		else							strString = strString .. "{FONT name=\"" .. unitFont .. "\"}" .. STR( "UNIT_HOUR") .. "{/FONT}";
		end
	end

	if ( _min > 0)  then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		strString = strString .. _min;
		
		if ( unitFont == nil)  then		strString = strString .. STR( "UNIT_MINUTE");
		else							strString = strString .. "{FONT name=\"" .. unitFont .. "\"}" .. STR( "UNIT_MINUTE") .. "{/FONT}";
		end
	end

	--if ( true)  then
	if( _sec > 0 )	then
	
		if ( strString ~= "")  then  strString = strString .. " ";
		end
		
		strString = strString .. _sec;
		
		if ( unitFont == nil)  then		strString = strString .. STR( "UNIT_SECOND");
		else							strString = strString .. "{FONT name=\"" .. unitFont .. "\"}" .. STR( "UNIT_SECOND") .. "{/FONT}";
		end
	end
		
	return strString;
end





-- ConvertStrToDialogSentence
function luaGame:ConvertStrToDialogSentence( strString)

	strString = string.gsub( strString, "{character}", "{COLOR r=97 g=82 b=225}");
	strString = string.gsub( strString, "{/character}", "{/COLOR}");
	strString = string.gsub( strString, "{place}", "{COLOR r=97 g=82 b=225}");
	strString = string.gsub( strString, "{/place}", "{/COLOR}");
	strString = string.gsub( strString, "{item}", "{COLOR r=97 g=82 b=225}");
	strString = string.gsub( strString, "{/item}", "{/COLOR}");

	return strString;
end
