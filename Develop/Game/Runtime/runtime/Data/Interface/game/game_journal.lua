--[[
	Game journal LUA script
--]]


-- Global instance
luaJournal = {};


-- Direct view
luaJournal.DirectViewVar = {};
	luaJournal.DirectViewVar.nType = 0;
	luaJournal.DirectViewVar.nID = 0;





-- OnShowJournalFrame
function luaJournal:OnShowJournalFrame()

	-- Show
	if ( frmJournal:GetShow() == true)  then
		
		luaJournal:RefreshJournal();

		
	-- Hide
	else
	
		luaJournal.DirectViewVar.nType = 0;
		luaJournal.DirectViewVar.nID = 0;
	end
	
	
	luaGame:ShowWindow( frmJournal);
end





-- RefreshJournal
function luaJournal:RefreshJournal()

	luaQuest:RefreshQuest();
	luaRecipe:RefreshRecipe();
end





-- DirectView
function luaJournal:DirectView( nType, nID)

	luaJournal.DirectViewVar.nType = nType;
	luaJournal.DirectViewVar.nID = nID;


	if ( nType == JOURNALOBJ_TYPE.QUEST)  then
	
		tbcJournalTabCtrl:SetSelIndex( 0);
		
		if ( frmJournal:GetShow() == true)  then	luaQuest:RefreshQuest();
		else										frmJournal:Show( true);
		end
		
	elseif ( nType == JOURNALOBJ_TYPE.RECIPE)  then
	
		tbcJournalTabCtrl:SetSelIndex( 1);

		if ( frmJournal:GetShow() == true)  then	luaRecipe:RefreshRecipe();
		else										frmJournal:Show( true);
		end
	end
end





-- OnItemClickJournalDesciption
function luaJournal:OnItemClickJournalDesciption()

	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex < 0)  then  return;
	end
	
	local strRefText = tvwJournalDesc:GetRefText( nItemIndex);
	if ( strRefText == nil)  or  ( strRefText == "")  then  return;
	end
	
	local strType, strData = luaGame:GetReferenceTypeData( strRefText);
	
	-- artisan
	if ( strType == "artisan")  then
	
		local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
		if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
		end

		local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
		if ( nRecipeID <= 0)  then  return;
		end
		
		
		mapFieldMap:AddMarkerArtisan( nRecipeID, tonumber( strData));
		mapMiniMap:AddMarkerArtisan( nRecipeID, tonumber( strData));
	

		-- Show map frame
		tbcMapTabCtrl:SetSelIndex( 0);
		frmMap:Show( true);
		frmMap:BringToTop();
	end
end





-- OnToolTipJournalDesciption
function luaJournal:OnToolTipJournalDesciption()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwJournalDesc:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);


		-- Set tooltip
		if ( strType == "item")  or  ( strType == "selitem") then

			local nID = tonumber( strData);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil, true);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  then
					
					strToolTip = strToolTip .. "{divide}" .. luaToolTip:OnToolTipEquipItem(nID);
				end
			end
		
		
		elseif ( strType == "material")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil, true);
			end
			
			-- Dropper
			strToolTip = strToolTip .. luaToolTip:GetItemDropNPC(nID);		
			
		elseif ( strType == "artisan")  then

			local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
			if ( nCurSelCategory >= 0)  and  ( nCurSelItem >= 0)  then
			
				local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
				if ( nRecipeID > 0)  then
				
					local nFieldID = gamefunc:GetRecipeArtisanFieldID( nRecipeID, tonumber( strData));
					local strFieldName = gamefunc:GetFieldName( nFieldID);
			
					strToolTip = STR( "UI_JOURNAL_LOCATION") .. " : " .. strFieldName;
				end
			end
		end
	end
	
	
	tvwJournalDesc:SetToolTip( strToolTip);
end