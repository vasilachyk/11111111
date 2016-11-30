--[[
	Game ranking LUA script
--]]


-- Global instance
luaHonorRanking = {};

luaHonorRanking.nSeasonDay = 7;
luaHonorRanking.nGuildSeasonDay = 14;

-- luaHonorRanking
function luaHonorRanking:CurSelDate()

	local nCurSel = cmbHonorRankingDateFilter:GetCurSel();
	if ( nCurSel < 0)  then return 0;
	end

	local nDate = cmbHonorRankingDateFilter:GetItemData( nCurSel);
	if ( nDate <= 0)  then return 0;
	end

	return nDate;
end


-- GetRankingType
function luaHonorRanking:GetRankingType()

	local nType = 0;
	local nCurSel = cmbHonorRankingFilter:GetCurSel();
	if ( nCurSel >= 0)  then  nType = cmbHonorRankingFilter:GetItemData( nCurSel);
	end

	return nType;
end


-- luaHonorRanking
function luaHonorRanking:SelChangeRankingTab()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 3)  then  return;
	end

	cmbHonorRankingFilter:SetCurSel( 0);
	cmbHonorRankingDateFilter:SetCurSel( 0);

	gamefunc:ArenaHonorSeasonListReq();
	luaHonorRanking:RefreshSeasonList()
	luaHonorRanking:RefreshHonorRanking();
end


-- OnSelChangeHonorRankingFilter
function luaHonorRanking:OnSelChangeHonorRankingFilter()

	luaHonorRanking:RefreshSeasonList()
	luaHonorRanking:RefreshHonorRanking();
end


-- RefreshSeasoningList
function luaHonorRanking:RefreshSeasonList()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 3)  then  return;

	end

	cmbHonorRankingDateFilter:ResetContent();

	if(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_PERSON) then
		luaHonorRanking:RefreshSeasonListPerson();
	elseif(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_GUILD) then
		luaHonorRanking:RefreshSeasonListGuild();
	end

    cmbHonorRankingDateFilter:SetCurSel( 0);
	
end

-- RefreshSeasonListPerson
function luaHonorRanking:RefreshSeasonListPerson()
	
	local nCount = gamefunc:GetArenaHonorSeasonListCount();
	if ( nCount == 0)  then	return;
	end

	for i = 0, (nCount - 1)  do
		
		local nIndex = nCount - 1 - i;
		local nDate = gamefunc:GetArenaHonorSeasonDate(nIndex);
		local nYear, nMonth, nDay = gamefunc:GetIntToDate(nDate);
		if(nMonth < 10) then 
			nMonth = "0" .. nMonth;
		end
		if(nDay < 10) then 
			nDay = "0" .. nDay;
		end
		local strDate = nYear .. STR("UNIT_YEAR") .. " " .. nMonth .. STR("UNIT_MONTH") .. " " .. nDay .. STR("UNIT_DAY");

		local nPreDate = gamefunc:GetElapsedDate(nDate, -luaHonorRanking.nSeasonDay);
		local nPreYear, nPreMonth, nPreDay = gamefunc:GetIntToDate(nPreDate);
		if(nPreMonth < 10) then 
			nPreMonth = "0" .. nPreMonth;
		end
		if(nPreDay < 10) then 
			nPreDay = "0" .. nPreDay;
		end
		local strPreDate = nPreYear .. STR("UNIT_YEAR") .. " " .. nPreMonth .. STR("UNIT_MONTH") .. " " .. nPreDay .. STR("UNIT_DAY");
		

		local nIndex = cmbHonorRankingDateFilter:AddString(strPreDate .. " ~ " .. strDate);
		cmbHonorRankingDateFilter:SetItemData( nIndex, nDate);
	end	

	gamefunc:ArenaHonorRankerInfoReq( gamefunc:GetArenaHonorSeasonDate(nCount - 1) );
end

-- RefreshSeasonListGuild
function luaHonorRanking:RefreshSeasonListGuild()

	local nCount = gamefunc:GetArenaGuildHonorSeasonListCount();
	if ( nCount == 0)  then	return;
	end

	for i = 0, (nCount - 1)  do
		
		local nIndex = nCount - 1 - i;
		local nDate = gamefunc:GetArenaGuildHonorSeasonDate(nIndex);
		local nYear, nMonth, nDay = gamefunc:GetIntToDate(nDate);
		if(nMonth < 10) then 
			nMonth = "0" .. nMonth;
		end
		if(nDay < 10) then 
			nDay = "0" .. nDay;
		end
		local strDate = nYear .. STR("UNIT_YEAR") .. " " .. nMonth .. STR("UNIT_MONTH") .. " " .. nDay .. STR("UNIT_DAY");

		local nPreDate = gamefunc:GetElapsedDate(nDate, -luaHonorRanking.nGuildSeasonDay);
		local nPreYear, nPreMonth, nPreDay = gamefunc:GetIntToDate(nPreDate);
		if(nPreMonth < 10) then 
			nPreMonth = "0" .. nPreMonth;
		end
		if(nPreDay < 10) then 
			nPreDay = "0" .. nPreDay;
		end
		local strPreDate = nPreYear .. STR("UNIT_YEAR") .. " " .. nPreMonth .. STR("UNIT_MONTH") .. " " .. nPreDay .. STR("UNIT_DAY");
		

		local nIndex = cmbHonorRankingDateFilter:AddString(strPreDate .. " ~ " .. strDate);
		cmbHonorRankingDateFilter:SetItemData( nIndex, nDate);
	end	

	gamefunc:ArenaGuildHonorRankerInfoReq( gamefunc:GetArenaGuildHonorSeasonDate(nCount - 1) );
end


