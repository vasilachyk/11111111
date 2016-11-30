--[[
	Game quest LUA script
--]]


-- Global instance
luaQuest = {};


g_nQuestShare = {};


-- RefreshQuest
function luaQuest:RefreshQuest()

	luaQuest:RefreshQuestList();
	luaQuest:RefreshQuestDescription();
	luaQuest:RefreshControls();
end



local arrayCategory = {};
	arrayCategory.strName = {};
	arrayCategory.nIndex = {};
local nCategoryCount = 0;





-- RefreshQuestList
function luaQuest:RefreshQuestList()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 0)  then  return;
	end


	-- Add quest item
	arrayCategory = {};
	arrayCategory.strName = {};
	arrayCategory.nIndex = {};
	nCategoryCount = 0;

	-- 
	luaQuest:_RefreshQuestList();
	
	-- 
	luaQuest:_RefreshShareQuestList();
	
	luaJournal.DirectViewVar.nType = 0;
	luaJournal.DirectViewVar.nID = 0;
end




function luaQuest:_RefreshQuestList()

	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	ctvQuestList:DeleteAllItems();

	local nCount = gamefunc:GetPlayerQuestCount();
	for  i = 0, (nCount - 1)  do
	
		local nID = gamefunc:GetPlayerQuestID( i);
		local strName = gamefunc:GetQuestName( nID);
		local strCategory = gamefunc:GetQuestCategory( nID);
		if ( strCategory == nil)  or  ( strCategory == "")  then  strCategory = STR( "MISCELLANEOUS");
		end
		
		local bChallengerQuest = gamefunc:IsPlayerChallengerQuest( nID);
		
		
		-- Find category
		local nCategoryIndex = -1;
		for j = 0, (nCategoryCount - 1)  do
		
			if ( arrayCategory.strName[ j] == strCategory)  then
			
				-- Exist category
				nCategoryIndex = arrayCategory.nIndex[ j];
				break;
			end
		end
		
		
		-- Add category
		if ( nCategoryIndex < 0)  then

			nCategoryIndex = ctvQuestList:AddCategory( strCategory);
			ctvQuestList:SetCategoryExpand( nCategoryIndex, true);

			arrayCategory.strName[ nCategoryCount] = strCategory;
			arrayCategory.nIndex[ nCategoryCount] = nCategoryIndex;
			nCategoryCount = nCategoryCount + 1;
		end


		-- Get icon
		local strIcon = "iconScroll";
		if ( gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.QUEST, nID) == true)  then  strIcon = strIcon .. "Ind";
		end
		

		-- Add quest
		local nIndex = ctvQuestList:AddItem( nCategoryIndex, strName, strIcon);
		ctvQuestList:SetItemData( nCategoryIndex, nIndex, nID);
		
		
		-- Add type
		if ( bChallengerQuest == true)  then  ctvQuestList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_CHALLENGEQUEST"));
		end
		
		local bAutoParty = gamefunc:IsAutoPartyQuest( nID);
		if ( bAutoParty == true)  then	ctvQuestList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_SHAREDQUEST"));
		end
		
		-- Check direct view
		if ( luaJournal.DirectViewVar.nType == JOURNALOBJ_TYPE.QUEST)  and  ( luaJournal.DirectViewVar.nID == nID)  then
		
			nCurSelCategory = nCategoryIndex;
			nCurSelItem = nIndex;
		end
	end
	
	ctvQuestList:SetCurSel( nCurSelCategory, nCurSelItem);
	
end

