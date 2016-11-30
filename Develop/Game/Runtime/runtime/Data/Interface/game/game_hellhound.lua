--[[
	Game hellhound LUA script
--]]


-- Global instance
luaHellhound = {};

-- Default Position
luaHellhound.nDefaultX	= 70;
luaHellhound.nDefaultY	= 100;


luaHellhound.FILTER_TYPE =
{
	A					= 1,
	B					= 2,
	C					= 3,
	D					= 4,
	E					= 5,
	F					= 6,
	G					= 7,
	H					= 8,
	I					= 9,
	MAX					= 10,
};

luaHellhound.QUEST_STATE =
{
	QST_NOEXIST			= 0,
	QST_EXIST			= 1,
	QST_COMPLETE		= 2,
	QST_FAIL			= 3,
	QST_MAX				= 4,
};

luaHellhound.LICENSE_LIST =
{
	LLT_GRADE_1			= 90400,
	LLT_GRADE_2			= 90401,
	LLT_GRADE_3			= 90402,
	LLT_GRADE_4			= 90403,
	LLT_GRADE_5			= 90404,
	LLT_GRADE_6			= 90405,
	LLT_GRADE_7			= 90406,
	LLT_GRADE_8			= 90407,
	LLT_GRADE_9			= 90408,
	LLT_GRADE_10		= 90409,
};


luaHellhound.nFilter	= luaHellhound.FILTER_TYPE.A;
luaHellhound.nQuestState = luaHellhound.QUEST_STATE.QST_NOEXIST;
luaHellhound.nModifyTokenid = 1450401;
luaHellhound.nDimensionTokenid = 1450402;

-- finish Effect image 
luaHellhound.fFinishRatioTime = 0.0;

-- finish Info
luaHellhound.nFinishQuestID = 0;
luaHellhound.fFinishScrollTime = 0.0;


-- ResetUI
function luaHellhound:ResetUI()
	
	frmHellhound:SetPosition( luaHellhound.nDefaultX, luaHellhound.nDefaultY );	
end


-- FieldChanged
function luaHellhound:FieldChanged()
	
	picHellhoundFinishEffect:Show(false);
	frmHellhoundFinishInfo:Show(false);
end


-- OnShowHellhoundFrame
function luaHellhound:OnShowHellhoundFrame()

	frmConfirmEnterHellhoundMission:Show( false);

	-- Show
	if ( frmHellhound:GetShow() == true)  then
	
		luaHellhound:OnLoadedHellhoundFilterTabCtrl();
		luaHellhound:RefreshHellhound();
	-- Hide
	else

	end
	
	
	luaGame:ShowWindow( frmHellhound);
end


function luaHellhound:OnLoadedHellhoundFilterTabCtrl()

	for  i = 0, (luaHellhound.FILTER_TYPE.MAX - 2)  do
		tbcHellhoundTypeFilter:SetTabShow( i, false);
	end

	for  i = 0, (gamefunc:GetHellhoundGroupCount() - 1)  do
	--for  i = 0, 2  do
		local nGroupID = gamefunc:GetHellhoundGroupIDIndex(i);
		local strTitle = gamefunc:GetHellhoundGroupTitle(nGroupID);

		if(strTitle == "title1") then
			strTitle = STR( "UI_HELLHOUND_TATLE_1");
		elseif(strTitle == "title2") then
			strTitle = STR( "UI_HELLHOUND_TATLE_2");
		elseif(strTitle == "title3") then
			strTitle = STR( "UI_HELLHOUND_TATLE_3");
		elseif(strTitle == "title4") then
			strTitle = STR( "UI_HELLHOUND_TATLE_4");
		elseif(strTitle == "title5") then
			strTitle = STR( "UI_HELLHOUND_TATLE_5");
		elseif(strTitle == "title6") then
			strTitle = STR( "UI_HELLHOUND_TATLE_6");
		elseif(strTitle == "title7") then
			strTitle = STR( "UI_HELLHOUND_TATLE_7");
		elseif(strTitle == "hellmode") then
			strTitle = STR( "UI_HELLHOUND_TATLE_HELL");
		end


		tbcHellhoundTypeFilter:SetTabShow( i, true);
		tbcHellhoundTypeFilter:SetTabName( i, strTitle);
	end
	
end


