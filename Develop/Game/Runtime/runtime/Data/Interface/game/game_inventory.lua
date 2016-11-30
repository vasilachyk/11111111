--[[
	Game inventory LUA script
--]]


-- Global instance
luaInventory = {};


-- Item filtering type
luaInventory.FILTER_TYPE = { NONE = 0,  USABLE = 1,  EQUIPMENT = 2,  QUEST = 3,  RECIPE = 4 };
luaInventory.m_nFilteringType = luaInventory.FILTER_TYPE.NONE;


-- Variables of confirm frame
luaInventory.m_bConfirmItemQuantityToShop = false;
luaInventory.m_cbConfirmItemQuantity = nil;
luaInventory.m_cbConfirmMoneyAmount = nil;





-- OnShowInventoryFrame
function luaInventory:OnShowInventoryFrame()

	frmConfirmDropInvenItem:Show( false);
	frmConfirmItemQuantity:Show( false);
	frmConfirmMoneyAmount:Show( false);
	frmConfirmClaimInvelItem:Show( false);
	

	-- Show
	if ( frmInventory:GetShow() == true)  then
	
		luaInventory:RefreshInventory();
		
	-- Hide
	else
	
		-- Stop dyeing and enchanting
		luaDyeing:CloseDyeingFrame();
		luaEnchant:CloseEnchantFrame();
		
		
		-- Clear all flags of new item
		gamefunc:ClearAllInvenNewItemFlag();
	end
	
	
	luaGame:ShowWindow( frmInventory);
end





-- RefreshInventory
function luaInventory:RefreshInventory()

	if ( frmInventory:GetShow() == false)  then  return;
	end


	-- Stop all interface works
	frmConfirmDropInvenItem:Show( false);
	frmConfirmItemQuantity:Show( false);
	frmConfirmMoneyAmount:Show( false);
	frmConfirmClaimInvelItem:Show( false);


	-- Stop dyeing and enchanting
	luaDyeing:CloseDyeingFrame();
	luaEnchant:CloseEnchantFrame();


	-- Refresh UI
	luaInventory:RefreshInventoryList();
	luaInventory:RefreshMoney();
	luaInventory:RefreshControls();
end





-- RefreshInventoryList
function luaInventory:RefreshInventoryList()
	
	if ( frmInventory:GetShow() == false)  then  return;
	end

	
	local nCurSel = lcInventory:GetCurSel();
	
	lcInventory:DeleteAllItems();
	

	for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do

		local nID = gamefunc:GetInvenItemID( i);
		if ( nID <= 0)  then
		
			local nIndex = lcInventory:AddItem( "", "");
			lcInventory:SetItemData( nIndex, i);
			
		else
				
			local nType = gamefunc:GetItemType( nID);
			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
			end
			
			local nQuantity = gamefunc:GetInvenItemQuantity( i);
			
			local nType = gamefunc:GetItemType( nID);
			local nItemType = luaInventory.FILTER_TYPE.NONE;
			if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then			nItemType = luaInventory.FILTER_TYPE.EQUIPMENT;
			elseif ( nType == ITEM_TYPE.USABLE)  or  ( nType == ITEM_TYPE.ENCHANT)  or
				( nType == ITEM_TYPE.DYE)  then												nItemType = luaInventory.FILTER_TYPE.USABLE;
			end
			

			-- Add list item
			local nIndex = lcInventory:AddItem( strName, strImage);
			lcInventory:SetItemText( nIndex, 1, nQuantity);
			lcInventory:SetItemText( nIndex, 2, nItemType);
			lcInventory:SetItemData( nIndex, i);
		end
	end
	
	lcInventory:SetCurSel( nCurSel);
	
	
	-- Item count
	labInvenItemCount:SetText( gamefunc:GetInvenItemCount() .. " / " .. gamefunc:GetInvenItemMaxCount());
end





-- RefreshMoney
function luaInventory:RefreshMoney()
	
	if ( frmInventory:GetShow() == false)  then  return;
	end
	
	
	local nMoney = gamefunc:GetMoney();

	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( nMoney, "fntSmall") .. "{SPACE w=10}";
	tvwMoney:SetText( strMoney);
end





-- RefreshControls
function luaInventory:RefreshControls()

	if ( frmInventory:GetShow() == false)  then  return;
	end


	local bEnable = false;
	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel >= 0)  then
		
		local nIndex = lcInventory:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
			
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then

				bEnable = true;
			end
		end
	end
	
	btnDropInvenItem:Enable( bEnable);
