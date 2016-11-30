--[[
	Game shop LUA script
--]]


-- Global instance
luaShop = {};


-- Variables to repair items
luaShop.m_vRepairableItems = {};
luaShop.m_nRepairPrice = 0;


-- Slot types to check repairable equipped items
luaShop.m_RepairableEquippedSlot =
{
	ITEM_SLOT.BODY,
	ITEM_SLOT.HEAD,
	ITEM_SLOT.LEG,
	ITEM_SLOT.HANDS,
	ITEM_SLOT.FEET,
	ITEM_SLOT.FACE,
	ITEM_SLOT.RWEAPON,
	ITEM_SLOT.LWEAPON,
	ITEM_SLOT.RWEAPON2,
	ITEM_SLOT.LWEAPON2
};


-- Type of repairable item
luaShop.REPAIR_TYPE = { EQUIPPED = 1,  INVENTORY = 2 };





-- OnShowShopFrame
function luaShop:OnShowShopFrame()

	frmConfirmBuyItemQuantity:Show( false);
	frmConfirmSellCommonItems:Show( false);
	frmConfirmRepairItems:Show( false);
	
	
	-- Show
	if ( frmShop:GetShow() == true)  then
	
		frmInventory:Show( true);
	
		luaShop:RefreshShop();
		lcShop:SetCurSel( 0);
		
		
	-- Hide
   	else
	
		frmInventory:Show( false);
		
		gamefunc:RequestNpcInteractionEnd();
	end
	
	
	luaGame:ShowWindow( frmShop);
end





-- RefreshShop
function luaShop:RefreshShop()

	if ( frmShop:GetShow() == false)  then  return;
	end


	luaShop:RefreshShopList();
	luaShop:RefreshControls();
	luaShop:RefreshRepairItems();
end