function luaHellhound:OnSelChangeHellhoundTypeFilter()

		if ( tbcHellhoundTypeFilter:GetSelIndex() == 0) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.A;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 1) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.B;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 2) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.C;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 3) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.D;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 4) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.E;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 5) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.F;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 6) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.G;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 7) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.H;
	elseif ( tbcHellhoundTypeFilter:GetSelIndex() == 8) then luaHellhound.nFilter = luaHellhound.FILTER_TYPE.I;
	end

	lcHellhound:SetCaretPos(0);
	luaHellhound:RefreshHellhound();
end


-- RefreshHellhound
function luaHellhound:RefreshHellhound()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	luaHellhound:RefreshHellhoundListCtrl();
	luaHellhound:RefreshHellhoundQuestInfo();
	luaHellhound:RefreshControls()
end


-- OnSelChangeHellhoundListCtrl
function luaHellhound:OnSelChangeHellhoundListCtrl()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	luaHellhound:RefreshHellhoundQuestInfo();
	luaHellhound:RefreshControls()
end


function luaHellhound:AddHellhoundList(nID, nGroupID, nQuestID)
	
	if(nQuestID <= 0) then return;
	end

	if(nGroupID ~= luaHellhound.nFilter) then return;
	end
	
	local strQuestName = gamefunc:GetQuestName(nQuestID);
	luaHellhound.nQuestState = gamefunc:GetQuestState(nQuestID);

	local _color = { r=255, g=255, b=0};
	if(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_EXIST) then
		strQuestName = strQuestName .. "(" .. STR( "ISUFFIXT_QUEST_DOING") .. ")";
		_color = { r=0, g=255, b=255};
	elseif(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_COMPLETE) then
		strQuestName = strQuestName .. "(" .. STR( "ISUFFIXT_QUEST_COMPLETE") .. ")";
		_color = { r=255, g=0, b=255};
	end

	strQuestName = gamedraw:SubTextWidth( "fntScript", strQuestName, 440 );
	local strIconName = gamefunc:GetHellhoundIcon(nID);
		

	local nIndex = lcHellhound:AddItem( strQuestName, strIconName);
	lcHellhound:SetItemColor( nIndex, 0, _color.r, _color.g, _color.b);
			
	lcHellhound:SetItemData( nIndex, nID);

	-- 컨디션 불충족시 비활성화
	if(gamefunc:CheckHellhoundCondition(nQuestID) == false) then
		lcHellhound:SetItemEnable( nIndex, false);
	end


	local nLevel = gamefunc:GetLevel();
	local nConditionID = gamefunc:GetHellhoundConditionID(nID);
	local nMinLevel = gamefunc:GetHellhoundLevelMin(nConditionID);

	_color = { r=100, g=160, b=160};
	if ( nLevel < nMinLevel)  then
		_color = { r=160, g=32, b=32};
	end

	local strLevel = FORMAT( "REQUIREDLEVEL", nMinLevel);
	lcHellhound:SetItemText( nIndex, 1, strLevel);
	lcHellhound:SetItemColor( nIndex, 1, _color.r, _color.g, _color.b);


	local strType = gamefunc:GetHellhoundMissionType(nID);
	if(strType == "kill") then
		strType = STR( "UI_HELLHOUND_MISSION_TYPE_KILL");
	elseif(strType == "destroy") then
		strType = STR( "UI_HELLHOUND_MISSION_TYPE_DESTROY");
	elseif(strType == "bparts") then
		strType = STR( "UI_HELLHOUND_MISSION_TYPE_BPARTS");
	elseif(strType == "capture") then
		strType = STR( "UI_HELLHOUND_MISSION_TYPE_CAPTURE");
	else
		strType = "";
	end
	lcHellhound:SetItemText( nIndex, 2, strType);


	local nDifficulty = gamefunc:GetHellhoundDifficulty(nID);
	local strDifficulty = "     ";
	for  i = 0, (nDifficulty - 1)  do
		strDifficulty = strDifficulty .. "*";
	end

	local strDifficultyColor = gamefunc:GetHellhoundDifficultyColor(nID);
	if(strDifficultyColor == "white") then
		_color = { r=255, g=255, b=255};
	elseif(strDifficultyColor == "yellow") then
		_color = { r=255, g=255, b=0};
	elseif(strDifficultyColor == "red") then
		_color = { r=255, g=0, b=0};
	else
		_color = { r=255, g=255, b=255};
	end

	lcHellhound:SetItemText( nIndex, 3, strDifficulty);
	lcHellhound:SetItemColor( nIndex, 3, _color.r, _color.g, _color.b);


	local nTokenItemID = gamefunc:GetHellhoundTokenItemID(nID);
	local nTokenItemQty = gamefunc:GetHellhoundTokenItemQty(nID);

	if(nTokenItemQty > 0) then
		local nInvenTokenQuantity = gamefunc:GetInvenItemQuantityByID(nTokenItemID);
	
		_color = { r=100, g=160, b=160};
		if ( nInvenTokenQuantity < nTokenItemQty)  then
			_color = { r=160, g=32, b=32};
		end

		local strToken = gamefunc:GetItemName(nTokenItemID).. ": " .. nTokenItemQty;
		lcHellhound:SetItemText( nIndex, 4, strToken);
		lcHellhound:SetItemColor( nIndex, 4, _color.r, _color.g, _color.b);
	end
	
