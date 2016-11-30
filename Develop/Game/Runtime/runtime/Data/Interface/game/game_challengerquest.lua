--[[
	Game map LUA script
--]]


-- Global instance
luaChallengerQuest = {};


-- OnShow
function luaChallengerQuest:OnShow()
	
	-- Show
	if ( frmChallengerQuest:GetShow() == true)  then
	
		frmChallengerQuest:SetText( gamefunc:GetNpcName());
				
	-- Hide
	else

		gamefunc:RequestNpcInteractionEnd();
	end
	
	luaGame:ShowWindow( frmChallengerQuest);
end


function luaChallengerQuest:Refresh()

	if ( frmChallengerQuest:GetShow() == false)  then return
	end
	
	luaChallengerQuest:RefreshChallengerQuestList()
	luaChallengerQuest:RefreshChallengerQuestInfo()
	luaChallengerQuest:RefreshControls()
end

function luaChallengerQuest:RefreshChallengerQuestList()

	local nQuestCount = gamefunc:GetChallengerQuestCount();
	local nCurSel = math.max( 0, lcChallengerQuest:GetCaretPos());

	-- Add items
	lcChallengerQuest:DeleteAllItems();

	for  i = 0, (nQuestCount - 1)  do
	
		local nQuestID = gamefunc:GetChallengerQuestID(i);
		local strName = gamefunc:GetQuestName( nQuestID);
		local strIcon;
		
		if (strName == nil)  or  (strName == "")  then  strName = "Unknown";
		end
		if (strIcon == nil)  or  (strIcon == "")  then  strIcon = "iconUnknown";
		end

		local nIndex = lcChallengerQuest:AddItem( strName, strIcon);
		lcChallengerQuest:SetItemData( nIndex, i);
		
		if (gamefunc:GetChallengerQuestEnableType(i) ~= CHALLENGERQUESTUNABLETYPE.CQUT_OK) then
			lcChallengerQuest:SetItemEnable( nIndex, false);
		end

	end
	
	lcChallengerQuest:SetCaretPos( nCurSel);
end






-- RefreshChallengerQuestInfo
function luaChallengerQuest:RefreshChallengerQuestInfo()

	tvwChallengerQuestInfo:Clear();

	local nCurSel = lcChallengerQuest:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nIndex = lcChallengerQuest:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nQuestID = gamefunc:GetChallengerQuestID( nIndex);
	if ( nQuestID <= 0)  then  return;
	end

	
	local strText = luaQuest:GetQuestDescription( nQuestID, true);
	tvwChallengerQuestInfo:SetText( "{CR}" .. strText);
end




function luaChallengerQuest:RefreshControls()

	local nCurSel = lcChallengerQuest:GetCaretPos();
	if ( nCurSel < 0)  then
		btnGetChallengerQuest:Enable( false);
		return;
	end

	local nIndex = lcChallengerQuest:GetItemData( nCurSel);
	if ( nIndex < 0)  then
		btnGetChallengerQuest:Enable( false);
		return;
	end

	local nQuestID = gamefunc:GetChallengerQuestID( nIndex);
	if ( nQuestID <= 0)  then
		btnGetChallengerQuest:Enable( false);
		return;
	end
	
	if (gamefunc:GetChallengerQuestEnableType(nIndex) ~= CHALLENGERQUESTUNABLETYPE.CQUT_OK) then
		btnGetChallengerQuest:Enable( false);
		return;
	end
	
	btnGetChallengerQuest:Enable( true);

end




function luaChallengerQuest:OnSelChangeChallengerQuestlc()

	luaChallengerQuest:RefreshChallengerQuestInfo()
	luaChallengerQuest:RefreshControls()
end






function luaChallengerQuest:OnClickGetChallengerQuest()

	local nCurSel = lcChallengerQuest:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nIndex = lcChallengerQuest:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nQuestID = gamefunc:GetChallengerQuestID( nIndex);
	if ( nQuestID <= 0)  then  return;
	end
	
	-- Accept quest
	gamefunc:AcceptQuest( nQuestID);
	

	-- Play sound		
	gamefunc:PlaySound( "button_agree");

end



function luaChallengerQuest:OnToolTipChangeChallengerQuestlc()

	local strToolTip = "";
	
	local nCurSel = lcChallengerQuest:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcChallengerQuest:GetItemData( nCurSel);
		local nQuestType = gamefunc:GetChallengerQuestEnableType(nIndex);
		if ( nQuestType == CHALLENGERQUESTUNABLETYPE.CQUT_FAIL_QUEST_CONDITION) then
			local nQuestID = gamefunc:GetChallengerQuestID( nIndex);
			strToolTip = gamefunc:GetChallengerQuestConditionText( nQuestID);
		elseif ( nQuestType == CHALLENGERQUESTUNABLETYPE.CQUT_FAIL_QUEST_NOT_TODAY) then
--			strToolTip = "¿À´ÃÀÇ Äù½ºÆ®°¡ ¾Æ´Õ´Ï´Ù.";
		end
	end

	lcChallengerQuest:SetToolTip( strToolTip);
end