-- RefreshShopList
function luaShop:RefreshShopList()

	if ( frmShop:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = math.max( 0, lcShop:GetCurSel());

	lcShop:DeleteAllItems();


	-- Repair icon
	if ( gamefunc:IsRepairableShop() == true)  then
	
		lcShop:AddItem( STR( "UI_REPAIRING"), "iconRepair");
		lcShop:SetItemData( 0, 0);
	end
	


	-- Item list
	local nMoney = gamefunc:GetMoney();
	local nPlayerLevel = gamefunc:GetLevel();

	for  i = 0, (gamefunc:GetShopItemCount() - 1)  do

		local nID = gamefunc:GetShopItemID( i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nCost = gamefunc:GetItemBuyingCost( nID);
		local nLevel = gamefunc:GetItemEquipReqLevel( nID);
		local bBuyable = gamefunc:IsBuyableShopItem( nID);
		local bUsable = gamefunc:IsUsableShopItem( nID);

		local strLevel = "";
		if ( nLevel > 1)  then  strLevel = FORMAT( "REQUIREDLEVEL", nLevel);
		end

		if ( bUsable == false )	then strLevel = STR( "UI_SHOP_NOTAVAILABLE");
		end
		

		local nIndex = lcShop:AddItem( strName, strImage);
		lcShop:SetItemText( nIndex, 1, "$$" .. luaGame:ConvertMoneyToStr( nCost));
		lcShop:SetItemText( nIndex, 2, strLevel);
		lcShop:SetItemColor( nIndex, 2, 100, 160, 160);
		lcShop:SetItemData( nIndex, nID);
		
		lcShop:SetItemEnable( nIndex, bBuyable);
				
		if ( nMoney < nCost) then  lcShop:SetItemEnable( nIndex, false);
		end
		
		if ( nPlayerLevel < nLevel) or ( bUsable == false ) then  lcShop:SetItemColor( nIndex, 2, 128, 32, 8);
		end

	end


	lcShop:SetCurSel( nCurSel);
end





-- RefreshControls
function luaShop:RefreshControls()

	if ( frmShop:GetShow() == false)  then  return;
	end
	

	btnBuyItem:Enable( false);
	btnSellCommonItems:Enable( false);
	btnRepairItems:Enable( false);


	-- Check buy item
	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel > 0)  or  ( nCurSel == 0  and  gamefunc:IsRepairableShop() == false)  then
	
		local nID = lcShop:GetItemData( nCurSel);
		if ( nID > 0)  then
		
			local nCost = gamefunc:GetItemBuyingCost( nID);
			if ( nCost <= gamefunc:GetMoney())  then  btnBuyItem:Enable( true);
			end
		end
	end
	
	
	-- Check sell common items
	local bExistCommonItem = false;
	for  i = 0, ( gamefunc:GetInvenItemMaxCount() - 1)  do
		
		local nID = gamefunc:GetInvenItemID( i);
		if ( gamefunc:IsItemSellable( nID) == true)  and  ( gamefunc:GetItemTier( nID) == ITEM_TIER.VERYCOMMON)  then
		
			bExistCommonItem = true;
			break;
		end
	end
	
	if ( bExistCommonItem == true)  then  btnSellCommonItems:Enable( true);
	end			
	
	
	-- Check repairable items
	if ( gamefunc:IsRepairableShop() == true)  then
	
		local nRepairableItemCount = 0;
		
		for  i, nSlot  in pairs( luaShop.m_RepairableEquippedSlot)  do
		
			local nID = gamefunc:GetEquippedItemID( nSlot);
			if ( nID > 0)  then

				if ( gamefunc:GetEquippedItemDurability( nSlot) < gamefunc:GetItemMaxDurability( nID))  then
				
					nRepairableItemCount = nRepairableItemCount + 1;
				end
			end
		end
	
		for  i = 0, ( gamefunc:GetInvenItemMaxCount() - 1)  do
		
			local nID = gamefunc:GetInvenItemID( i);
			if ( nID > 0)  then
			
				local nType = gamefunc:GetItemType( nID);
				if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then

					if ( gamefunc:GetInvenItemDurability( i) < gamefunc:GetItemMaxDurability( nID))  then

						nRepairableItemCount = nRepairableItemCount + 1;
					end
				end
			end
		end
		

		if ( nRepairableItemCount > 0)  then
		
			btnRepairItems:Enable( true);
			
			lcShop:SetItemEnable( 0, true);
			
		else
		
			lcShop:SetItemEnable( 0, false);
		end
	end
end





-- OnItemDblClickShopListCtrl
function luaShop:OnItemDblClickShopListCtrl()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	

	if ( gamefunc:IsRepairableShop() == true)  and  ( nCurSel == 0)  then		luaShop:OpenConfirmRepairItems();
	else																		luaShop:OpenConfirmBuyItemQuantity();
	end
end





-- OnDragBeginShopListCtrl
function luaShop:OnDragBeginShopListCtrl()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcShop:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	
	
	-- Play sound
	local strSound = gamefunc:GetItemPutUpSound( nID);
	gamefunc:PlaySound( strSound);
	
	
	return true;
end





-- OnDropShopListCtrl
function luaShop:OnDropShopListCtrl()

   local _sender = _G[ DragEventArgs:GetSender():GetName()];
    
    -- Self drop : Merge items or exchange items
    if ( _sender == lcInventory)  then
    
    	local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex < 0)  then  return false;
		end

		local nID = gamefunc:GetInvenItemID( nIndex);
		if ( nID <= 0)  then  return false;
		end
	
		if ( gamefunc:IsItemSellable( nID) == false)  then  return false;
		end
	

		luaInventory:OpenConfirmItemQuantityFrame( luaShop.CallbackOnDropSellItem, STR( "UI_CONFIRM"), STR( "UI_SHOP_CONFIRMSELLITEM"), true);
		
		return true;
	end
	
	
	return false;
end





