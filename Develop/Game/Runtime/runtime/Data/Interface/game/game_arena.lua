--[[
	Game Area LUA script
--]]


-- Global instance
luaArena = {};
luaArena.ARENA_TYPE			= { ONE_ONE = 1, THREE_THREE = 2, FIVE_FIVE = 3 };
luaArena.nType = luaArena.ARENA_TYPE.ONE_ONE;
luaArena.nState = ARENA_STAGE.AS_NORMAL;
luaArena.RESULT_COLUME		= { NAME = 0,  LEVEL = 1, KILL = 2, RESULT = 3, SCORE = 4, ALIVE = 5 };
luaArena.fIconAniTime = 0;
luaArena.nIconPos = 0;
luaArena.bReservedReMatching = false;
luaArena.bDynamicField = false;
luaArena.ARENA_VICTORY		= { DRAW = 0,  WIN = 1, LOSE = 2 };
luaArena.ARENA_TEAM			= { NONE = -1,  A = 0, B = 1 };
luaArena.fMatchingStartTime = 0.0;
luaArena.fArenaFieldEnterTime = 0.0;
luaArena.m_fProgressTimer = 0.0;
luaArena.nOneToOneCount = 0;
luaArena.nThreeToThreeCount = 0;
luaArena.nFiveToFiveCount = 0;


function luaArena:GetLimitLevel()
	-- 각 국가별 투기장 레벨 제한

	if(gamefunc:IsLocale_ja_JP() == true)		then
		return 16;
	end

	return 10;
end


function luaArena:GetLimitLevelGuild()
-- 3:3 길드전 제한 레벨은 30이다

	return 30;
end



function luaArena:GetArenaTypeNumber(nType)

    if(nType == luaArena.ARENA_TYPE.ONE_ONE) then       return 1;
    elseif(nType == luaArena.ARENA_TYPE.THREE_THREE) then   return 3;
	elseif(nType == luaArena.ARENA_TYPE.FIVE_FIVE) then   return 3;
    end

	return 0;
end

function luaArena:GetArenaTypeString(nType)

    if(nType == luaArena.ARENA_TYPE.ONE_ONE) then           return STR( "ARENA_TYPE_1VS1");
    elseif(nType == luaArena.ARENA_TYPE.THREE_THREE) then   return STR( "ARENA_TYPE_3VS3");
	elseif(nType == luaArena.ARENA_TYPE.FIVE_FIVE) then     return STR( "ARENA_TYPE_GUILD");
    end

	return "";
end


function luaArena:FieldChanged()
	
	luaArena:HideArenaFrameAll();

	if(gamefunc:IsArenaField() == true) then
		luaArena.fArenaFieldEnterTime = gamefunc:GetUpdateTime() * 0.001;
		btnChannel:Enable( false);
	else
		btnChannel:Enable( true);
	end

	local nCurField = gamefunc:GetCurrentFieldID();
	luaArena.bDynamicField = gamefunc:IsDynamicField( nCurField);
	if ( luaArena.bDynamicField == true)  then
		luaArena.nState = ARENA_STAGE.AS_NORMAL;
		luaArena.bReservedReMatching = false;
	end

	if(luaArena.bReservedReMatching == true) then
		
		luaArena:ClickRequestRegister(luaArena.nType);
		luaArena.bReservedReMatching = false
	end
end



function luaArena:LevelUp()

	if(luaArena:GetLimitLevel() == gamefunc:GetLevel()) then

		luaPopupMsg:PopupMsg( minimapIndicatorArena, STR( "UI_BALLOON_HELP_ARENA_LEVELUP"), nil, 10000);
	end
end





function luaArena:HideArenaFrameAll()

	if( frmRequestRegister:GetShow() == true ) then
		frmRequestRegister:Show(false);
	end

	if( frmCancelRegister:GetShow() == true ) then
		frmCancelRegister:Show(false);
	end

	if( frmRequestInvite:GetShow() == true ) then
		frmRequestInvite:Show(false);
	end
	
	if( frmRequestInviteWaiting:GetShow() == true ) then
		frmRequestInviteWaiting:Show(false);
	end

	if( frmArenaFinishInfo:GetShow() == true ) then
		frmArenaFinishInfo:Show(false);
	end

	if( picArenaFinishResult:GetShow() == true ) then
		picArenaFinishResult:Show(false);
	end

	luaMessageBox:DeleteMessageBoxType("arena");
	