function luaQuest:_RefreshShareQuestList()

	-- share
	local nShareCount = table.getn(g_nQuestShare);
	for i = 1, nShareCount do
	
		local nID = g_nQuestShare[i];
		local strName = gamefunc:GetQuestName( nID);
		local strCategory = STR( "UI_JOURNAL_SHAREDQUEST");
		
		local bChallengerQuest = gamefunc:IsPlayerChallengerQuest( nID);
		
		-- Find category
		local nCategoryIndex = -1;
		for j = 0, (nCategoryCount - 1)  do
		
			if ( arrayCategory.strName[ j] == strCategory)  then
			
				-- Exist category
				nCategoryIndex = arrayCategory.nIndex[ j];
				break;
			end
		end
		
		
		-- Add category
		if ( nCategoryIndex < 0)  then

			nCategoryIndex = ctvQuestList:AddCategory( strCategory);
			ctvQuestList:SetCategoryExpand( nCategoryIndex, true);

			arrayCategory.strName[ nCategoryCount] = strCategory;
			arrayCategory.nIndex[ nCategoryCount] = nCategoryIndex;
			nCategoryCount = nCategoryCount + 1;
		end


		-- Get icon
		local strIcon = "iconScroll";
		if ( gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.QUEST, nID) == true)  then  strIcon = strIcon .. "Ind";
		end
		

		-- Add quest
		local nIndex = ctvQuestList:AddItem( nCategoryIndex, strName, strIcon);
		ctvQuestList:SetItemData( nCategoryIndex, nIndex, nID);
		ctvQuestList:SetItemColor( nCategoryIndex, nIndex, 0, 255, 64, 64);
		
		
		-- Add type
		if ( bChallengerQuest == true)  then  ctvQuestList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_CHALLENGEQUEST"));
		end
		
	end
end






-- RefreshQuestDescription
function luaQuest:RefreshQuestDescription()

	tvwJournalDesc:Clear();


	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID <= 0)  then  return;
	end
	

	local strText = "{CR}" .. luaQuest:GetQuestDescription( nID, true);
	tvwJournalDesc:SetText( luaGame:ConvertStrToDialogSentence( strText));
end





