--[[
	Game recipe LUA script
--]]


-- Global instance
luaRecipe = {};


-- Material Collected Recipe Index
luaRecipe.m_nMaterialCollectedRecipeID = -1;





-- RefreshRecipe
function luaRecipe:RefreshRecipe()

	luaRecipe:RefreshRecipeList();
	luaRecipe:RefreshRecipeDescription();
	luaRecipe:RefreshControls();
end





-- RefreshRecipeList
function luaRecipe:RefreshRecipeList()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 1)  then  return;
	end


	-- Add recipe item
	local arrayCategory = {};
		arrayCategory.nType = {};
		arrayCategory.nIndex = {};
	local nCategoryCount = 0;
	
	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	ctvRecipeList:DeleteAllItems();

	local nOwnedMoney = gamefunc:GetMoney();

	for  i = 0, (gamefunc:GetRecipeCount() - 1)  do
	
		local nRecipeID = gamefunc:GetRecipeID( i);
		local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
		local strName = gamefunc:GetItemName( nRecipeItemID);
		local nType = gamefunc:GetItemType( nRecipeItemID);
		
		
		-- Find category
		local nCategoryIndex = -1;
		for j = 0, (nCategoryCount - 1)  do
		
			if ( arrayCategory.nType[ j] == nType)  then
			
				-- Exist category
				nCategoryIndex = arrayCategory.nIndex[ j];
				break;
			end
		end
		
		
		-- Add category
		if ( nCategoryIndex < 0)  then
		
			local strCategory = "";
			if ( nType == ITEM_TYPE.WEAPON)  then		strCategory = STR( "UI_JOURNAL_WEAPONRECIPE");
			elseif ( nType == ITEM_TYPE.ARMOR)  then	strCategory = STR( "UI_JOURNAL_ARMORRECIPE");
			else										strCategory = STR( "UI_JOURNAL_ITEMRECIPE");
			end

			nCategoryIndex = ctvRecipeList:AddCategory( strCategory);
			ctvRecipeList:SetCategoryExpand( nCategoryIndex, true);
			
			arrayCategory.nType[ nCategoryCount] = nType;
			arrayCategory.nIndex[ nCategoryCount] = nCategoryIndex;
			nCategoryCount = nCategoryCount + 1;
		end


		-- Check makeable
		local bMakable = true;
		
		if ( gamefunc:GetRecipeItemCost( nRecipeID) > nOwnedMoney)  then  bMakable = false;
		end


		if ( bMakable == true)  then		

			for  i = 0, (gamefunc:GetRecipeMaterialCount( nRecipeID) - 1)  do
		
				local nMatID = gamefunc:GetRecipeMaterialID( nRecipeID, i);
				local nMatQuantity = gamefunc:GetRecipeMaterialQuantity( nRecipeID, i);
				local nOwnedMatQuantity = gamefunc:GetInvenItemQuantityByID( nMatID) + gamefunc:GetEquipItemQuantityByID(nMatID);
				
				if ( nOwnedMatQuantity < nMatQuantity)  then		
					bMakable = false;
					break;
				end
			end
		end
		

		-- Get icon
		local strIcon;
		
		if ( bMakable == true)  then			strIcon = "iconScroll";
		else									strIcon = "iconScrollGray";
		end
		
		if ( gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.RECIPE, nRecipeID) == true)  then  strIcon = strIcon .. "Ind"
		end


		-- Add Recipe
		local nIndex = ctvRecipeList:AddItem( nCategoryIndex, strName, strIcon);
		ctvRecipeList:SetItemData( nCategoryIndex, nIndex, nRecipeID);
		
		-- 제작가능여부
		luaRecipe:RefreshRecipeMakable(nCategoryIndex, nIndex, nRecipeID)	
		
		-- Check direct view
		if ( luaJournal.DirectViewVar.nType == JOURNALOBJ_TYPE.RECIPE)  and  ( luaJournal.DirectViewVar.nID == nRecipeID)  then
		
			nCurSelCategory = nCategoryIndex;
			nCurSelItem = nIndex;
		end
	end
	

	ctvRecipeList:SetCurSel( nCurSelCategory, nCurSelItem);
	
	
	luaJournal.DirectViewVar.nType = 0;
	luaJournal.DirectViewVar.nID = 0;