end



function luaArena:ShowRequestRegister()

	if( frmRequestRegister:GetShow() == true ) then return;
	end

	luaArena:HideArenaFrameAll();
	

	local w, h = frmRequestRegister:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmRequestRegister:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);

	frmRequestRegister:Show( true);

	local str = "{FONT name=\"fntScriptStrong\"}{ALIGN hor=\"left\" ver=\"center\"}{COLOR r=200 g=200 b=200}" .. 
		"{SPACE w=10}{BITMAP name=\"iconDefInformation\" w=20 h=20}" .. " " .. STR( "ARENA_TIME_AVAILABLE") .. "{CR}" ..
		"{SPACE w=35}" .. STR( "WEEKDAY") .. " 19:00 ~ 25:00{CR}" ..
		"{SPACE w=35}" .. STR( "WEEKEND") .. " 13:00 ~ 16:00, 19:00 ~ 25:00{CR}";

	tvwArenaTimeAvailable:SetText(str);
end

function luaArena:OnRefreshRequestRegisterButton()

	btnArenaOneToOne:SetText(STR( "ARENA_ONE_TO_ONE") .. " (" .. luaArena.nOneToOneCount .. ")");
	btnArenaThreeToThree:SetText(STR( "ARENA_THREE_TO_THREE") .. " (" .. luaArena.nThreeToThreeCount .. ")");
	btnArenaFiveToFive:SetText(STR( "ARENA_GUILD") .. " (" .. luaArena.nFiveToFiveCount .. ")");
end


function luaArena:ClickRequestRegister(nType)

	frmRequestRegister:Show( false);

	gamefunc:RequestRegisterArena(nType);

	luaArena.fMatchingStartTime = gamefunc:GetUpdateTime() * 0.001;

end


function luaArena:RequestRegisterGuild(nType)

	frmRequestRegister:Show( false);

	luaArena.fMatchingStartTime = gamefunc:GetUpdateTime() * 0.001;


	if(gamefunc:AmIPartyLeader() == false) then
		
		local str = STR( "ARENA_GUILD_REGISTER_ERROR_PARTYLEADER");
		luaGame:OnEventPresentation( str, PRESENTATION_TYPE.UPPER, nil );
		return;
	end

	local nCount = gamefunc:GetPartyMemberCount();

	--[[
	if(nCount ~= 3) then
		
		local str = STR( "ARENA_GUILD_REGISTER_ERROR_PARTYMEMBER_COUNT");
		luaGame:OnEventPresentation( str, PRESENTATION_TYPE.UPPER, nil );
		return;
	end
	--]]
	

	for i = 0, (nCount - 1)  do

		local strMemberName= gamefunc:GetPartyMemberName( i);
		local nMemberLevel	= gamefunc:GetPartyMemberLevel( i);
		local bMemberDead	= gamefunc:IsPartyMemberDead( i);
		local nFieldID		= gamefunc:GetPartyMemberField( i);
		local bOffline		= gamefunc:IsPartyMemberOffline( i);
		local bDynamicField = gamefunc:IsDynamicField( nFieldID);
		
		local strText = "";

		if(bOffline == true) then
			strText = FORMAT( "ARENA_GUILD_REGISTER_ERROR_OFFLINE", strMemberName );
		elseif(bMemberDead == true) then
			strText = FORMAT( "ARENA_GUILD_REGISTER_ERROR_DEAD", strMemberName );
		elseif(luaArena:GetLimitLevelGuild() > nMemberLevel) then
			strText = FORMAT( "ARENA_GUILD_REGISTER_ERROR_LEVEL", strMemberName );
		elseif(bDynamicField == true) then
			strText = FORMAT( "ARENA_GUILD_REGISTER_ERROR_DYNAMICFIEDL", strMemberName );
		end

		if(strText ~= "") then
			luaGame:OnEventPresentation( strText, PRESENTATION_TYPE.UPPER, nil );
			return;
		end
	end

	gamefunc:RequestRegisterArena(nType);