end


function luaHellhound:OnDrawTodayQuestImage()

	local nSubItem = EventArgs:GetItemSubItem();
	if ( nSubItem ~= 0 ) then return;
	end

	local nSlotIndex = EventArgs:GetItemIndex();
	if ( nSlotIndex < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nSlotIndex);
	if ( nID <= 0)  then  return;
	end

	local nQuestID = gamefunc:GetHellhoundQuestID(nID);
	if ( nQuestID <= 0)  then  return;
	end

	local bTodayQuest = gamefunc:IsHellhoundTodayQuest(nQuestID);
	if(bTodayQuest == true)then

		local x, y, w, h = EventArgs:GetItemRect();
		gamedraw:SetBitmap( "hellhound_today");

		if(lcHellhound:GetItemEnable( nSlotIndex) == true) then
			gamedraw:DrawEx( x, y, 30, 30, 0, 0, 40, 40);
		else
			local r, g, b = gamedraw:SetBitmapColor( 100, 100, 100);
			gamedraw:DrawEx( x, y, 30, 30, 0, 0, 40, 40);
			gamedraw:SetBitmapColor( r, g, b);
		end
	end
end


function luaHellhound:RefreshHellhoundListCtrl()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	-- 보유 목록
	local strHaveHallhoundList = STR( "UI_HELLHOUND_HAVE_TOKEN") ..
		" [" .. gamefunc:GetItemName(luaHellhound.nModifyTokenid) .. ": " .. gamefunc:GetInvenItemQuantityByID(luaHellhound.nModifyTokenid) .. ", " ..
		gamefunc:GetItemName(luaHellhound.nDimensionTokenid) .. ": " .. gamefunc:GetInvenItemQuantityByID(luaHellhound.nDimensionTokenid) .. ", ";

	local strLicense = STR( "UI_HELLHOUND_HAVE_NOT_LICENSE");
	for  i = luaHellhound.LICENSE_LIST.LLT_GRADE_1, luaHellhound.LICENSE_LIST.LLT_GRADE_10  do
		if(gamefunc:IsLearnedTalent(i) == true) then
			strLicense = gamefunc:GetTalentName(i);
		end
	end

	strHaveHallhoundList = strHaveHallhoundList .. strLicense .. "]";
	labHaveHallhoundList:SetText(strHaveHallhoundList);




	local nCurSel = lcHellhound:GetCaretPos();
	local nCurScroll = lcHellhound:GetScrollValue();

	-- Add items
	lcHellhound:DeleteAllItems();

	-- 헬하운드 퀘스트 추가
	for  i = 0, (gamefunc:GetHellhoundCount() - 1)  do

		local nID = gamefunc:GetHellhoundID(i);
		local nGroupID = gamefunc:GetHellhoundGroupID(nID);
		local nQuestID = gamefunc:GetHellhoundQuestID(nID);

		luaHellhound:AddHellhoundList(nID, nGroupID, nQuestID)
	end


	lcHellhound:SetCaretPos(nCurSel);
	lcHellhound:SetScrollValue(nCurScroll);

end


function luaHellhound:RefreshHellhoundQuestInfo()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	tvwHellhoundQuestInfo:Clear();

	local nCurSel = lcHellhound:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end

	local nQuestID = gamefunc:GetHellhoundQuestID(nID);
	if ( nQuestID <= 0)  then  return;
	end

	local strText = "{CR}" .. luaQuest:GetQuestDescription( nQuestID, true);
	tvwHellhoundQuestInfo:SetText( luaGame:ConvertStrToQuestSentence( strText));
end