end





function luaRecipe:RefreshRecipeMakable(nCategoryIndex, nIndex, nRecipeID)

	local nCost = gamefunc:GetRecipeItemCost( nRecipeID);
	local nOwnedMoney = gamefunc:GetMoney();
	local bMakable = true;
	if ( nOwnedMoney < nCost)  then	bMakable = false;
	end

	local nCount = gamefunc:GetRecipeMaterialCount( nRecipeID);
	for  i = 0, (nCount - 1)  do
	
		local nID = gamefunc:GetRecipeMaterialID( nRecipeID, i);
		local nQuantity = gamefunc:GetRecipeMaterialQuantity( nRecipeID, i);
		local nOwnedQuantity = gamefunc:GetInvenItemQuantityByID( nID) + gamefunc:GetEquipItemQuantityByID(nID);
		
		if ( nOwnedQuantity < nQuantity)  then bMakable = false;
		end			
	end
	
	if ( bMakable == true ) then
		ctvRecipeList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_CRAFTINGAVAILABLE"));		
	end
	
	local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
	if ( gamefunc:GetInvenItemQuantityByID(nRecipeItemID) > 0 ) then
		ctvRecipeList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_INPOSSESSION"));
	end

	if ( gamefunc:IsEquippedItem(nRecipeItemID) == true ) then
		ctvRecipeList:SetItemText( nCategoryIndex, nIndex, 1, STR( "UI_JOURNAL_EQUIPPED"));
	end
end





-- RefreshRecipeDescription
function luaRecipe:RefreshRecipeDescription()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 1)  then  return;
	end


	tvwJournalDesc:Clear();


	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nRecipeID <= 0)  then  return;
	end
	
	
	local strText = "{CR}" .. luaRecipe:GetRecipeDescription( nRecipeID);
	tvwJournalDesc:SetText( luaGame:ConvertStrToDialogSentence( strText));
end