end


function luaArena:OnRegister(nType)
	
	luaArena.nType = nType;
	
	luaArena.nState = ARENA_STAGE.AS_MATCHING;
	luaArena.fMatchingStartTime = gamefunc:GetUpdateTime() * 0.001;

end

function luaArena:OnReregister(nType)
	
	luaArena.nType = nType;
	
	luaArena.nState = ARENA_STAGE.AS_MATCHING;
	luaArena.fMatchingStartTime = gamefunc:GetUpdateTime() * 0.001;

	luaArena:HideArenaFrameAll();

end

function luaArena:OnUnRegister(nType)
	
	luaArena.nState = ARENA_STAGE.AS_NORMAL;

	luaArena:HideArenaFrameAll();

end

function luaArena:ShowCancelRegister()

	if( frmCancelRegister:GetShow() == true ) then return;
	end

	luaArena:HideArenaFrameAll();
	

	local w, h = frmCancelRegister:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmCancelRegister:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);

	local strAernaType = luaArena:GetArenaTypeString(luaArena.nType);
    tvwCancelRegister:SetText( "{FONT name=\"fntLarge\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}" .. strAernaType .. " " .. STR( "ARENA_CANCEL_REGISTER_SELETE_MSG"));


	frmCancelRegister:Show( true);
end

function luaArena:SetCancelRegisterText()

	local nElapsedTime = math.floor(gamefunc:GetUpdateTime() * 0.001 - luaArena.fMatchingStartTime);
	local nMin = math.floor(nElapsedTime / 60.0);
	local nSec = math.floor(nElapsedTime % 60.0);
	local strElapsedTime;

	if(nMin > 0) then
		strElapsedTime = nMin .. STR( "UNIT_MINUTE") .. " " .. nSec .. STR( "UNIT_SECOND");
	else
		strElapsedTime = nSec .. STR( "UNIT_SECOND");
	end

	if(frmCancelRegister:GetShow() == true) then
		local strAernaType = luaArena:GetArenaTypeString(luaArena.nType);
		tvwCancelRegister:SetText( "{FONT name=\"fntLarge\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}" .. strAernaType .. " " .. STR( "ARENA_CANCEL_REGISTER_SELETE_MSG") .. "{CR}" .. "(".. strElapsedTime .. ")");
	end
end

function luaArena:ConfirmCancelRegisterOK()

	gamefunc:CancelRegisterArena();
	frmCancelRegister:Show( false);
end


function luaArena:ConfirmCancelRegisterNO()

	frmCancelRegister:Show( false);
end





function luaArena:OnInvite(nType)

	luaArena:HideArenaFrameAll();

	luaArena.nType = nType;
	luaArena.nState = ARENA_STAGE.AS_MATCHING_INVITED;


	local strString = FORMAT( "ARENA_INVITE");
	local strImgString = luaGame:GetMessageImgString("bmpArenaNotice", strString);
	local strConfirmMsg = FORMAT( "ARENA_INVITE_CONFIRM");
	luaMessageBox:MessageBox( strImgString, 120000, "arena", nil, luaArena.OnCallbackInvite);
end

function luaArena:OnCallbackInvite(nParam)

	if(luaArena.nState == ARENA_STAGE.AS_MATCHING_INVITED) then
		luaArena:ShowRequestInvite();
		gamefunc:ShowCursor( true);
	end
end

function luaArena:ShowRequestInvite()

	if( frmRequestInvite:GetShow() == true ) then return;
	end

	luaArena:HideArenaFrameAll();
	

	local w, h = frmRequestInvite:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmRequestInvite:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);

	local strAernaType = luaArena:GetArenaTypeString(luaArena.nType);
    tvwRequestInvite:SetText( "{FONT name=\"fntBold\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}" .. strAernaType .. " " .. STR( "ARENA_REQUEST_INVITE_MSG"));


	frmRequestInvite:Show( true);