-- RefreshControls
function luaHellhound:RefreshControls()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	local nCurSel = lcHellhound:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end

	local nQuestID = gamefunc:GetHellhoundQuestID(nID);
	if ( nQuestID <= 0)  then  return;
	end

	luaHellhound.nQuestState = gamefunc:GetQuestState(nQuestID);

	if(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_EXIST) then
		btnHellhoundMissionPerform:SetText( STR( "UI_HELLHOUND_MiSSION_ENTER"));
	elseif(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_COMPLETE) then
		btnHellhoundMissionPerform:SetText( STR( "UI_HELLHOUND_MiSSION_REWARE_RECEIVE"));
	else
		btnHellhoundMissionPerform:SetText( STR( "UI_HELLHOUND_MiSSION_RECEIVE"));
	end

	btnHellhoundMissionPerform:Enable(lcHellhound:GetItemEnable( nCurSel));
end


-- OnClickHellhoundMissionPerform
function luaHellhound:OnClickHellhoundMissionPerform()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	if ( false == btnHellhoundMissionPerform:GetEnable()) then return;
	end

	local nCurSel = lcHellhound:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end

	local nQuestID = gamefunc:GetHellhoundQuestID(nID);
	if ( nQuestID <= 0)  then  return;
	end

	luaHellhound.nQuestState = gamefunc:GetQuestState(nQuestID);

	if(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_EXIST) then
		luaHellhound:OnShowConfirmEnterHellhoundMission();
	elseif(luaHellhound.nQuestState == luaHellhound.QUEST_STATE.QST_COMPLETE) then
		gamefunc:HellhoundMissionPerform(nID, 0);
	else
		gamefunc:HellhoundMissionPerform(nID, 0);
		luaHellhound:OnShowConfirmEnterHellhoundMission();
	end
end


-- EnterHellhoundMission
function luaHellhound:OnShowConfirmEnterHellhoundMission()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	local nCurSel = lcHellhound:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end

	local nQuestID = gamefunc:GetHellhoundQuestID(nID);
	if ( nQuestID <= 0)  then  return;
	end

	local strQuestName = "{COLOR r=0 g=255 b=255}" .. gamefunc:GetQuestName(nQuestID) .. "{/COLOR}";
	strQuestName = FORMAT( "UI_HELLHOUND_MISSION_CONFIRM_ENTER", strQuestName);

	tvwConfirmEnterHellhoundMission:SetText( strQuestName);
	-- Reposition frame
	local x, y = frmConfirmEnterHellhoundMission:GetParent():GetPosition();
	local w, h = frmConfirmEnterHellhoundMission:GetSize();
	local width, height = gamefunc:GetWindowSize();
	frmConfirmEnterHellhoundMission:SetPosition( 80, 200);
	frmConfirmEnterHellhoundMission:DoModal();
	frmConfirmEnterHellhoundMission:Show( true);

end


-- EnterHellhoundMission
function luaHellhound:EnterHellhoundMission()

	if ( frmHellhound:GetShow() == false)  then  return;
	end

	local nCurSel = lcHellhound:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nID = lcHellhound:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end

	gamefunc:HellhoundMissionPerform(nID, 0);

	frmHellhound:Show( false);
end


-- OnToolTipAccepthHellhoundQuest
function luaHellhound:OnToolTipAccepthHellhoundQuest()
	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwHellhoundQuestInfo:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);

		-- Set tooltip
		if (strType == "item")  or  (strType == "selitem")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
			end
		end
	end

	tvwHellhoundQuestInfo:SetToolTip( strToolTip);
end








-- 헬하운드 완료 UI

-- OnShowFinishEffect
function luaHellhound:OnShowFinishEffect(nQuestID)
	
	luaHellhound.nFinishQuestID = nQuestID;
	picHellhoundFinishEffect:Show(true);
	luaHellhound.fFinishRatioTime = gamefunc:GetUpdateTime();
	gamefunc:PlaySound( "hellhound_success" );
	gamefunc:PlaySound( "bgm_monster_clear" );
end