-- GetRecipeDescription
function luaRecipe:GetRecipeDescription( nRecipeID)

	local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
	if ( nRecipeItemID <= 0)  then  return "";
	end
	
	
	-- Message
	local strName = gamefunc:GetItemName( nRecipeItemID);
	local strText = "{CR}{FONT name=\"fntHeadline\"}{COLOR r=250 g=230 b=210}" .. strName .. "{/COLOR}{/FONT}\n" ..
		"{INDENT}" .. STR( "UI_JOURNAL_CRAFTINGITEM") .. "{CR}{/INDENT}";
	

	-- Add item
	local strImage = gamefunc:GetItemImage( nRecipeItemID);
	local nQuantity = gamefunc:GetRecipeItemQuantity( nRecipeID);
	strText = strText .. "{INDENT}{REF text=\"item://" .. nRecipeItemID .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
			"{INDENT dent=2}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=3}" ..
			"{INDENT dent=50}" .. strName .."{CR h=18}" ..
			"{FONT name=\"fntScriptWeak\"}" .. STR( "QUANTITY") .. " : " .. tostring( nQuantity) .. "{/FONT}{CR h=23}{/INDENT}{CR}";

	-- Condition
	local strCondition = gamefunc:GetRecipeConditionText(nRecipeItemID)
	if ( strCondition ~= "")  then  strText = strText .. "{INDENT}" .. STR( "REQUIREMENTS") .. "{CR}{INDENT}{FONT name=\"fntScriptWeak\"}" .. strCondition .. "{/FONT}{/INDENT}{CR}"
	end

	-- Message
	strText = strText .. "{INDENT}" .. STR( "MATERIAL") .. "{CR}{/INDENT}"


	-- Add cost
	local nCost = gamefunc:GetRecipeItemCost( nRecipeID);
	local nOwnedMoney = gamefunc:GetMoney();
	local strCost = luaGame:ConvertMoneyToStr( nCost);
	local bMakable = true;
	strText = strText .. "{INDENT}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{CR h=2}" ..
			"{INDENT dent=2}{BITMAP name=\"iconMoney\" w=40 h=40}{CR h=3}" ..
			"{INDENT dent=50}" .. STR( "COST") .. "{CR h=18}";
			
	if ( nOwnedMoney < nCost)  then
		strText = strText .. "{COLOR r=180 g=32 b=0}{FONT name=\"fntScriptWeak\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. strCost .. "{/FONT}{/COLOR}{CR h=23}{/INDENT}";
		bMakable = false;
	else
		strText = strText .. "{FONT name=\"fntScriptWeak\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. strCost .. "{/FONT}{CR h=23}{/INDENT}";
	end


	-- Add materials
	local nCount = gamefunc:GetRecipeMaterialCount( nRecipeID);
	for  i = 0, (nCount - 1)  do
	
		local nID = gamefunc:GetRecipeMaterialID( nRecipeID, i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nQuantity = gamefunc:GetRecipeMaterialQuantity( nRecipeID, i);
		local nOwnedQuantity = gamefunc:GetInvenItemQuantityByID( nID) + gamefunc:GetEquipItemQuantityByID(nID);
		
		strText = strText .. "{INDENT}{REF text=\"material://" .. nID .. "\"}{BITMAP name=\"bmpScrollItemSlot\" w=300 h=44}{/REF}{CR h=2}" ..
			"{INDENT dent=2}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=3}" ..
			"{INDENT dent=50}" .. strName .. "{CR h=18}";
					
		if ( nOwnedQuantity < nQuantity)  then					
			strText = strText .. "{COLOR r=180 g=32 b=0}{FONT name=\"fntScriptWeak\"}" .. STR( "QUANTITY") .. " : " .. nQuantity .. " (" .. FORMAT( "UI_JOURNAL_OWNED", nOwnedQuantity) .. "){/FONT}{/COLOR}{CR h=23}{/INDENT}";
			bMakable = false;
		else
			strText = strText .. "{FONT name=\"fntScriptWeak\"}" .. STR( "QUANTITY") .. " : " .. nQuantity .. " (" .. FORMAT( "UI_JOURNAL_OWNED", nOwnedQuantity) .. "){/FONT}{CR h=23}{/INDENT}";
		end			
	end	
	
	
	-- Add makable description
	strText = strText .. "{CR}{/INDENT}{INDENT}{ARTISAN}";
	if ( bMakable == true)  then	strText = strText .. STR( "UI_JOURNAL_REQUESTCRAFTING");
	else							strText = strText .. STR( "UI_JOURNAL_REQUESTCRAFTING2");
	end
	
	
	-- Add artisan
	local nFieldID = gamefunc:GetCurrentFieldID();
	local strArtisan = "";

	for i = 0, ( gamefunc:GetRecipeArtisanCount( nRecipeID) - 1)  do
	
		local strArtisanName = gamefunc:GetRecipeArtisanName( nRecipeID, i);
		local nArtisanFieldID = gamefunc:GetRecipeArtisanFieldID( nRecipeID, i)
		
		if ( strArtisan ~= "")  then  strArtisan = strArtisan .. ", ";
		end
		
		if ( nFieldID == nArtisanFieldID)  then
		
			strArtisan = strArtisan .. "{REF text=\"artisan://" .. i .. "\"}" .. strArtisanName .. "{/REF}";
		else

			strArtisan = strArtisan .. "{COLOR r=128 g=128 b=128}{REF text=\"artisan://" .. i .. "\"}" .. strArtisanName .. "{/REF}{/COLOR}";
		end
	end

	if ( strArtisan ~= "")  then  strText = strText .. "\n{INDENT}" .. strArtisan .. "{CR}";
	end


	return strText;	
end





-- RefreshControls
function luaRecipe:RefreshControls()

	if (frmJournal:GetShow() == false)  or  (tbcJournalTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelItem < 0)  or  ( nCurSelItem < 0)  then
		btnIndicateRecipe:SetText( STR( "UI_JOURNAL_INDICATERECIPE"));
		btnIndicateRecipe:Enable( false);
		btnRemoveRecipe:Enable( false);
		return;
	end
	
	local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nRecipeID <= 0)  then
		btnIndicateRecipe:SetText( STR( "UI_JOURNAL_INDICATERECIPE"));
		btnIndicateRecipe:Enable( false);
		btnRemoveRecipe:Enable( false);
		return;
	end


	local bIndicated = gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
	if ( bIndicated == true)  then		btnIndicateRecipe:SetText( STR( "UI_JOURNAL_NOTINDICATERECIPE"));
	else								btnIndicateRecipe:SetText( STR( "UI_JOURNAL_INDICATERECIPE"));
	end

	btnIndicateRecipe:Enable( true);
	btnRemoveRecipe:Enable( true);