-- OnSelChangeHonorRankingDateFilter
function luaHonorRanking:OnSelChangeHonorRankingDateFilter()

	if(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_PERSON) then
		gamefunc:ArenaHonorRankerInfoReq(luaHonorRanking:CurSelDate());
	elseif(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_GUILD) then
		gamefunc:ArenaGuildHonorRankerInfoReq(luaHonorRanking:CurSelDate());
	end
	
	luaHonorRanking:RefreshHonorRanking();
end



-- RefreshHonorRanking
function luaHonorRanking:RefreshHonorRanking()

	--gamedebug:Log( "luaHonorRanking:RefreshHonorRanking()\n");
	luaHonorRanking:RefreshControls();
	luaHonorRanking:RefreshHonorRankingList();
	
end


-- RefreshControls
function luaHonorRanking:RefreshControls()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 3)  then  return;
	end

end



-- RefreshHonorRankingList
function luaHonorRanking:RefreshHonorRankingList()

	if ( frmSocial:GetShow() == false)  or  ( tbcSocialTabCtrl:GetSelIndex() ~= 3)  then  return;
	end
	
	if(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_PERSON) then
		luaHonorRanking:RefreshHonorRankingListPerson();
	elseif(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_GUILD) then
		luaHonorRanking:RefreshHonorRankingListGuild();
	end

end

-- RefreshHonorRankingListPerson
function luaHonorRanking:RefreshHonorRankingListPerson()

	lcHonorRankingList:DeleteAllItems();

	local nDate = luaHonorRanking:CurSelDate();
	if ( nDate <= 0)  then return;
	end
	
	local nCount = gamefunc:GetArenaHonorRankerCount(nDate);
	if ( nCount == 0)  then	return;
	end

	for i = 0, (nCount - 1)  do

		local nIndex = lcHonorRankingList:AddItem( "", "");
		lcHonorRankingList:SetItemData( nIndex, i);
	end	
end


-- RefreshHonorRankingListGuild
function luaHonorRanking:RefreshHonorRankingListGuild()
	
	lcHonorRankingList:DeleteAllItems();

	local nDate = luaHonorRanking:CurSelDate();
	if ( nDate <= 0)  then return;
	end
	
	local nCount = gamefunc:GetArenaGuildHonorRankerCount(nDate);
	if ( nCount == 0)  then	return;
	end

	for i = 0, (nCount - 1)  do

		local nIndex = lcHonorRankingList:AddItem( "", "");
		lcHonorRankingList:SetItemData( nIndex, i);
	end	
end


-- OnDrawHonorRankerInfo
function luaHonorRanking:OnDrawHonorRankerInfo()

	-- 현재 선택된 시즌 콤보리스트의 년월일 키값 구하기
	local nDate = luaHonorRanking:CurSelDate();
	if ( nDate <= 0)  then return;
	end

	-- 현재 그려야할 리스트 인덱스 구하기
	local nSubItem = EventArgs:GetItemSubItem();
	if ( nSubItem ~= 0 ) then return;
	end

	local nSlotIndex = EventArgs:GetItemIndex();
	if ( nSlotIndex < 0)  then  return;
	end

	local nIndex = lcHonorRankingList:GetItemData(nSlotIndex);
	if ( nIndex < 0)  then  return;
	end

	local tRankerInfo = {};

	if(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_PERSON) then
		tRankerInfo.strName			= gamefunc:GetArenaHonorRankerName(nDate, nIndex);
		tRankerInfo.strGuildName	= gamefunc:GetArenaHonorRankerGuileName(nDate, nIndex);
		tRankerInfo.nTitleStyle		= gamefunc:GetArenaHonorRankerTitleStyle(nDate, nIndex);
		tRankerInfo.nScorePoint		= gamefunc:GetArenaHonorRankerScorePoint(nDate, nIndex);
		tRankerInfo.nWins			= gamefunc:GetArenaHonorRankerWins(nDate, nIndex);
		tRankerInfo.nLoses			= gamefunc:GetArenaHonorRankerLoses(nDate, nIndex);
		tRankerInfo.nRanking		= gamefunc:GetArenaHonorRankerRanking(nDate, nIndex);
		tRankerInfo.nDeltaRanking	= gamefunc:GetArenaHonorRankerDeltaRanking(nDate, nIndex);

	elseif(luaHonorRanking:GetRankingType() == RANKING_TYPE.RT_GUILD) then
		tRankerInfo.strName			= gamefunc:GetArenaGuildHonorRankerName(nDate, nIndex);
		tRankerInfo.strGuildName	= gamefunc:GetArenaGuildHonorRankerGuileName(nDate, nIndex);
		tRankerInfo.nTitleStyle		= gamefunc:GetArenaGuildHonorRankerTitleStyle(nDate, nIndex);
		tRankerInfo.nScorePoint		= gamefunc:GetArenaGuildHonorRankerScorePoint(nDate, nIndex);
		tRankerInfo.nWins			= gamefunc:GetArenaGuildHonorRankerWins(nDate, nIndex);
		tRankerInfo.nLoses			= gamefunc:GetArenaGuildHonorRankerLoses(nDate, nIndex);
		tRankerInfo.nRanking		= gamefunc:GetArenaGuildHonorRankerRanking(nDate, nIndex);
		tRankerInfo.nDeltaRanking	= gamefunc:GetArenaGuildHonorRankerDeltaRanking(nDate, nIndex);
	end

	tRankerInfo.nIndex				= nIndex;
	tRankerInfo.bShowDeltaRanking	= false;
	tRankerInfo.nRankingType		= luaHonorRanking:GetRankingType();

	local x, y, w, h = EventArgs:GetItemRect();

	tRankerInfo.x = x;
	tRankerInfo.y = y;
	tRankerInfo.w = w;
	tRankerInfo.h = h;

	luaRanking:DrawRankerInfo(tRankerInfo);

end