-- OnDrawFinishEffect
function luaHellhound:OnDrawFinishEffect()

	local w = gamefunc:GetWindowWidth();
	local h = gamefunc:GetWindowHeight();
	local x = w * 0.5;
	local y = h * 0.2;
	local nImageSizeX = 500;
	local nImageSizeY = 250;
	local nPosX = 0.0;
	local nPosY = 0.0;
	local nSizeX = 0.0;
	local nSizeY = 0.0;
	local fFinishStartTime = 3.7;
	local fFinishEndTime = 4.0;

	local fElapsed = (gamefunc:GetUpdateTime() - luaHellhound.fFinishRatioTime) * 0.001;

	if(fElapsed < 0.25) then
		picHellhoundFinishEffect:SetOpacity(fElapsed*3.4);
		nPosX = (1.0 - fElapsed*3.0) * nImageSizeX;
		nPosY = (1.0 - fElapsed*3.0) * nImageSizeY;
		nSizeX = nPosX;
		nSizeY = nPosY;

	elseif(fElapsed < 0.5) then
		picHellhoundFinishEffect:SetOpacity(1.0);
		nPosX = (math.sin(gamefunc:GetUpdateTime()) - 0.3) * (20.0 - fElapsed * 30.0);
		nPosY = (math.cos(gamefunc:GetUpdateTime()) - 0.3) * (20.0 - fElapsed * 30.0);
		
	elseif(fElapsed < fFinishStartTime) then
		picHellhoundFinishEffect:SetOpacity(1.0);

	elseif(fElapsed < fFinishEndTime) then
		local fFinishStratElapsed = fElapsed-fFinishStartTime;
		local fGapTime = fFinishEndTime - fFinishStartTime;
		picHellhoundFinishEffect:SetOpacity(1.0 - (fFinishStratElapsed)*(1.0/fGapTime));
		nPosX = (fFinishStratElapsed*(1.0/fGapTime)) * nImageSizeX;
		nPosY = (fFinishStratElapsed*(1.0/fGapTime)) * nImageSizeY;
		nSizeX = nPosX;
		nSizeY = nPosY;
	else
		picHellhoundFinishEffect:Show( false);
		frmHellhoundFinishInfo:Show( true);
		gamefunc:HellhoundMissionPerform(gamefunc:GetHellhoundIDByQuest(luaHellhound.nFinishQuestID), 0);
		return;
	end


	picHellhoundFinishEffect:SetPosition(x - nImageSizeX*0.5 - nPosX*0.5 , y - nPosY*0.5);
	picHellhoundFinishEffect:SetSize( nImageSizeX + nSizeX, nImageSizeY + nSizeY);
end


-- OnShowHellhoundFinishInfoFrame
function luaHellhound:OnShowHellhoundFinishInfoFrame()
	
	-- Show
	if ( frmHellhoundFinishInfo:GetShow() == true)  then
		
		luaHellhound.fFinishScrollTime = gamefunc:GetUpdateTime();

		--local strText = "{CR}{FONT name=\"fntHeadline\"}{COLOR r=97 g=255 b=87} ★MISSION COMPLETION★{/COLOR}{/FONT}{CR h=25}" .. luaQuest:GetQuestDescription( luaHellhound.nFinishQuestID, false);
		local strText = "{CR h=7}{FONT name=\"fntHeadline\"}{COLOR r=97 g=255 b=87}{SPACE w=120} {BITMAP name=\"hellhound_board\" w=80 h=80}{/COLOR}{/FONT}{CR h=58}" .. luaQuest:GetQuestDescription( luaHellhound.nFinishQuestID, false);
		tvwHellhoundFinishInfo:SetText( luaGame:ConvertStrToQuestSentence( strText));

		pnlHellhoundFinishInfoScroll:SetSize( pnlHellhoundFinishInfoScroll:GetWidth(), 100);

		gamefunc:ShowCursor( true);
	-- Hide
   	else
	
	end
end


-- OnUpdateHellhoundFinishInfoFrame
function luaHellhound:OnUpdateHellhoundFinishInfoFrame()

	local fElapsed = gamefunc:GetUpdateTime() - luaHellhound.fFinishScrollTime - 250.0;
	if ( fElapsed < 0.0)  then
	
		fElapsed = 0.0;
		tvwHellhoundFinishInfo:Show( false);
	else
	
		tvwHellhoundFinishInfo:Show( true);
	end
	
	local h = 560  +  math.min( 0.0, 0.8 * fElapsed - 460.0) * math.cos( fElapsed * 0.003);
	pnlHellhoundFinishInfoScroll:SetSize( pnlHellhoundFinishInfoScroll:GetWidth(), h);
end
	

-- OnToolTipHellhoundFinishInfo
function luaHellhound:OnToolTipHellhoundFinishInfo()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwHellhoundFinishInfo:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);

		-- Set tooltip
		if (strType == "item")  or  (strType == "selitem")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
			end
		end
	end

	tvwHellhoundFinishInfo:SetToolTip( strToolTip);
end


-- OnClickHellhoundFinishInfo
function luaHellhound:OnClickHellhoundFinishInfo()

	gamefunc:PlaySound( "button_agree" );
	frmHellhoundFinishInfo:Show( false);
end