-- GetQuestDescription
function luaQuest:GetQuestDescription( nQuestID, bIncludeDescription)

	if ( nQuestID <= 0)  then  return "";
	end
	

	-- Write title and description
	local strName = gamefunc:GetQuestName( nQuestID);
	local strDesc = gamefunc:GetQuestDesc( nQuestID);
	local strText = "{CR}{FONT name=\"fntHeadline\"}{COLOR r=250 g=230 b=210}" .. strName .. "{/COLOR}{/FONT}\n"
	
	
	-- Description and objective	
	if ( bIncludeDescription == true)  then

		-- Write description
		strText = strText .. "{INDENT}" .. strDesc .. "\n";
		

		-- Write quest objective
		local nQuestObjectiveCount = gamefunc:GetQuestObjectiveCount( nQuestID);
		if ( nQuestObjectiveCount > 0)  then

			strText = strText .. "{INDENT}";
			
			for  i = 0, (nQuestObjectiveCount - 1)  do
			
				local strQObjName = gamefunc:GetQuestObjectiveText( nQuestID, i);
				local bQObjCompleted = gamefunc:IsPlayerQuestObjectiveCompleted( nQuestID, i);
				local bQuestFailed	= gamefunc:IsPlayerQuestFailed( nQuestID);


				-- Icon
				strText = strText .. "{BITMAP name=\"iconScroll\" w=18 h=18}" .. strQObjName;
				
				
				-- Progress
				local nQObjType = gamefunc:GetQuestObjectiveType( nQuestID, i);
				
				if ( bQObjCompleted == true)  then

					strText = strText .. " (" .. STR( "UI_COMPLETE") .. ")";
					
				elseif (bQuestFailed == true)  then
				
					strText = strText .. " (" .. STR( "UI_FAIL") .. ")";
				
				else
				
					if (nQObjType == QUESTOBJECT_TYPE.DESTROY)  or  (nQObjType == QUESTOBJECT_TYPE.COLLECT) or (nQObjType == QUESTOBJECT_TYPE.INTERACT) then

						local nCurProgress = gamefunc:GetPlayerQuestObjectiveProgress( nQuestID, i);
						local nProgress = gamefunc:GetQuestObjectiveProgress( nQuestID, i);
					
						strText = strText .. " (" .. nCurProgress .. "/" .. nProgress .. ")";
					end
				end
				
				strText = strText .. "{CR}";
			end
		end
		
		strText = strText .. "\n";
	end
		
	
	
	-- Reward
	local nQuestRewardCount = gamefunc:GetQuestRewardCount( nQuestID);
	local nQuestSelectableRewardCount = gamefunc:GetQuestSelectableRewardCount( nQuestID);
	
	if ( bIncludeDescription == true)  and  ( (nQuestRewardCount > 0)  or  (nQuestSelectableRewardCount > 0))  then

		strText = strText .. "{/INDENT}{FONT name=\"fntHeadline\"}{COLOR r=250 g=230 b=210}" .. STR( "UI_JOURNAL_REWARDITEM") .. "{/COLOR}{/FONT}\n"
	end


	-- Write reward
	if ( nQuestRewardCount > 0)  then
	
		strText = strText .. "{INDENT}{ALIGN ver=\"center\"}" .. STR( "UI_JOURNAL_CHECKREWARD") .. "{CR}{/INDENT}";

		for  i = 0, (nQuestRewardCount - 1)  do
		
			local nQuestRewardType = gamefunc:GetQuestRewardType( nQuestID, i);
			local nQuestRewardValue = gamefunc:GetQuestRewardValue( nQuestID, i);
			local nQuestRewardAmount = gamefunc:GetQuestRewardAmount( nQuestID, i);
			

			local strName = "";
			local strImage = "iconUnknown";
			local strAmount = "";
			local strReference = "";

			if ( nQuestRewardType == QUESTREWARD_TYPE.MONEY)  then
				strName = STR( "MONEY");
				strImage = "iconMoney";
				strReference = "money://" .. nQuestRewardAmount;
				strAmount = "{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nQuestRewardAmount, "fntSmallStrong");
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.EXPERIENCE)  then
				strName = STR( "EXP");
				strImage = "iconExp";
				strReference = "exp://" .. nQuestRewardAmount;
				strAmount = nQuestRewardAmount .. "{FONT name=\"fntSmall\"} EXP{/FONT}";
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.FACTION)  then
				local strfactionName = gamefunc:GetFactionName(nQuestRewardValue);
				strName = STR( "FACTION") .. " : " .. strfactionName;
				strImage = "iconFaction";
				strReference = "faction://" .. nQuestRewardAmount;
				strAmount = FORMAT( "UI_JOURNAL_INCREASE", nQuestRewardAmount);
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.ITEM)  then
					
				local nRewardItemID = nQuestRewardValue;
				strName = gamefunc:GetItemName( nQuestRewardValue);
				strImage = gamefunc:GetItemImage( nQuestRewardValue);
				strReference = "item://" .. nRewardItemID;
				strAmount = STR( "QUANTITY") .. nQuestRewardAmount;
			end
			
			
			strText = strText .. "{INDENT}{REF text=\"" .. strReference .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
					"{INDENT dent=2}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=3}" ..
					"{INDENT dent=50}{FONT name=\"fntRegularWeak\"}" .. strName .. "{/FONT}{CR h=18}";
					
			if ( nQuestRewardType == QUESTREWARD_TYPE.MONEY)  then
				strText = strText .. "{FONT name=\"fntScriptStrong\"}" .. strAmount .. "{/FONT}{CR h=23}{/INDENT}";
			else
				strText = strText .. "{FONT name=\"fntScriptWeak\"}" .. strAmount .. "{/FONT}{CR h=23}{/INDENT}";
			end
			
		end
	end


	-- Write selectable reward
	if ( nQuestSelectableRewardCount > 0)  then
	
		if ( nQuestRewardCount > 0)  then  strText = strText .. "{CR}";
		end
		
		strText = strText .. "{INDENT}{ALIGN ver=\"center\"}{FONT name=\"fntRegularWeak\"}" .. STR( "UI_JOURNAL_SELECTONEREWARD") .. "{CR}{/INDENT}";
		
		for  i = 0, (nQuestSelectableRewardCount - 1)  do

			local nQuestRewardType = gamefunc:GetQuestSelectableRewardType( nQuestID, i);
			local nQuestRewardValue = gamefunc:GetQuestSelectableRewardValue( nQuestID, i);
			local nQuestRewardAmount = gamefunc:GetQuestSelectableRewardAmount( nQuestID, i);
			

			local strName = "";
			local strImage = "iconUnknown";
			local strAmount = "";
			local strReference = "0";

			if ( nQuestRewardType == QUESTREWARD_TYPE.MONEY)  then
				strName = STR( "MONEY");
				strImage = "iconMoney";
				strReference = "selmoney://" .. nQuestRewardAmount;
				strAmount = "{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nQuestRewardAmount, "fntSmallStrong");
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.EXPERIENCE)  then
				strName = STR( "EXP");
				strImage = "iconExp";
				strReference = "selexp://" .. nQuestRewardAmount;
				strAmount = nQuestRewardAmount .. "{FONT name=\"fntSmall\"} EXP{/FONT}";
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.FACTION)  then
				local strfactionName = gamefunc:GetFactionName(nQuestRewardValue);
				strName = STR( "FACTION") .. " : " .. strfactionName;
				strImage = "iconFaction";
				strReference = "selfaction://" .. nQuestRewardAmount;
				strAmount = FORMAT( "UI_JOURNAL_INCREASE", nQuestRewardAmount);
				
			elseif ( nQuestRewardType == QUESTREWARD_TYPE.ITEM)  then
					
				local nRewardItemID = nQuestRewardValue;
				strName = gamefunc:GetItemName( nQuestRewardValue);
				strImage = gamefunc:GetItemImage( nQuestRewardValue);
				strReference = "selitem://" .. nRewardItemID .. "&" .. i;
				strAmount = STR( "QUANTITY") .. nQuestRewardAmount;
			end
			
			
			strText = strText .. "{INDENT}{REF text=\"" .. strReference .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
					"{INDENT dent=2}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=3}" ..
					"{INDENT dent=50}{FONT name=\"fntRegularWeak\"}" .. strName .. "{/FONT}{CR h=18}";
					
			if ( nQuestRewardType == QUESTREWARD_TYPE.MONEY)  then
				strText = strText .. "{FONT name=\"fntScriptStrong\"}" .. strAmount .. "{/FONT}{CR h=23}{/INDENT}";
			else
				strText = strText .. "{FONT name=\"fntScriptWeak\"}" .. strAmount .. "{/FONT}{CR h=23}{/INDENT}";
			end
		end
	end
	
	return strText;