-- CallbackOnDropSellItem
function luaShop:CallbackOnDropSellItem( nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	
	gamefunc:SellInvenItem( nIndex, nQuantity);
end





-- OnToolTipShopListCtrl
function luaShop:OnToolTipShopListCtrl()

	local strToolTip = "";
	

	local nCurSel = lcShop:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		-- Repair
		if (gamefunc:IsRepairableShop() == true)  and  (nCurSel == 0)  then
			
			
		-- Item
		else

			local nID = lcShop:GetItemData( nCurSel);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then
		
					strToolTip = "{COLOR r=100 g=160 b=100}< " .. STR( "UI_SELECTEDITEM") .. " >{/COLOR}\n" .. strToolTip .. "{divide}" ..
						"{COLOR r=100 g=160 b=100}< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nID);
				end
			end
		end
	end


	lcShop:SetToolTip( strToolTip);
end
























-- OpenConfirmBuyItemQuantity
function luaShop:OpenConfirmBuyItemQuantity()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcShop:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	
	local nCost = gamefunc:GetItemBuyingCost( nID);
	if ( nCost > gamefunc:GetMoney())  then  return;
	end

	
	-- Set message and tooltip
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) .. "{/COLOR}{/FONT}{CR h=23}" ..
		"{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nCost, "fntSmall");
	tvwConfirmBuyItemQuantityDesc:SetText( strString);

	local strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
	tvwConfirmBuyItemQuantityDesc:SetToolTip( strToolTip);
	
	
	-- Initialize quantity edit
	edtConfirmBuyItemQuantity:SetText( 1);
	

	-- Set price
	luaShop:RefreshConfirmBuyItemQuantity();


	-- Show frame
	local x, y = frmConfirmBuyItemQuantity:GetParent():GetPosition();
	local w, h = frmConfirmBuyItemQuantity:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmBuyItemQuantity:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmBuyItemQuantity:DoModal();
	
	
	-- Set focus
	edtConfirmBuyItemQuantity:SetFocus();
	edtConfirmBuyItemQuantity:SetSel( 0, edtConfirmBuyItemQuantity:GetLength());
	
	
	btnBuyItem:Enable( false);
end





-- CloseConfirmBuyItemQuantity
function luaShop:CloseConfirmBuyItemQuantity()

	frmConfirmBuyItemQuantity:Show( false);
	
	luaShop:RefreshControls();
end





-- OnValueChangedConfirmBuyItemQuantity
function luaShop:OnValueChangedConfirmBuyItemQuantity()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcShop:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	
	local nMaxQuantity = math.max( 1, gamefunc:GetItemStackSize( nID));
	
	local strText = edtConfirmBuyItemQuantity:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmBuyItemQuantity:SetText( "1");
		edtConfirmBuyItemQuantity:SetSel( 0, edtConfirmBuyItemQuantity:GetLength());

	else
	
		local nQuantity = tonumber( strText);
		if ( nQuantity < 1)  then
			
			edtConfirmBuyItemQuantity:SetText( "1");
			edtConfirmBuyItemQuantity:SetSel( 0, edtConfirmBuyItemQuantity:GetLength());

		elseif ( nQuantity > nMaxQuantity)  then

			edtConfirmBuyItemQuantity:SetText( tostring( nMaxQuantity));
			edtConfirmBuyItemQuantity:SetSel( 0, edtConfirmBuyItemQuantity:GetLength());
		end
	end


	luaShop:RefreshConfirmBuyItemQuantity();
end





-- Refresh
function luaShop:RefreshConfirmBuyItemQuantity()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcShop:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	
	
	-- Set price
	local nPrice = gamefunc:GetItemBuyingCost( nID) * tonumber( edtConfirmBuyItemQuantity:GetText());
	local strString = "{COLUMN h=23}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nPrice, "fntSmall");
	tvwConfirmBuyItemPriceDesc:SetText( strString);
	
	
	-- Refresh controls
	if ( nPrice > gamefunc:GetMoney())  then	btnConfirmBuyItemQuantityOK:Enable( false);
	else										btnConfirmBuyItemQuantityOK:Enable( true);
	end