end





-- OnDrawItemInvenListCtrl
function luaInventory:OnDrawItemInvenListCtrl()

	local x, y, w, h = EventArgs:GetItemRect();
	
	-- Draw glass pannel	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
	
	
	local nSlotID = EventArgs:GetItemIndex();
	local nID = gamefunc:GetInvenItemID( nSlotID);
	if ( nID <= 0)  then  return
	end
	
	local nType = gamefunc:GetItemType( nID);
	
--[[	
	-- Draw type pannel
	local strTypePannel = nil;
	if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then		strTypePannel = "bmpItemTypeSlot1";
	elseif ( gamefunc:IsItemQuestRelated( nID) == true)  then					strTypePannel = "bmpItemTypeSlot2";
	elseif ( nType == ITEM_TYPE.USABLE)  then									strTypePannel = "bmpItemTypeSlot3";
	end
	
	if ( strTypePannel ~= nil)  then
	
		gamedraw:SetBitmap( strTypePannel);
		gamedraw:Draw( x, y, w, h);
	end	
--]]

	-- Draw quantity
	local nQuantity = tonumber( lcInventory:GetItemText( nSlotID, 1));
	if ( nQuantity ~= nil)  and  ( nQuantity > 1)  then

		gamedraw:SetColor( 210, 210, 210);
		gamedraw:SetFont( "fntScriptStrong");
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( x, y, w - 1, h - 1, nQuantity);
	end
	

	-- Draw usable cooltime
	local bDrawed = false;
	if ( nType == ITEM_TYPE.USABLE)  then
	
		local nReuseTime = gamefunc:GetItemReuseTime( nID);
		local nRemained = gamefunc:GetInvenItemReuseTimeRemaining( nSlotID);
		local fTimeRatio = nRemained / nReuseTime;
	
		if ( fTimeRatio > 0.0) then
		
			local srx, sry, srw, srh;
			
			local _cell = math.floor( (1.0 - fTimeRatio) * 50);
			sx = math.floor( math.floor( _cell % 8) * 32);
			sy = math.floor( math.floor( _cell / 8) * 32);

			gamedraw:SetBitmap( "bmpCooltime");
			local _opacity = gamedraw:SetOpacity( 0.8);
			gamedraw:DrawEx( x, y, w, h, sx, sy, 32, 32);
			gamedraw:SetOpacity( _opacity);
			
			
			gamedraw:SetColor( 255, 180, 0);
			gamedraw:SetFont( "fntSmallStrong");
			gamedraw:SetTextAlign( "right", "top");
			gamedraw:TextEx( x, y, w - 1, h - 1, luaGame:ConvertTimeToStr( nRemained));
			
			bDrawed = true;
		end
	end
	
	
	-- Draw filtered item
	local nItemType = tonumber( lcInventory:GetItemText( nSlotID, 2));
	if ( bDrawed == false)  and
		( luaInventory.m_nFilteringType ~= luaInventory.FILTER_TYPE.NONE)  and
		( nItemType ~= luaInventory.m_nFilteringType) and
		( luaInventory.m_nFilteringType ~= luaInventory.FILTER_TYPE.QUEST  or  gamefunc:IsItemQuestRelated( nID) == false) and
		( luaInventory.m_nFilteringType ~= luaInventory.FILTER_TYPE.RECIPE  or  gamefunc:IsItemRecipeMaterial( nID) == false) then
	
		gamedraw:SetBitmap( "bmpCooltime");
		local _opacity = gamedraw:SetOpacity( 0.5);
		gamedraw:DrawEx( x, y, w, h, 0, 0, 32, 32);
		gamedraw:SetOpacity( _opacity);
	end
	

	-- Draw "NEW" mark
	if ( gamefunc:IsInvenNewItem( nSlotID) == true)  then
	
		gamedraw:SetBitmap( "iconNew");
		gamedraw:DrawEx( x, y, 14, 14, 0, 0, 14, 14);
	end
end