end





-- OnSelChangeRecipeList
function luaRecipe:OnSelChangeRecipeList()

	luaRecipe:RefreshRecipeDescription();
	luaRecipe:RefreshControls();
end





-- OnItemClickRecipeList
function luaRecipe:OnItemClickRecipeList()

	if ( EventArgs.shift == true)  then  luaRecipe:IndicateCurSelRecipe();
	end
end





-- IndicateCurSelRecipe
function luaRecipe:IndicateCurSelRecipe()

	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nRecipeID <= 0)  then  return;
	end
		

	local bIndicated = gamefunc:IsJournalIndicated( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
	if ( bIndicated == false)  then
	
		jiJournalIndicator:AddItem( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
		gamefunc:AddJournal( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
	
	else

		jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
		gamefunc:RemoveJournal( JOURNALOBJ_TYPE.RECIPE, nRecipeID);
	end
	
	
	luaRecipe:RefreshRecipeList();
	luaRecipe:RefreshControls();
end
















-- OpenConfirmRemoveRecipe
function luaRecipe:OpenConfirmRemoveRecipe()

	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelCategory < 0)  or  ( nCurSelItem < 0)  then  return;
	end
	
	local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
	if ( nRecipeID <= 0)  then  return;
	end

	local nID = gamefunc:GetRecipeItemID( nRecipeID);
	picRemoveRecipe:SetImage( gamefunc:GetItemImage( nID));
	labRemoveRecipeName:SetText( gamefunc:GetItemName( nID));
	

	-- Reposition frame
	local x, y = frmConfirmRemoveRecipe:GetParent():GetPosition();
	local w, h = frmConfirmRemoveRecipe:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmRemoveRecipe:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
    
    btnRemoveRecipe:Enable( false);
	frmConfirmRemoveRecipe:DoModal();
end





-- CloseConfirmRemoveRecipe
function luaRecipe:CloseConfirmRemoveRecipe()

	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelCategory >= 0)  and  ( nCurSelItem >= 0)  then  btnRemoveRecipe:Enable( true);
	end
	
	frmConfirmRemoveRecipe:Show( false);
end





-- OnRemoveRecipeOK
function luaRecipe:OnRemoveRecipeOK()

	local nCurSelCategory, nCurSelItem = ctvRecipeList:GetCurSel();
	if ( nCurSelCategory >= 0)  and  ( nCurSelItem >= 0)  then
	
		local nRecipeID = ctvRecipeList:GetItemData( nCurSelCategory, nCurSelItem);
		if ( nRecipeID > 0)  then
		
			jiJournalIndicator:RemoveItem( JOURNALOBJ_TYPE.RECIPE, nRecipeID);			
			gamefunc:RemoveRecipe( nRecipeID);
		end
	end
	
	luaRecipe:CloseConfirmRemoveRecipe();
end





-- OnRemoveRecipeCancel
function luaRecipe:OnRemoveRecipeCancel()

	luaRecipe:CloseConfirmRemoveRecipe();
end