end





-- DoConfirmBuyItemQuantity
function luaShop:DoConfirmBuyItemQuantity()

	local nCurSel = lcShop:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nID = lcShop:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	
	local nQuantity = tonumber( edtConfirmBuyItemQuantity:GetText());
	if ( nQuantity < 1)  then  return;
	end
	
	local nPrice = gamefunc:GetItemBuyingCost( nID) * nQuantity;
	if ( nPrice > gamefunc:GetMoney())  then  return;
	end


	-- Buy item
	gamefunc:BuyItem( nID, nQuantity);


	luaShop:CloseConfirmBuyItemQuantity();
end


















-- OpenConfirmSellCommonItems
function luaShop:OpenConfirmSellCommonItems()

	lcSellCommonItems:DeleteAllItems();

	local nTotalSellPrice = 0;
	for  i = 0, ( gamefunc:GetInvenItemMaxCount() - 1)  do
		
		local nID = gamefunc:GetInvenItemID( i);

		if ( gamefunc:IsItemSellable( nID) == true)  and  ( gamefunc:GetItemTier( nID) == ITEM_TIER.VERYCOMMON)  then

			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			local nQuantity = gamefunc:GetInvenItemQuantity( i);
			local nCost = gamefunc:GetInvenItemSellCost( i);
			
			nTotalSellPrice = nTotalSellPrice + ( nCost * nQuantity);


			local nIndex = lcSellCommonItems:AddItem( strName, strImage);
			lcSellCommonItems:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);
			lcSellCommonItems:SetItemText( nIndex, 2, "$$" .. luaGame:ConvertMoneyToStr( nCost * nQuantity));
			lcSellCommonItems:SetItemData( nIndex, nID);
		end
	end
	
	
	-- Update sell info
	local strString = "{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}" .. STR( "UI_SHOP_TOTALPRICE") .. " : " ..
		"{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nTotalSellPrice, "fntSmall");
	tvwSellCommonItemsInfo:SetText( strString);
	
	
	-- Show frame
	local x, y = frmConfirmSellCommonItems:GetParent():GetPosition();
	local w, h = frmConfirmSellCommonItems:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmSellCommonItems:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmSellCommonItems:DoModal();
end





-- OnToolTipCommonItemsList
function luaShop:OnToolTipCommonItemsList()

	local strToolTip = "";
	
	local nCurSel = lcSellCommonItems:GetMouseOver();
	if ( nCurSel >= 0)  then

		local nID = lcSellCommonItems:GetItemData( nCurSel);
		if ( nID > 0)  then
		
			strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
		end
	end
	
	lcSellCommonItems:SetToolTip( strToolTip);
end





-- OnClickSellCommonItemsOK
function luaShop:OnClickSellCommonItemsOK()

	gamefunc:SellInvenVeryCommonItem();

	frmConfirmSellCommonItems:Show( false);
	
	
	-- Play sound
	local strSound = gamefunc:GetMoneyPutDownSound();
	gamefunc:PlaySound( strSound);
end


















-- OpenConfirmRepairItems
function luaShop:OpenConfirmRepairItems()

	if ( gamefunc:IsRepairableShop() == false)  then  return;
	end
	
	
	-- Show frame
	local x, y = frmConfirmRepairItems:GetParent():GetPosition();
	local w, h = frmConfirmRepairItems:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmRepairItems:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmRepairItems:DoModal();


	-- Refresh repair items
	luaShop:RefreshRepairItems();
end





-- RefreshRepairItems
function luaShop:RefreshRepairItems()

	if ( frmConfirmRepairItems:GetShow() == false)  then  return;
	end

	luaShop:RefreshRepairItemsList();
	luaShop:RefreshRepairItemsControls();
	
	
	-- Hide frame if repairable item count is 0
	if ( lcRepairItems:GetItemCount() == 0)  then  frmConfirmRepairItems:Show( false);
	end