-- OnItemRClickInvenListCtrl
function luaInventory:OnItemRClickInvenListCtrl()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end


	-- Refresh menu UI
	btnInvenMenuUse:Enable( false);
	btnInvenMenuEquip:Enable( false);
	btnInvenMenuDrop:Enable( false);

	local nItemType = tonumber( lcInventory:GetItemText( nIndex, 2));
	if ( nItemType == luaInventory.FILTER_TYPE.USABLE)  then			btnInvenMenuUse:Enable( true);
	elseif ( nItemType == luaInventory.FILTER_TYPE.EQUIPMENT)  then		btnInvenMenuEquip:Enable( true);
	end
		
	btnInvenMenuDrop:Enable( true);


	-- Popup menu
	lcInventory:TrackPopupMenu( "pmInvenPopupMenu");
end





-- OnItemDblClickInvenListCtrl
function luaInventory:OnItemDblClickInvenListCtrl()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	if ( frmShop:GetShow() == true)  then

		if ( gamefunc:IsItemSellable( nID) == false)  then  return;
		end
	
		luaInventory:OpenConfirmItemQuantityFrame_ByIndex( luaShop.CallbackOnDropSellItem, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMSELLITEM"), nIndex, true);
	
	else

		local nItemType = tonumber( lcInventory:GetItemText( nCurSel, 2));
		if ( nItemType == luaInventory.FILTER_TYPE.USABLE)  then			luaInventory:DoUseInvenItem( nIndex);
		elseif ( nItemType == luaInventory.FILTER_TYPE.EQUIPMENT)  then		luaInventory:DoEquipInvenItem( nIndex);
		end
		
	end
end





-- OnSelChangeInvenListCtrl
function luaInventory:OnSelChangeInvenListCtrl()

	luaInventory:RefreshControls();
end





-- OnDragBeginInvenListCtrl
function luaInventory:OnDragBeginInvenListCtrl()

	local nItemCount = DragEventArgs:GetItemCount();
	if ( nItemCount <= 0)  then  return false;
	end
	
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return false;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end
	
	
	-- Play sound
	local strSound = gamefunc:GetItemPutUpSound( nID);
	gamefunc:PlaySound( strSound);
	
	return true;
end





-- OnDragEndInvenListCtrl
function luaInventory:OnDragEndInvenListCtrl()

	-- Stop dyeing and enchanting
	if ( frmDyeing:GetShow() == true)  then		luaDyeing:CloseDyeItem();
	else										luaDyeing:CloseDyeingFrame();
	end
	
	if ( frmEnchant:GetShow() == true)  then	luaEnchant:CloseEnchantItem();
	else										luaEnchant:CloseEnchantFrame();
	end
	
	return false;
end





-- OnDropInvenListCtrl
function luaInventory:OnDropInvenListCtrl()

    local _sender = _G[ DragEventArgs:GetSender():GetName()];
    
    -- Self drop : merge, exchange, dyeing, enchanting
    local bRetVal = false;
    if ( _sender == lcInventory)  then
    
   		local nSrcIndex = DragEventArgs:GetItemData( 0);
		local nSrcID = gamefunc:GetInvenItemID( nSrcIndex);

		local nMouseOver = lcInventory:GetMouseOver();
		if ( nMouseOver >= 0)  then

			local nTarIndex = lcInventory:GetItemData( nMouseOver);
			local nTarID = gamefunc:GetInvenItemID( nTarIndex);

			if ( nSrcIndex ~= nTarIndex)  then
			
				-- Dyeing
				if ( luaDyeing.m_bDyeing == true)  and  ( gamefunc:GetItemType( nSrcID) == ITEM_TYPE.DYE)  then
				
					bRetVal = luaDyeing:OpenDyeingFrame( luaDyeing.DYE_TYPE.INVENTORY, nTarIndex);

				-- Enchanting
				elseif ( luaEnchant.m_bEnchanting == true)  and  ( gamefunc:GetItemType( nSrcID) == ITEM_TYPE.ENCHANT)  then
				
					bRetVal = luaEnchant:OpenEnchantFrame( luaEnchant.ENCHANT_TYPE.INVENTORY, nTarIndex);

				-- Merge, exchange
				else
				
					gamefunc:MoveInvenItem( nSrcIndex, nTarIndex);
					bRetVal = true;
				end
					

				lcInventory:SetCurSel( nTarIndex);
			end
		end
	
		
		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( nSrcID);
		gamefunc:PlaySound( strSound);

		
	-- Buy item from shop
	elseif ( _sender == lcShop)  then
	
		luaShop:OpenConfirmBuyItemQuantity();
		bRetVal = true;
		

	-- Unequip item
	elseif ( _sender == isFace)  or  ( _sender == isHead)  or  ( _sender == isBody)  or  ( _sender == isHands)  or  ( _sender == isFeet)  or
		   ( _sender == isLeg)  or  ( _sender == isEarring)  or  ( _sender == isNecklace)  or  ( _sender == isRingR)  or  ( _sender == isRingL)  or
		   ( _sender == isWeapon1)  or  ( _sender == isWeapon1Sub)  or  ( _sender == isWeapon2)  or  ( _sender == isWeapon2Sub)  then
		   
		luaCharacter:OnDragOutEquippedItemSlot();
		bRetVal = true;
		
	elseif ( _sender == lcStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcInventory:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcInventory:GetItemData( nMouseOver);

					luaStorage.nTargetIndex = nTarIndex;

					luaStorage:OpenConfirmItemQuantityFrame( luaInventory.CallbackOnDropMoveItem, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"));
				
					bRetVal = true;
				end
			end
		end
		
	elseif ( _sender == lcGuildStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetGuildStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcInventory:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcInventory:GetItemData( nMouseOver);

					luaGuildStorage.nTargetIndex = nTarIndex;

					luaGuildStorage:OpenConfirmItemQuantityFrame( luaInventory.CallbackOnDropMoveItemGuild, STR( "CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"));
				
					bRetVal = true;
				end
			end
		end
	
	end
	
	
	return bRetVal;
end






function luaInventory:CallbackOnDropMoveItemGuild(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetGuildStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end

	gamefunc:WithdrawGuildItem(nIndex, luaGuildStorage.nTargetIndex, nQuantity);
end





function luaInventory:CallbackOnDropMoveItem(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end

	gamefunc:WithdrawItem(nIndex, luaStorage.nTargetIndex, nQuantity);
end





-- OnToolTipInvenListCtrl
function luaInventory:OnToolTipInvenListCtrl()

	local strToolTip = "";

	local nSel = lcInventory:GetMouseOver();
	if ( nSel >= 0)  then
	
		local nIndex = lcInventory:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then

					strToolTip = "{COLOR r=100 g=160 b=100}< " .. STR( "UI_SELECTEDITEM") .. " >{/COLOR}\n" .. strToolTip .. "{divide}" ..
						"{COLOR r=100 g=160 b=100}< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nID);
				end
			end
		end
	end

	lcInventory:SetToolTip( strToolTip);
end





-- DoUseInvenItem
function luaInventory:DoUseInvenItem( nIndex)

	if ( nIndex < 0)  then  return false;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end
	
	
	local nType = gamefunc:GetItemType( nID);
	if ( nType == ITEM_TYPE.USABLE)  then			gamefunc:UseInvenItem( nIndex);
	elseif ( nType == ITEM_TYPE.DYE)  then			luaDyeing:OpenDyeItem( nIndex);
	elseif ( nType == ITEM_TYPE.ENCHANT)  then		luaEnchant:OpenEnchantItem( nIndex);
	end
end





-- DoEquipInvenItem
function luaInventory:DoEquipInvenItem( nIndex)

	if ( nIndex < 0)  then  return false;
	end

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end

	
	-- Check item type
	local nType = gamefunc:GetItemType( nID);
	if ( nType ~= ITEM_TYPE.WEAPON)  and  ( nType ~= ITEM_TYPE.ARMOR)  then  return;
	end


	-- Check required claim
	if ( frmConfirmClaimInvelItem:GetShow() == false)  then
	
		if ( gamefunc:IsItemRequiredClaim( nID) == true)  and  ( gamefunc:IsInvenItemClaimed( nIndex) == false)  then
		
			luaInventory:OpenConfirmClaimInvenItem();	
			return;						
		end
	end
	

	-- Get target slot
	local nSlot = gamefunc:GetItemSlot( nID);
	if ( nSlot == ITEM_SLOT.RFINGER)  and  ( gamefunc:GetEquippedItemID( ITEM_SLOT.RFINGER) > 0)  then  nSlot = ITEM_SLOT.LFINGER;
	end


	-- Play sound
	local strSound = gamefunc:GetItemPutDownSound( nID);
	gamefunc:PlaySound( strSound);


	-- Equip item
	gamefunc:EquipInvenItem( nSlot, nIndex);
end





-- OnClickFilterInvenItemType
function luaInventory:OnClickFilterInvenItemTypeMenu( nFilterType, strIconImage, strToolTip)
	
	luaInventory.m_nFilteringType = nFilterType;
	
	btnFilterInvenItemType:SetIcon( strIconImage);
	btnFilterInvenItemType:SetToolTip( strToolTip);
end





-- OnDragBeginMoney
function luaInventory:OnDragBeginMoney()

	DragEventArgs:AddDragData( STR( "MONEY"), "iconMoney", gamefunc:GetMoney());
	DragEventArgs:SetFont( "fntRegular");
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetHotSpot( 20, 20);
	
	
	-- Play sound
	local strSound = gamefunc:GetMoneyPutUpSound();
	gamefunc:PlaySound( strSound);

	return true;
end






function luaInventory:OnDropMoney()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end

	local bRetVal = false;

	if ( _sender == tvwStorageMoney)  then
	
		luaStorage:OpenConfirmMoneyAmountFrame( luaStorage.CallbackDropWithdrawMoney, gamefunc:GetStorageMoney());
		
		bRetVal = true;
		
	elseif ( _sender == tvwGuildStorageMoney)  then

		luaGuildStorage:OpenConfirmMoneyAmountFrame( luaGuildStorage.CallbackDropWithdrawMoney, gamefunc:GetGuildStorageMoney());
		
		bRetVal = true;
	
	end
	

	return bRetVal;
end














-- OpenConfirmDropInvenItem
function luaInventory:OpenConfirmDropInvenItem()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	

	-- Set description
	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) ..
		"{/COLOR}{/FONT}{CR}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" .. STR( "QUANTITY") .. " : " .. gamefunc:GetInvenItemQuantity( nIndex);
	tvwInvenDropItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwInvenDropItemDesc:SetToolTip( strToolTip);
	

	-- Show frame
	local x, y = frmConfirmDropInvenItem:GetParent():GetPosition();
	local w, h = frmConfirmDropInvenItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmDropInvenItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmDropInvenItem:DoModal();
	
	
	btnDropInvenItem:Enable( false);
end





-- CloseConfirmDropInvenItem
function luaInventory:CloseConfirmDropInvenItem()

	frmConfirmDropInvenItem:Show( false);
	
	luaInventory:RefreshControls();
end





-- OnDropInvenItemOK
function luaInventory:OnDropInvenItemOK()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcInventory:GetItemData( nCurSel);
		if ( nIndex >= 0)  then  gamefunc:DropInvenItem( nIndex);
		end
		

		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( gamefunc:GetInvenItemID( nIndex));
		gamefunc:PlaySound( strSound);
	end

	luaInventory:CloseConfirmDropInvenItem();
end





















-- OpenConfirmClaimInvenItem
function luaInventory:OpenConfirmClaimInvenItem()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	

	-- Set description
	local strName = gamefunc:GetItemName( nID);
	local strImage = gamefunc:GetItemImage( nID);
	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID);
	tvwClaimItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwClaimItemDesc:SetToolTip( strToolTip);
	

	-- Show frame
	local x, y = frmConfirmClaimInvelItem:GetParent():GetPosition();
	local w, h = frmConfirmClaimInvelItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmClaimInvelItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmClaimInvelItem:DoModal();
	
	btnDropInvenItem:Enable( false);
end





-- CloseConfirmClaimInvenItem
function luaInventory:CloseConfirmClaimInvenItem()

	frmConfirmClaimInvelItem:Show( false);
	
	luaInventory:RefreshControls();
end





-- OnClaimInvenItemOK
function luaInventory:OnClaimInvenItemOK()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end


	luaInventory:DoEquipInvenItem( nIndex);
end
















-- OpenConfirmItemQuantityFrame
function luaInventory:OpenConfirmItemQuantityFrame( callbackFunc, strTitle, strMessage, bShop)

   	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return;
	end

	luaInventory:OpenConfirmItemQuantityFrame_ByIndex( callbackFunc, strTitle, strMessage, nIndex, bShop)

end





-- OpenConfirmItemQuantityFrame_ByIndex
function luaInventory:OpenConfirmItemQuantityFrame_ByIndex( callbackFunc, strTitle, strMessage, nIndex, bShop)

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	if ( callbackFunc == nil)  then  return;
	end
	

	-- Set variables
	luaInventory.m_bConfirmItemQuantityToShop = bShop or false;
	luaInventory.m_cbConfirmItemQuantity = callbackFunc;


	-- Direct call
	local nQuantity = gamefunc:GetInvenItemQuantity( nIndex);
	if ( luaInventory.m_bConfirmItemQuantityToShop == false)  and  ( nQuantity == 1)  then

		luaInventory:m_cbConfirmItemQuantity( nIndex, nQuantity);
		
		
		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( nID);
		gamefunc:PlaySound( strSound);
		
		return;
	end
		

	-- Set title and message
	frmConfirmItemQuantity:SetText( strTitle);
	tvwConfirmItemQuantityMessage:SetText( strMessage);


	-- Set message and tooltip
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) .. "{/COLOR}{/FONT}{CR h=23}" ..
		"{FONT name=\"fntScript\"}" .. STR( "QUANTITY") .. " : " .. nQuantity;
	tvwConfirmItemQuantityDesc:SetText( strString);

	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwConfirmItemQuantityDesc:SetToolTip( strToolTip);
	
	
	-- Initialize quantity edit
	edtConfirmItemQuantity:SetText( nQuantity);
	

	-- Set price
	if ( luaInventory.m_bConfirmItemQuantityToShop == true)  then
	
		local nPrice = gamefunc:GetInvenItemSellCost( nIndex) * tonumber( edtConfirmItemQuantity:GetText());
		local strString = "{COLUMN h=23}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nPrice, "fntSmall");
		tvwConfirmItemPriceDesc:SetText( strString);
		
	else
	
		tvwConfirmItemPriceDesc:SetText( "");
	end


	-- Show frame
	local x, y = frmConfirmItemQuantity:GetParent():GetPosition();
	local w, h = frmConfirmItemQuantity:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmItemQuantity:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmItemQuantity:DoModal();
	

	-- Set focus	
	edtConfirmItemQuantity:SetFocus();
	edtConfirmItemQuantity:SetSel( 0, edtConfirmItemQuantity:GetLength());


	btnDropInvenItem:Enable( false);
end





-- CloseConfirmItemQuantityFrame
function luaInventory:CloseConfirmItemQuantityFrame()

	luaInventory.m_cbConfirmItemQuantity = nil;
	
	frmConfirmItemQuantity:Show( false);
	
	luaInventory:RefreshControls();
end





-- OnValueChangedConfirmItemQuantity
function luaInventory:OnValueChangedConfirmItemQuantity()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	

	local nMaxQuantity = gamefunc:GetInvenItemQuantity( nIndex);
	
	local strText = edtConfirmItemQuantity:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmItemQuantity:SetText( "1");
		edtConfirmItemQuantity:SetSel( 0, edtConfirmItemQuantity:GetLength());

	else
	
		local nQuantity = tonumber( strText);
		if ( nQuantity < 1)  then
			
			edtConfirmItemQuantity:SetText( "1");
			edtConfirmItemQuantity:SetSel( 0, edtConfirmItemQuantity:GetLength());

		elseif ( nQuantity > nMaxQuantity)  then

			edtConfirmItemQuantity:SetText( tostring( nMaxQuantity));
			edtConfirmItemQuantity:SetSel( 0, edtConfirmItemQuantity:GetLength());
		end
	end
	
	
	-- Set price
	if ( luaInventory.m_bConfirmItemQuantityToShop == true)  then
	
		local nPrice = gamefunc:GetInvenItemSellCost( nIndex) * tonumber( edtConfirmItemQuantity:GetText());
		local strString = "{COLUMN h=23}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nPrice, "fntSmall");
		tvwConfirmItemPriceDesc:SetText( strString);
	end
end





-- DoConfirmItemQuantity
function luaInventory:DoConfirmItemQuantity()

	local nCurSel = lcInventory:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcInventory:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
		
				if ( luaInventory.m_cbConfirmItemQuantity ~= nil)  then

					local nQuantity = tonumber( edtConfirmItemQuantity:GetText());

					luaInventory:m_cbConfirmItemQuantity( nIndex, nQuantity);
					
					
					-- Play sound
					local strSound = gamefunc:GetItemPutDownSound( nID);
					gamefunc:PlaySound( strSound);
				end
			end
		end
	end


	luaInventory:CloseConfirmItemQuantityFrame();
end


















-- OpenConfirmMoneyAmountFrame
function luaInventory:OpenConfirmMoneyAmountFrame( callbackFunc, nDefaultMoney)

	if ( callbackFunc == nil)  then  return;
	end
	
	
	nDefaultMoney = nDefaultMoney or 0;
	
	
	
	-- Set callback function
	luaInventory.m_cbConfirmMoneyAmount = callbackFunc;

	
	-- Set message and tooltip
	local strMoney = luaGame:ConvertMoneyToStr( gamefunc:GetMoney(), "fntSmall");
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"iconMoney\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. STR( "MONEY") .. "{/COLOR}{/FONT}{CR h=23}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" ..
		"{ALIGN ver=\"bottom\"}" .. strMoney .. "{/COLOR}{/FONT}";
	tvwConfirmMoneyAmountDesc:SetText( strString);

	
	-- Initialize edit box
	local _gold = math.floor( nDefaultMoney / 10000);
	local _silver = math.floor( ( nDefaultMoney % 10000) / 100);
	local _copper = nDefaultMoney % 100;
	edtConfirmMoneyAmountGold:SetText( _gold);
	edtConfirmMoneyAmountSilver:SetText( _silver);
	edtConfirmMoneyAmountCopper:SetText( _copper);
	

	-- Show frame
	local x, y = frmConfirmMoneyAmount:GetParent():GetPosition();
	local w, h = frmConfirmMoneyAmount:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmMoneyAmount:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmMoneyAmount:DoModal();
	
	
	-- Set focus
	edtConfirmMoneyAmountCopper:SetFocus();
	edtConfirmMoneyAmountCopper:SetSel( 0, edtConfirmMoneyAmountCopper:GetLength());
	
	
	btnDropInvenItem:Enable( false);
end





-- ClosConfirmMoneyAmountFrame
function luaInventory:ClosConfirmMoneyAmountFrame()

	luaInventory.m_cbConfirmMoneyAmount = nil;
	
	frmConfirmMoneyAmount:Show( false);
	
	luaInventory:RefreshControls();
end





-- OnValueChangedConfirmMoneyAmountGold
function luaInventory:OnValueChangedConfirmMoneyAmountGold()

	local strText = edtConfirmMoneyAmountGold:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmMoneyAmountGold:SetText( "0");
		edtConfirmMoneyAmountGold:SetSel( 0, edtConfirmMoneyAmountGold:GetLength());

	elseif ( tonumber( strText) >= 100)  then

		edtConfirmMoneyAmountGold:SetText( "99");
		edtConfirmMoneyAmountGold:SetSel( 0, edtConfirmMoneyAmountGold:GetLength());
	end
end





-- OnValueChangedConfirmMoneyAmountSilver
function luaInventory:OnValueChangedConfirmMoneyAmountSilver()

	local strText = edtConfirmMoneyAmountSilver:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmMoneyAmountSilver:SetText( "0");
		edtConfirmMoneyAmountSilver:SetSel( 0, edtConfirmMoneyAmountSilver:GetLength());
		
	elseif ( tonumber( strText) >= 100)  then

		edtConfirmMoneyAmountSilver:SetText( "99");
		edtConfirmMoneyAmountSilver:SetSel( 0, edtConfirmMoneyAmountSilver:GetLength());
	end
end





-- OnValueChangedConfirmMoneyAmountCopper
function luaInventory:OnValueChangedConfirmMoneyAmountCopper()

	local strText = edtConfirmMoneyAmountCopper:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmMoneyAmountCopper:SetText( "0");
		edtConfirmMoneyAmountCopper:SetSel( 0, edtConfirmMoneyAmountCopper:GetLength());
		
	elseif ( tonumber( strText) >= 100)  then

		edtConfirmMoneyAmountCopper:SetText( "99");
		edtConfirmMoneyAmountCopper:SetSel( 0, edtConfirmMoneyAmountCopper:GetLength());
	end
end





-- DoConfirmMoneyAmount
function luaInventory:DoConfirmMoneyAmount()

	if ( luaInventory.m_cbConfirmMoneyAmount ~= nil)  then

		local _gold = tonumber( edtConfirmMoneyAmountGold:GetText());
		local _silver = tonumber( edtConfirmMoneyAmountSilver:GetText());
		local _copper = tonumber( edtConfirmMoneyAmountCopper:GetText());
		
		local nMoney = _gold * 10000  +  _silver * 100  +  _copper;
		
		luaInventory:m_cbConfirmMoneyAmount( nMoney);


		-- Play sound
		local strSound = gamefunc:GetMoneyPutDownSound();
		gamefunc:PlaySound( strSound);
	end


	luaInventory:ClosConfirmMoneyAmountFrame();
end
