--[[
	Game crafting LUA script
--]]


-- Global instance
luaCrafting = {};





-- OnShowCraftingFrame
function luaCrafting:OnShowCraftingFrame()
	
	frmConfirmMakeCraftingItem:Show( false);
	frmCraftingErrorMsgBox:Show( false);
	
	
	-- Show
	if ( frmCrafting:GetShow() == true)  then
	
		frmCrafting:SetText( gamefunc:GetNpcName());
	
		lcCrafting:SetCurSel( -1);

		luaCrafting:RefreshCrafting();
		
	-- Hide
	else

		gamefunc:RequestNpcInteractionEnd();
	end
	
	
	luaGame:ShowWindow( frmCrafting);
end





-- RefreshCrafting
function luaCrafting:RefreshCrafting()

	luaCrafting:RefreshCraftingListCtrl();
	luaCrafting:RefreshCraftingRecipeInfo();
	luaCrafting:RefreshControls();
end





-- RefreshCraftingListCtrl
function luaCrafting:RefreshCraftingListCtrl()

	if ( frmCrafting:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = math.max( 0, lcCrafting:GetCaretPos());

	-- Add items
	lcCrafting:DeleteAllItems();

	for  i = 0, (gamefunc:GetCraftingRecipeCount() - 1)  do

		local nRecipeID = gamefunc:GetCraftingRecipeID( i);
		local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
		local strName = gamefunc:GetItemName( nRecipeItemID);
		local strImage = gamefunc:GetItemImage( nRecipeItemID);
		local nCraftingCost = gamefunc:GetCraftingItemCost( i);
		local strCraftingCost = luaGame:ConvertMoneyToStr( nCraftingCost);
		local nQuantity = gamefunc:GetRecipeItemQuantity( nRecipeItemID);

		if ( nQuantity > 1)  then  strName = strName .. "  x" .. tostring( nQuantity);
		end
		
				
		local nIndex = lcCrafting:AddItem( strName, strImage);
		lcCrafting:SetItemText( nIndex, 1, "$$" .. strCraftingCost);

		local r, g, b = GetItemColor( nRecipeItemID);
		lcCrafting:SetItemColor( nIndex, 0, r, g, b);
		
		if (gamefunc:IsHaveRecipe( nRecipeID) == true) then
			lcCrafting:SetItemText( nIndex, 2, STR( "UI_CRAFTING_RECIPESINPOSSESSION"));
		end
		
		if	(gamefunc:IsEnabledCraftingItem( i) == true) and
			(gamefunc:IsMakableCraftingItem(i) == true) then
			
			lcCrafting:SetItemText( nIndex, 2, STR( "UI_CRAFTING_CRAFTINGAVAILABLE"));		
		end
		
		if ( gamefunc:GetInvenItemQuantityByID(nRecipeItemID) > 0 ) then
			lcCrafting:SetItemText( nIndex, 2, STR( "UI_CRAFTING_ITEMINPOSSESSION"));
		end

		if ( gamefunc:IsEquippedItem(nRecipeItemID) == true ) then
			lcCrafting:SetItemText( nIndex, 2, STR( "UI_CRAFTING_ITEMEQUIPPED"));
		end
		
		lcCrafting:SetItemData( nIndex, i);
		
	end
	
	lcCrafting:SetCaretPos( nCurSel);
end





-- RefreshCraftingRecipeInfo
function luaCrafting:RefreshCraftingRecipeInfo()

	if ( frmCrafting:GetShow() == false)  then  return;
	end


	tvwCraftingRecipeInfo:Clear();


	local nCurSel = lcCrafting:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end

	local nRecipeIndex = lcCrafting:GetItemData( nCurSel);
	if ( nRecipeIndex < 0)  then  return;
	end
	
	local nRecipeID = gamefunc:GetCraftingRecipeID( nRecipeIndex);
	if ( nRecipeID <= 0)  then  return;
	end

	
	local strText = "{CR}" .. luaRecipe:GetRecipeDescription( nRecipeID);
	local _begin, _end = string.find( strText, "{ARTISAN}");
	if ( _begin ~= nil)  and  ( _end ~= nil)  then  strText = string.sub( strText, 1, _begin - 1);
	end
	
	tvwCraftingRecipeInfo:SetText( strText);
end





-- RefreshControls
function luaCrafting:RefreshControls()

	if ( frmCrafting:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = lcCrafting:GetCaretPos();
	if ( nCurSel < 0)  then
	
		btnCraftingGetRecipe:Enable( false);
		btnCraftingMakeItem:Enable( false);
		return;
	end
	

	local nRecipeIndex = lcCrafting:GetItemData( nCurSel);
	if ( nRecipeIndex < 0)  then
	
		btnCraftingGetRecipe:Enable( false);
		btnCraftingMakeItem:Enable( false);
		return;
	end
	
	
	local nRecipeID = gamefunc:GetCraftingRecipeID( nRecipeIndex);
	if ( nRecipeID <= 0)  then										btnCraftingGetRecipe:Enable( false);
	elseif ( gamefunc:IsHaveRecipe( nRecipeID) == true)  then		btnCraftingGetRecipe:Enable( false);
	else															btnCraftingGetRecipe:Enable( true);
	end


	if ( gamefunc:IsEnabledCraftingItem( nRecipeIndex) == true)  then	btnCraftingMakeItem:Enable( gamefunc:IsMakableCraftingItem( nRecipeIndex));
	else																btnCraftingMakeItem:Enable( false);
	end
end





-- OnSelChangeCraftingListCtrl
function luaCrafting:OnSelChangeCraftingListCtrl()

	luaCrafting:RefreshCraftingRecipeInfo();
	luaCrafting:RefreshControls();
end





-- OnClickGetRecipe
function luaCrafting:OnClickGetRecipe()

	local nCurSel = lcCrafting:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end
	
	local nRecipeIndex = lcCrafting:GetItemData( nCurSel);
	if ( nRecipeIndex < 0)  then  return;
	end
	
	local nRecipeID = gamefunc:GetCraftingRecipeID( nRecipeIndex);
	if ( nRecipeID <= 0)  then  return;
	end
	
	if ( gamefunc:IsHaveRecipe( nRecipeID) == true)  then  return;
	end
	
	
	gamefunc:ObtainCraftingRecipe( nRecipeIndex);
	
	
	local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
	local strName = gamefunc:GetItemName( nRecipeItemID);
	luaGame:OnEventChattingMsg( FORMAT( "UI_CRAFTING_RECEIVEDRECIPE", strName), CHATFILTER_TYPE.SYSTEM, 0);
end





-- OnClickMakeItem
function luaCrafting:OnClickMakeItem()

	if (gamefunc:GetInvenItemCount() == gamefunc:GetInvenItemMaxCount()) then
		tvwCraftingErrorMsg:SetText( STR( "UI_CRAFTING_INSUFFICIENTSPACE"));
		frmCraftingErrorMsgBox:DoModal();
		return;
	end
	
	luaCrafting:OpenConfirmMakeCraftingItem();
end





-- OnToolTipCraftingRecipeInfo
function luaCrafting:OnToolTipCraftingRecipeInfo()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	
	
	if ( nItemIndex >= 0)  then

		local strRefText = tvwCraftingRecipeInfo:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);
		
		
		-- Set tooltip
		if ( strType == "item")  then

			local nID = tonumber( strData);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  then
				
					strToolTip = strToolTip .. "{divide}" .. luaToolTip:OnToolTipEquipItem( nID);
				end
			end
		
		elseif ( strType == "material")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil, true);
			end
			
			-- 
			local _begin, _end = string.find( strToolTip, "{CRAFTING}");
			if ( _begin ~= nil)  and  ( _end ~= nil)  then  strToolTip = string.sub( strToolTip, 1, _begin - 1);
			end

			-- Dropper
			strToolTip = strToolTip .. luaToolTip:GetItemDropNPC(nID);

		end
	end
	
	tvwCraftingRecipeInfo:SetToolTip( strToolTip);