end





-- RefreshRepairItemsList
function luaShop:RefreshRepairItemsList()

	local nCurSel = math.max( 0, lcRepairItems:GetCurSel());

	lcRepairItems:DeleteAllItems();


	-- Equipped items
	local nCount = 0;
	luaShop.m_nRepairPrice = 0;
	
	for  i, nSlot  in pairs( luaShop.m_RepairableEquippedSlot)  do
	
		local nID = gamefunc:GetEquippedItemID( nSlot);
		if ( nID > 0)  then
		
			local nDurability = gamefunc:GetEquippedItemDurability( nSlot);
			local nMaxDurability = gamefunc:GetItemMaxDurability( nID);
			
			if ( nDurability < nMaxDurability)  then
			
				local strName = gamefunc:GetItemName( nID);
				local strImage = gamefunc:GetItemImage( nID);
				local nCost = gamefunc:GetEquippedItemRepairCost( nSlot);

				nCount = nCount + 1;
				luaShop.m_nRepairPrice = luaShop.m_nRepairPrice + nCost;

				
				local nIndex = lcRepairItems:AddItem( strName, strImage);
				lcRepairItems:SetItemText( nIndex, 1, "$$" .. luaGame:ConvertMoneyToStr( nCost));
				lcRepairItems:SetItemText( nIndex, 2, STR( "DURABILITY") .. " : " .. nDurability .. " / " .. nMaxDurability);
				lcRepairItems:SetItemData( nIndex, nCount);
				
			
				luaShop.m_vRepairableItems[ nCount] = {};
				luaShop.m_vRepairableItems[ nCount].type = luaShop.REPAIR_TYPE.EQUIPPED;
				luaShop.m_vRepairableItems[ nCount].slot = nSlot;
			end
		end
	end
	
	
	-- Inventory items
	for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do
	
		local nID = gamefunc:GetInvenItemID( i);
		if ( nID > 0)  then
		
			local nType = gamefunc:GetItemType( nID);
			if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then

				local nDurability = gamefunc:GetInvenItemDurability( i);
				local nMaxDurability = gamefunc:GetItemMaxDurability( nID);
				
				if ( nDurability < nMaxDurability)  then
				
					local strName = gamefunc:GetItemName( nID);
					local strImage = gamefunc:GetItemImage( nID);
					local nCost = gamefunc:GetInvenItemRepairCost( i);
					
					nCount = nCount + 1;
					luaShop.m_nRepairPrice = luaShop.m_nRepairPrice + nCost;

				
					local nIndex = lcRepairItems:AddItem( strName, strImage);
					lcRepairItems:SetItemText( nIndex, 1, "$$" .. luaGame:ConvertMoneyToStr( nCost));
					lcRepairItems:SetItemText( nIndex, 2, STR( "DURABILITY") .. " : " .. nDurability .. " / " .. nMaxDurability);
					lcRepairItems:SetItemData( nIndex, nCount);
					
				
					luaShop.m_vRepairableItems[ nCount] = {};
					luaShop.m_vRepairableItems[ nCount].type = luaShop.REPAIR_TYPE.INVENTORY;
					luaShop.m_vRepairableItems[ nCount].slot = i;
				end
			end
		end
	end
	
	lcRepairItems:SetCurSel( nCurSel);
	
	
	
	-- Repair items info
	local strString = "{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}" .. STR( "UI_SHOP_TOTALCOST") .. " : " ..
		"{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( luaShop.m_nRepairPrice, "fntSmall");
	tvwRepairItemsInfo:SetText( strString);
end