end





-- RefreshControls
function luaQuest:RefreshControls()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then

		btnIndicateQuest:SetText( STR( "UI_JOURNAL_INDICATEQUEST"));
		btnIndicateQuest:Enable( false);
		btnShareQuest:Enable( false);
		btnGiveupQuest:Enable( false);

		return;
	end
	
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID > 0)  then
	
		local bIsIndicated = gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.QUEST, nID);
		if ( bIsIndicated == true)  then	btnIndicateQuest:SetText( STR( "UI_JOURNAL_NOTINDICATEQUEST"));
		else								btnIndicateQuest:SetText( STR( "UI_JOURNAL_INDICATEQUEST"));
		end

		btnIndicateQuest:Enable( true);
		
		local bShare = gamefunc:IsQuestShareable(nID);
		btnShareQuest:Enable( bShare);
		
		if ( gamefunc:IsPlayerChallengerQuest( nID) == true)  then		btnGiveupQuest:Enable( false);
		else															btnGiveupQuest:Enable( true);
		end
	
		local strCurSelCategory = ctvQuestList:GetCategoryText(nCurSelCategory)
		if ( strCurSelCategory == STR( "UI_JOURNAL_SHAREDQUEST")) then
		
			btnIndicateQuest:Enable( false);
			btnShareQuest:SetText( STR( "UI_JOURNAL_RECIEVESHAREDQUEST"));
			btnShareQuest:Enable( true);
			btnGiveupQuest:Enable( false);
		else
		
			btnShareQuest:SetText( STR( "UI_JOURNAL_SHAREQUEST"));
		end	

	else

		btnIndicateQuest:SetText( STR( "UI_JOURNAL_INDICATEQUEST"));
		btnIndicateQuest:Enable( false);
		btnShareQuest:Enable( false);
		btnGiveupQuest:Enable( false);
	end
	
	luaExpo:RefreshQuest();
	
