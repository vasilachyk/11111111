--[[
	Game looting LUA script
--]]


-- Global instance
luaLooting = {};





-- OnShowLootingFrame
function luaLooting:OnShowLootingFrame()

	-- Show
	if ( frmLooting:GetShow() == true)  then

		luaLooting:RefreshLooting();
		
		
	-- Hide
	else
		
		gamefunc:RequestLootingEnd();	
	end
	
	
	luaGame:ShowWindow( frmLooting);
end





-- RefreshLooting
function luaLooting:RefreshLooting()

	luaLooting:RefreshLootingList();
	luaLooting:RefreshControls();
end





-- RefreshLootingList
function luaLooting:RefreshLootingList()

	if ( frmLooting:GetShow() == false)  then  return;
	end
	
	local nCount = gamefunc:GetLootingItemCount();
	if (nCount == 0)	then
		--frmLooting:Show(false);
		return;
	end

	local nCurSel = math.max( 0, lcLooting:GetCurSel());

	lcLooting:DeleteAllItems();
	for  i = 0, (nCount - 1)  do

		local nID = gamefunc:GetLootingItemID( i);
		local nType = gamefunc:GetLootingItemType(i);
		local nQuantity = gamefunc:GetLootingItemQuantity( i);

		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
		end

		local nIndex = lcLooting:AddItem( strName, strImage);
		local r, g, b = GetItemColor(nID);
		lcLooting:SetItemColor(nIndex, 0, r, g, b);

		lcLooting:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);
		lcLooting:SetItemData( nIndex, i);
		lcLooting:SetItemColor(nIndex, 1, 128, 128, 128);
		
		local strTier = GetItemTierString( nID);
		lcLooting:SetItemText( nIndex, 2, strTier);
		lcLooting:SetItemColor(nIndex, 2, r, g, b);

		if ( nType == LOOTINGITEM_TYPE.MASTERLOOTER)  then		lcLooting:SetItemText( nIndex, 3, STR( "UI_LOOTING_PARTYLEADERDISTRIBUTE"));
		elseif ( nType == LOOTINGITEM_TYPE.ROLLDICE)  then		lcLooting:SetItemText( nIndex, 3, STR( "UI_LOOTING_RANDOMACQUISITION"));
		end
	end

	lcLooting:SetCurSel( nCurSel);
end





-- RefreshControls
function luaLooting:RefreshControls()

	if ( frmLooting:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = lcLooting:GetCurSel();
	if ( nCurSel < 0)  then
	
		btnGetLootingItem:Enable( false);
		return;
	end
	
	local nIndex = lcLooting:GetItemData( nCurSel);
	if ( nIndex < 0)  then

		btnGetLootingItem:Enable( false);
		return;
	end

	btnGetLootingItem:Enable( true);
end






-- OnItemDblClickLootingListCtrl
function luaLooting:OnItemDblClickLootingListCtrl()

	local nCurSel = lcLooting:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end

	local nIndex = lcLooting:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	gamefunc:LootItem( nIndex);
end





-- OnToolTipLootingListCtrl
function luaLooting:OnToolTipLootingListCtrl()

	local strToolTip = "";

	local nCurSel = lcLooting:GetMouseOver();
	if ( nCurSel >= 0)  then

		local nIndex = lcLooting:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetLootingItemID( nIndex);
			strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
		end
	end
	
	lcLooting:SetToolTip( strToolTip);
end





-- OnClickGetItem
function luaLooting:OnClickGetItem()

	local nCurSel = lcLooting:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcLooting:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	gamefunc:LootItem( nIndex);
end





-- OnClickGetAllItems
function luaLooting:OnClickGetAllItems()

	gamefunc:LootAllItems();
end
