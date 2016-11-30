--[[
	Game accept quest LUA script
--]]


-- Global instance
luaAcceptQuest = {};


-- Quest ID
luaAcceptQuest.m_nQuestID = 0;


-- Flag to accepted quest
luaAcceptQuest.m_bAcceptedQuest = false;


-- Scroll timer
luaAcceptQuest.m_fScrollTimer = 0;





-- SetQuestID , GetQuestID
function luaAcceptQuest:SetQuestID( nID)

	luaAcceptQuest.m_nQuestID = nID;
end


function luaAcceptQuest:GetQuestID()

	return luaAcceptQuest.m_nQuestID;
end





-- OnShowAcceptQuestFrame
function luaAcceptQuest:OnShowAcceptQuestFrame()

	-- Show
	if ( frmAcceptQuest:GetShow() == true)  then

		luaAcceptQuest.m_bAcceptedQuest = false;

		luaAcceptQuest:OpenScrolledPaper();
		luaAcceptQuest:RefreshAcceptQuest();


	-- Hide
   	else
	
		gamefunc:RequestNpcInteractionEnd();
		
		if ( luaAcceptQuest.m_bAcceptedQuest == false)  then  gamefunc:RejectQuest();
		end
	end
	
	
	luaGame:ShowWindow( frmAcceptQuest);
end





-- RefreshAcceptQuest
function luaAcceptQuest:RefreshAcceptQuest()

	if ( frmAcceptQuest:GetShow() == false)  then  return;
	end
	
	
	local nID = luaAcceptQuest:GetQuestID();
	local strText = "{CR}" .. luaQuest:GetQuestDescription( nID, true);
	
	tvwAcceptQuest:SetText( luaGame:ConvertStrToDialogSentence( strText));
end





-- OpenScrolledPaper
function luaAcceptQuest:OpenScrolledPaper()

	luaAcceptQuest.m_fScrollTimer = gamefunc:GetUpdateTime();
end





-- OnUpdateAcceptQuestFrame
function luaAcceptQuest:OnUpdateAcceptQuestFrame()

	local fElapsed = gamefunc:GetUpdateTime() - luaAcceptQuest.m_fScrollTimer - 250.0;
	if ( fElapsed < 0.0)  then
	
		fElapsed = 0.0;
		tvwAcceptQuest:Show( false);
	else
	
		tvwAcceptQuest:Show( true);
	end
	
	local h = 560  +  math.min( 0.0, 0.8 * fElapsed - 460.0) * math.cos( fElapsed * 0.003);
	pnlAcceptQuestScroll:SetSize( pnlAcceptQuestScroll:GetWidth(), h);
end





-- OnToolTipAcceptQuest
function luaAcceptQuest:OnToolTipAcceptQuest()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwAcceptQuest:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);

		-- Set tooltip
		if (strType == "item")  or  (strType == "selitem")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
			end
		end
	end

	tvwAcceptQuest:SetToolTip( strToolTip);
end





-- OnClickAcceptQuest
function luaAcceptQuest:OnClickAcceptQuest()

	local nID = luaAcceptQuest:GetQuestID();
	if ( nID >= 0)  then
	
		-- Accept quest
		gamefunc:AcceptQuest( nID);
		

		-- Play sound		
		gamefunc:PlaySound( "button_agree");
	end


	luaAcceptQuest.m_bAcceptedQuest = true;
	frmAcceptQuest:Show( false);
end