-- RefreshRepairItemsControls
function luaShop:RefreshRepairItemsControls()

	btnRepairItem:Enable( false);
	btnRepairAllItems:Enable( false);


	local nCurSel = lcRepairItems:GetCurSel();
	
	local nMoney = gamefunc:GetMoney();
	if ( nCurSel >= 0)  then
	
		local nCost = 0;

		local nIndex = lcRepairItems:GetItemData( nCurSel);
		if ( nIndex > 0)  then
		
			local nType = luaShop.m_vRepairableItems[ nIndex].type;
			local nSlot = luaShop.m_vRepairableItems[ nIndex].slot;
			
			if ( nType == luaShop.REPAIR_TYPE.EQUIPPED)  then			nCost = gamefunc:GetEquippedItemRepairCost( nSlot);
			elseif ( nType == luaShop.REPAIR_TYPE.INVENTORY)  then		nCost = gamefunc:GetInvenItemRepairCost( nSlot);
			end
		end
		
		if ( nCost <= nMoney)  then  btnRepairItem:Enable( true);
		end
	else
	end
	

	if ( luaShop.m_nRepairPrice <= nMoney)  then  btnRepairAllItems:Enable( true);
	end
end





-- OnToolTipRepairItemList
function luaShop:OnToolTipRepairItemList()

	local strToolTip = "";
	
	local nCurSel = lcRepairItems:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcRepairItems:GetItemData( nCurSel);
		if ( nIndex > 0)  then
	
			local nType = luaShop.m_vRepairableItems[ nIndex].type;
			local nSlot = luaShop.m_vRepairableItems[ nIndex].slot;
			
			if ( nType == luaShop.REPAIR_TYPE.EQUIPPED)  then
			
				local nID = gamefunc:GetEquippedItemID( nSlot);
				strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
				
			elseif ( nType == luaShop.REPAIR_TYPE.INVENTORY)  then
			
				local nID = gamefunc:GetInvenItemID( nSlot);
				strToolTip = luaToolTip:GetItemToolTip( nID, nSlot, nil);
			end
		end
	end
	
	
	lcRepairItems:SetToolTip( strToolTip);
end





-- OnClickRepairItem
function luaShop:OnClickRepairItem()

	local nCurSel = lcRepairItems:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcRepairItems:GetItemData( nCurSel);
	if ( nIndex <= 0)  then  return;
	end
	
	local nType = luaShop.m_vRepairableItems[ nIndex].type;
	local nSlot = luaShop.m_vRepairableItems[ nIndex].slot;

	local nCost = 0;
	if ( nType == luaShop.REPAIR_TYPE.EQUIPPED)  then			nCost = gamefunc:GetEquippedItemRepairCost( nSlot);
	elseif ( nType == luaShop.REPAIR_TYPE.INVENTORY)  then		nCost = gamefunc:GetInvenItemRepairCost( nSlot);
	end
	
	if ( gamefunc:GetMoney() < nCost)  then  return;
	end
	

	-- Close frame if remained item count is 1
	if ( lcRepairItems:GetItemCount() <= 1)  then  frmConfirmRepairItems:Show( false);
	end


	-- Repair item
	local nID = 0;
	if ( nType == luaShop.REPAIR_TYPE.EQUIPPED)  then
		
		gamefunc:RepairEquippedItem( nSlot);
		nID = gamefunc:GetEquippedItemID( nSlot);
		
	elseif ( nType == luaShop.REPAIR_TYPE.INVENTORY)  then
	
		gamefunc:RepairInvenItem( nSlot);
		nID = gamefunc:GetInvenItemID( nSlot);
	end
	
	
	-- Play sound
	if ( nID > 0)  then
	
		local strSound = gamefunc:GetItemMakingSound( nID);
		gamefunc:PlaySound( strSound);
	end
end





-- OnClickRepairAllItems
function luaShop:OnClickRepairAllItems()

	frmConfirmRepairItems:Show( false);


	-- Repair items
	gamefunc:RepairAllItem();

	
	-- Play sound
	gamefunc:PlaySound( "item_hammer_down");	
end