end



















-- OpenConfirmMakeCraftingItem
function luaCrafting:OpenConfirmMakeCraftingItem()

	local nCurSel = lcCrafting:GetCaretPos();
	if ( nCurSel < 0)  then  return;
	end
	
	local nRecipeIndex = lcCrafting:GetItemData( nCurSel);
	if ( nRecipeIndex < 0)  then  return;
	end
	
	local nRecipeID = gamefunc:GetCraftingRecipeID( nRecipeIndex);
	if (nRecipeID <= 0)  or  (gamefunc:IsMakableCraftingItem( nRecipeIndex) == false)  then  return;
	end
	
	
	
	-- Info
	local strText = "";
	local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
	local strName = gamefunc:GetItemName( nRecipeItemID);
	local strImage = gamefunc:GetItemImage( nRecipeItemID);
	local strDesc = gamefunc:GetItemDesc( nRecipeItemID);
	local nCost = gamefunc:GetRecipeItemCost( nRecipeID);
	local strCost = luaGame:ConvertMoneyToStr( nCost, "fntSmall");
	local nQuantity = gamefunc:GetRecipeItemQuantity( nRecipeID);

	strText = strText .. "{CR h=2}{INDENT dent=2}{REF text=\"item://" .. nRecipeID .. "\"}{SPACE w=330 h=60}{/REF}{CR h=0}" ..
		"{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}" .. strName .. "{/COLOR}{/FONT}{CR}"..
		"{FONT name=\"fntScript\"}" .. STR( "QUANTITY") .. " : " .. nQuantity .. "\n{CR}{/INDENT}" ..
		STR( "UI_CRAFTING_CONFIRMREQUIREDMATERIAL") .. "\n"..
		"{INDENT}{ALIGN hor=\"left\" ver=\"center\"}{BITMAP name=\"iconCoin\" w=18 h=18} " .. STR( "COST") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\" ver=\"bottom\"}" .. strCost .. "{SPACE w=30 h=18}{CR h=18}" ..
		"{ALIGN hor=\"left\" ver=\"center\"}{BITMAP name=\"bmpDefSeperateBarHor\" w=300 h=2}{CR}";
		
		
	for  i = 0, (gamefunc:GetRecipeMaterialCount( nRecipeID) - 1)  do
	
		local nID = gamefunc:GetRecipeMaterialID( nRecipeID, i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nQuantity = gamefunc:GetRecipeMaterialQuantity( nRecipeID, i);
		
		strText = strText .. "{REF text=\"item://" .. nID .. "\"}{SPACE w=300 h=18}{/REF}{CR h=0}" ..
			"{BITMAP name=\"" .. strImage .. "\" w=18 h=18} " .. strName .. "{CR h=0}" ..
			"{ALIGN hor=\"right\" ver=\"center\"}" .. nQuantity .. "{SPACE w=30 h=18}{CR h=18}" ..
			"{ALIGN hor=\"left\" ver=\"center\"}{BITMAP name=\"bmpDefSeperateBarHor\" w=300 h=2}{CR}";
	end
	
	tvwMakeCraftingItemDesc:SetText( strText);



	-- Reposition frame
	local x, y = frmConfirmMakeCraftingItem:GetParent():GetPosition();
	local w, h = frmConfirmMakeCraftingItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmMakeCraftingItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmMakeCraftingItem:DoModal();
end





-- OnToolTipCraftingItemInfo
function luaCrafting:OnToolTipCraftingItemInfo()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwMakeCraftingItemDesc:GetRefText( nItemIndex);
		local strType, strData = luaGame:GetReferenceTypeData( strRefText);
		
		-- Set tooltip
		if ( strType == "item")  then
		
			local nID = tonumber( strData);
			if ( nID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
			end
		end
	end
	
	tvwMakeCraftingItemDesc:SetToolTip( strToolTip);
end





-- OnMakeCraftingItemOK
function luaCrafting:OnMakeCraftingItemOK()

	local nCurSel = lcCrafting:GetCaretPos();
	if ( nCurSel >= 0)  then
		
		local nRecipeIndex = lcCrafting:GetItemData( nCurSel);
		if ( nRecipeIndex >= 0)  then
		
			local nRecipeID = gamefunc:GetCraftingRecipeID( nRecipeIndex);
			local nRecipeItemID = gamefunc:GetRecipeItemID( nRecipeID);
			
			-- Play sound
			local strSound = gamefunc:GetItemMakingSound( nID);
			gamefunc:PlaySound( strSound);
		
		
			-- Make item
			gamefunc:MakeCraftingItem( nRecipeIndex);
		end
	end


	frmConfirmMakeCraftingItem:Show( false);

	luaCrafting:RefreshCrafting();
end