end


function luaArena:OnReadyCount(nCount)

	if( frmRequestInviteWaiting:GetShow() == false ) then return;
	end

	local str;
	local nTotalCount = luaArena:GetArenaTypeNumber(luaArena.nType) * 2;
	if(nCount == nTotalCount) then
		str = STR( "ARENA_REGISTER_INVITE_ENTER_MSG")
	else
		str = STR( "ARENA_REGISTER_INVITE_WAITING_MSG")
	end

	str = "{FONT name=\"fntLarge\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}" .. str .. "{CR}" .. "(" .. nCount .. "/" .. nTotalCount .. ")";
	tvwRequestInviteWaiting:SetText(str);
	tvwRequestInviteTeam1:SetText("");
	tvwRequestInviteTeam2:SetText("");


	if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE) then

		-- 아군팀 투기장 수락 현황
		local strTeam1 = "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}";
		local nPartyAcceptCount = 0;
		local nPartyCount = gamefunc:GetPartyMemberCount();
		for i = 0, (nPartyCount - 1)  do

			local strMemberName = gamefunc:GetPartyMemberName( i);
			local bAccept = gamefunc:IsArenaAcceptPlayer( strMemberName);

			if(bAccept == true) then
				nPartyAcceptCount = nPartyAcceptCount + 1;
				strTeam1 = strTeam1 .. strMemberName .. " (" .. STR( "UI_ACCEPT") .. "){CR}";
			else
				strTeam1 = strTeam1 .. strMemberName .. " (" .. STR( "UI_STANDBY") .. "){CR}";
			end
		end
		
		tvwRequestInviteTeam1:SetText(strTeam1);


		-- 적팀 투기장 수락 현황
		local strTeam2 = "{FONT name=\"fntScript\"}{ALIGN hor=\"center\" ver=\"center\"}{COLOR r=200 g=200 b=200}";
		local nEnemyAcceptCount = nCount - nPartyAcceptCount;
		for i = 0, (luaArena:GetArenaTypeNumber(luaArena.nType) - 1)  do
			
			if(i < nEnemyAcceptCount) then
				strTeam2 = strTeam2 .. "Player" .. i+1 .. " (" .. STR( "UI_ACCEPT") .. "){CR}";
			else
				strTeam2 = strTeam2 .. "Player" .. i+1 .. " (" .. STR( "UI_STANDBY") .. "){CR}";
			end
		end

		tvwRequestInviteTeam2:SetText(strTeam2);

	end
end





