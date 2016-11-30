--[[
	Game reward quest LUA script
--]]


-- Global instance
luaRewardQuest = {};


-- Quest ID
luaRewardQuest.m_nQuestID = 0;


-- Flag to rewarded quest
luaRewardQuest.m_bRewardedQuest = false;


-- Position of select item marker
luaRewardQuest.SelItemMarkerPos = {};
	luaRewardQuest.SelItemMarkerPos.sel = -1;
	luaRewardQuest.SelItemMarkerPos.x = 0;
	luaRewardQuest.SelItemMarkerPos.y = 0;


-- Scroll timer
luaRewardQuest.m_nScrollTimer = 0;





-- SetQuestID , GetQuestID
function luaRewardQuest:SetQuestID( nID)

	luaRewardQuest.m_nQuestID = nID;
end


function luaRewardQuest:GetQuestID()

	return luaRewardQuest.m_nQuestID;
end





-- OnShowRewardQuestFrame
function luaRewardQuest:OnShowRewardQuestFrame()

	-- Show
	if ( frmRewardQuest:GetShow() == true)  then
	
		luaRewardQuest.m_bRewardedQuest = false;

		luaRewardQuest:OpenScrolledPaper();		
		luaRewardQuest:RefreshRewardQuest();
	
	
	-- Hide
   	else
	
		if ( luaRewardQuest.m_bRewardedQuest == false)  then
		  gamefunc:RejectQuestRewardItem();
		  gamefunc:RequestNpcInteractionEnd();
		end
		
	end
	
	
	luaGame:ShowWindow( frmRewardQuest);
end





-- RefreshRewardQuest
function luaRewardQuest:RefreshRewardQuest()

	if ( frmRewardQuest:GetShow() == false)  then  return;
	end
	
	
	local nQuestID = luaRewardQuest:GetQuestID();
	local strText = "{CR}" .. luaQuest:GetQuestDescription( nQuestID, false);
	tvwRewardQuest:SetText( luaGame:ConvertStrToDialogSentence( strText));
	
	
	-- Update select item marker
	luaRewardQuest.SelItemMarkerPos.sel = -1;
	luaRewardQuest.SelItemMarkerPos.x = 0;
	luaRewardQuest.SelItemMarkerPos.y = 0;
	picSelItemMarker:Show( false);

	local nSelRewardItemCount = gamefunc:GetQuestSelectableRewardCount( nQuestID);
	if ( nSelRewardItemCount > 0)  then
	
		for  i = 0, ( tvwRewardQuest:GetRefCount() - 1)  do
		
			local strRefText = tvwRewardQuest:GetRefText( i);
			local strType, strData, nIndex = luaGame:GetReferenceTypeData( strRefText);
			
			if (strType == "selitem")  and  (nIndex == 0)  then
			
				local x, y, w, h = tvwRewardQuest:GetRefRect( i);
			
				luaRewardQuest.SelItemMarkerPos.sel = 0;
				luaRewardQuest.SelItemMarkerPos.x = x - 10;
				luaRewardQuest.SelItemMarkerPos.y = y - 25;
				
				picSelItemMarker:Show( true);
				
				break;
			end
		end
	end
end





-- OpenScrolledPaper
function luaRewardQuest:OpenScrolledPaper()

	luaRewardQuest.m_nScrollTimer = gamefunc:GetUpdateTime();
end





-- OnUpdateRewardQuestFrame
function luaRewardQuest:OnUpdateRewardQuestFrame()

	local fElapsed = gamefunc:GetUpdateTime() - luaRewardQuest.m_nScrollTimer - 250.0;
	if ( fElapsed < 0.0)  then
	
		fElapsed = 0.0;
		tvwRewardQuest:Show( false);
	else
	
		tvwRewardQuest:Show( true);
	end
	
	local h = 560  +  math.min( 0.0, 0.8 * fElapsed - 460.0) * math.cos( fElapsed * 0.003);
	pnlRewardQuestScroll:SetSize( pnlRewardQuestScroll:GetWidth(), h);
end





-- OnItemClickRewardQuest
function luaRewardQuest:OnItemClickRewardQuest()

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end
	
	
	local strRefText = tvwRewardQuest:GetRefText( nItemIndex);
	local strType, strData, nIndex = luaGame:GetReferenceTypeData( strRefText);
	
	
	-- Clicked selectable item
	if ( strType == "selitem")  then
	
		local x, y, w, h = EventArgs:GetItemRect();
		luaRewardQuest.SelItemMarkerPos.sel = nIndex;
		luaRewardQuest.SelItemMarkerPos.x = x - 10;
		luaRewardQuest.SelItemMarkerPos.y = y - 25;
		
		picSelItemMarker:Show( true);
		
		
		-- Play sound
		gamefunc:PlaySound( "button_skip");
	end	
end





-- OnToolTipRewardQuest
function luaRewardQuest:OnToolTipRewardQuest()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwRewardQuest:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);
		
		-- Set tooltip
		if (strType == "item") or ( strType == "selitem")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, 250, nil, nil);
			end
		end
	end

	tvwRewardQuest:SetToolTip( strToolTip);
end





-- OnUpdateSelItemMarker
function luaRewardQuest:OnUpdateSelItemMarker()

	local x = luaRewardQuest.SelItemMarkerPos.x;
	local y = luaRewardQuest.SelItemMarkerPos.y;
	local nScrollValue = tvwRewardQuest:GetScrollValue();
	
	picSelItemMarker:SetPosition( x, y - nScrollValue);
end





-- OnClickRewardQuest
function luaAcceptQuest:OnClickRewardQuest()

	local nQuestID = luaRewardQuest:GetQuestID();
	local nSelItem = luaRewardQuest.SelItemMarkerPos.sel;
	if ( nSelItem >= 0)  then		gamefunc:AcceptQuestRewardItem( nQuestID, nSelItem);
	else							gamefunc:AcceptQuestRewardItem( nQuestID, 0);
	end


	-- Play sound
	gamefunc:PlaySound( "button_agree");
		
				
	luaRewardQuest.m_bRewardedQuest = true;
	frmRewardQuest:Show( false);
end