end





-- OnSelChangeQuestList
function luaQuest:OnSelChangeQuestList()

	luaQuest:RefreshQuestDescription();
	luaQuest:RefreshControls();
end





-- OnItemClickQuestList
function luaQuest:OnItemClickQuestList()

	if ( EventArgs.shift == true)  then  luaQuest:IndicateCurSelQuest();
	end
end





-- IndicateCurSelQuest
function luaQuest:IndicateCurSelQuest()

	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID <= 0)  then  return;
	end
	
	local strCurSelCategory = ctvQuestList:GetCategoryText(nCurSelCategory)
	if ( strCurSelCategory == STR( "UI_JOURNAL_SHAREDQUEST")) then
		luaQuest:OnShareQuest();
		return;
	end


	if ( gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.QUEST, nID) == false)  then
	
		gamefunc:AddJournal( JOURNALOBJ_TYPE.QUEST, nID);
		jiJournalIndicator:AddItem( JOURNALOBJ_TYPE.QUEST, nID);
		
	else

		gamefunc:RemoveJournal( JOURNALOBJ_TYPE.QUEST, nID);
		jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.QUEST, nID);
	end
	
	
	luaQuest:RefreshQuestList();
	luaQuest:RefreshControls();
end





-- OnShareQuest
function luaQuest:OnShareQuest()

	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID <= 0)  then  return;
	end
	
	local strCurSelCategory = ctvQuestList:GetCategoryText(nCurSelCategory)
	if ( strCurSelCategory == STR( "UI_JOURNAL_SHAREDQUEST")) then

		local nCount = table.getn(g_nQuestShare);
		for i = 1, nCount do
			if (nID == g_nQuestShare[i]) then
				table.remove(g_nQuestShare, i)
			end
		end
	
		btnShareQuest:SetText( STR( "UI_JOURNAL_SHAREQUEST"));
		btnShareQuest:Enable( false);

		gamefunc:AcceptShareQuest( nID);

		tvwJournalDesc:Clear();
		luaQuest:RefreshQuestList();
		luaQuest:RefreshControls();
	
		return;
	end

	gamefunc:ShareQuest( nID);
end














-- OpenConfirmGiveupQuest
function luaQuest:OpenConfirmGiveupQuest()

	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID <= 0)  then  return;
	end
	
	
	-- Reposition frame
	local x, y = frmConfirmGiveupQuest:GetParent():GetPosition();
	local w, h = frmConfirmGiveupQuest:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmGiveupQuest:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);

	btnGiveupQuest:Enable( false);
	frmConfirmGiveupQuest:DoModal();
end





-- CloseConfirmGiveupQuest
function luaQuest:CloseConfirmGiveupQuest()

	frmConfirmGiveupQuest:Show( false);
	-- btnGiveupQuest:Enable( true);
end





-- OnGiveupQuestOK
function luaQuest:OnGiveupQuestOK()

	local nCurSelCategory, nCurSelItem = ctvQuestList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nID = ctvQuestList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nID <= 0)  then  return;
	end
	

	gamefunc:GiveUpQuest( nID);

	luaQuest:CloseConfirmGiveupQuest();
end





-- OnGiveupQuestCancel
function luaQuest:OnGiveupQuestCancel()

	luaQuest:CloseConfirmGiveupQuest();
end