function luaArena:OnFinished()
	
	luaArena.nState = ARENA_STAGE.AS_NORMAL;
	


	lcArenaResultListBlue:DeleteAllItems();
	lcArenaResultListRed:DeleteAllItems();

	for i = 0, (5 - 1)  do
		local _wndRed = _G[ "picArenaResultAliveRed" .. i];
		_wndRed:Show( false);
		local _wndBlue = _G[ "picArenaResultAliveBlue" .. i];
		_wndBlue:Show( false);
	end
	
	local nCount = gamefunc:GetArenaResultInfoCount();
	if ( nCount == 0)  then
		return;
	end

	local nBlueTeamCount = 0;
	local nRedTeamCount = 0;

	for i = 0, (nCount - 1)  do
	
		local strName = "  " .. gamefunc:GetArenaResultName( i);
		local nLevel = gamefunc:GetArenaResultLevel( i);
		local nKill		= gamefunc:GetArenaResultKill( i);
		local nAjustRating = gamefunc:GetArenaResultAdjustRating( i);
		local strAjustRating;
		local nTotalRating	= gamefunc:GetArenaResultTotalRating( i);
		local nAlive	= gamefunc:GetArenaResultAlive( i);
		local nTeam = gamefunc:GetArenaResultTeam( i);
		local nTitleStyle	= gamefunc:GetArenaResultStyle( i);
		local strTalentImage = TITLE_STYLE_ICON[nTitleStyle];
		local strGuildName	= gamefunc:GetArenaResultGuildName( nTeam);
		local nGuildRating	= gamefunc:GetArenaResultGuildRating( nTeam);
		local nGuildDeltaRating	= gamefunc:GetArenaResultGuildDeltaRating( nTeam);
		local strGuildDeltaRating;

		-- 스타일 아이콘
		if(nTitleStyle == 0) then
			strTalentImage = "iconDefQuestion";
		end

		if(nAjustRating > 0) then
			strAjustRating = "+" .. nAjustRating;
		else
			strAjustRating = nAjustRating;
		end

		if(nGuildDeltaRating > 0) then
			strGuildDeltaRating = "+" .. nGuildDeltaRating;
		else
			strGuildDeltaRating = nGuildDeltaRating;
		end
	
		if(nTeam == luaArena.ARENA_TEAM.B) then
			local nIndex = lcArenaResultListBlue:AddItem( strName, strTalentImage);
			lcArenaResultListBlue:SetItemText( nIndex, 1, nLevel);
			lcArenaResultListBlue:SetItemText( nIndex, 2, nKill);
			
			if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE)then
				lcArenaResultListBlue:SetItemText( nIndex, 3, strGuildDeltaRating);
				lcArenaResultListBlue:SetItemText( nIndex, 4, nGuildRating);
			else
				lcArenaResultListBlue:SetItemText( nIndex, 3, strAjustRating);
				lcArenaResultListBlue:SetItemText( nIndex, 4, nTotalRating);
			end
			
			lcArenaResultListBlue:SetItemData( nIndex, nBlueTeamCount);

			if(nAlive == 1) then
				local _wnd = _G[ "picArenaResultAliveBlue" .. nBlueTeamCount];
				_wnd:Show( true);
			end

			if(gamefunc:GetName() == gamefunc:GetArenaResultName( i)) then
				lcArenaResultListBlue:SetCurSel(nIndex);
			end

			if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE and strGuildName ~= "") then
				lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.NAME, "<" .. strGuildName .. ">" );
			else
				lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.NAME,	STR( "ARENA_RESULT_NAME" ) );
			end

			nBlueTeamCount = nBlueTeamCount + 1;

		elseif(nTeam == luaArena.ARENA_TEAM.A) then
			local nIndex = lcArenaResultListRed:AddItem( strName, strTalentImage);
			lcArenaResultListRed:SetItemText( nIndex, 1, nLevel);
			lcArenaResultListRed:SetItemText( nIndex, 2, nKill);
			
			if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE)then
				lcArenaResultListRed:SetItemText( nIndex, 3, strGuildDeltaRating);
				lcArenaResultListRed:SetItemText( nIndex, 4, nGuildRating);
			else
				lcArenaResultListRed:SetItemText( nIndex, 3, strAjustRating);
				lcArenaResultListRed:SetItemText( nIndex, 4, nTotalRating);
			end

			lcArenaResultListRed:SetItemData( nIndex, nRedTeamCount);

			if(nAlive == 1) then
				local _wnd = _G[ "picArenaResultAliveRed" .. nRedTeamCount];
				_wnd:Show( true);
			end

			if(gamefunc:GetName() == gamefunc:GetArenaResultName( i)) then
				lcArenaResultListRed:SetCurSel(nIndex);
			end

			if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE and strGuildName ~= "") then
				lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.NAME, "<" .. strGuildName .. ">" );
			else
				lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.NAME,	STR( "ARENA_RESULT_NAME" ) );
			end

			nRedTeamCount = nRedTeamCount + 1;

		end	
	end

	local nResultTime = gamefunc:GetArenaResultTime();
	local nMinute = math.floor(nResultTime / 60);
	local nSecond = nResultTime % 60;
	local strMinute;
	local strSecond;

	if(nMinute >= 10) then
		strMinute = nMinute;
	else
		strMinute = "0" .. nMinute;
	end

	if(nSecond >= 10) then
		strSecond = nSecond;
	else
		strSecond = "0" .. nSecond;
	end

	tvwArenaResultTime:SetText( "{FONT name=\"fntSubScript\"}{ALIGN hor=\"right\" ver=\"center\"}{COLOR r=140 g=140 b=140}" .. "* " .. STR( "ARENA_RESULT_TIME") .. " " .. strMinute.. ":" .. strSecond);

	local strAernaType = luaArena:GetArenaTypeString(luaArena.nType);

	if(luaArena.nType == luaArena.ARENA_TYPE.FIVE_FIVE) then
		-- 길드전일 경우에는 재신청이 안됨.
		btnArenaReMatch:Show(false);
	else
		btnArenaReMatch:Show(true);
		btnArenaReMatch:SetText( STR("ARENA_REMATCH_FRONT") .. " " .. strAernaType .. " " .. STR("ARENA_REMATCH_REAR"));
	end


	local w, h = frmArenaFinishInfo:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmArenaFinishInfo:SetPosition( width*0.5 - w*0.5, height*0.5 - h*0.5);	

	frmArenaFinishInfo:Show( true);


	local w, h = picArenaFinishResult:GetSize();
    local width, height = gamefunc:GetWindowSize();
    picArenaFinishResult:SetPosition( width*0.5 - w*0.5, height*0.2 - h*0.5 - 30);	

	if(gamefunc:GetArenaVictory() == luaArena.ARENA_VICTORY.WIN) then
		picArenaFinishResult:SetImage( "bmpArenaResultWin");
	elseif(gamefunc:GetArenaVictory() == luaArena.ARENA_VICTORY.LOSE) then
		picArenaFinishResult:SetImage( "bmpArenaResultLose");
	else
		picArenaFinishResult:SetImage( "");
	end
	picArenaFinishResult:Show( true);


	gamefunc:ShowCursor( true);

end


function luaArena:OnLoadedArenaResultListBlue()

	lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.NAME,	STR( "ARENA_RESULT_NAME" ) );
	lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.LEVEL,	STR( "ARENA_RESULT_LEVEL" ) );
	lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.KILL,	STR( "ARENA_RESULT_KILL" ) );
	lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.RESULT,	STR( "ARENA_RESULT_RESULT" ) );
	lcArenaResultListBlue:SetColumnText( luaArena.RESULT_COLUME.SCORE,	STR( "ARENA_RESULT_SCORE" ) );
	
end


function luaArena:OnLoadedArenaResultListRed()

	lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.NAME,	STR( "ARENA_RESULT_NAME" ) );
	lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.LEVEL,	STR( "ARENA_RESULT_LEVEL" ) );
	lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.KILL,	STR( "ARENA_RESULT_KILL" ) );
	lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.RESULT,	STR( "ARENA_RESULT_RESULT" ) );
	lcArenaResultListRed:SetColumnText( luaArena.RESULT_COLUME.SCORE,	STR( "ARENA_RESULT_SCORE" ) );

end



-- OpenShowChannelExitFrame
function luaArena:OpenShowChannelExitFrame()

	luaArena.m_fProgressTimer = gamefunc:GetUpdateTime();
	
	-- Reposition frame
	local x, y = frmArenaChannelExitButton:GetParent():GetPosition();
	local w, h = frmArenaChannelExitButton:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmArenaChannelExitButton:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
    
	frmArenaChannelExitButton:Show( true);

	gamefunc:ShowCursor( true);
end


-- OnUpdateArenaChannelExitProgress
function luaArena:OnUpdateArenaChannelExitProgress()

	local nPos = gamefunc:GetUpdateTime() - luaArena.m_fProgressTimer;
	pcArenaChannelExitProgress:SetPos( nPos);

	if ( nPos >= 10000)  then
		
		gamefunc:ArenaExit();
        gamefunc:LeaveDynamicField();
		frmArenaChannelExitButton:Show( false );
	end
end


-- OpenRankingPage
function luaArena:OpenRankingPage()

	tbcSocialTabCtrl:SetSelIndex( 2);
	frmSocial:Show( true);
	luaRanking:SelChangeRankingTab();

end