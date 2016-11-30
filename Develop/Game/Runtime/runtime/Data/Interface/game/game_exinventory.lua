--[[
	Game Exinventory LUA script
--]]


-- Global instance
luaExInventory = {};


-- Item filtering type
luaExInventory.COLUMN =
{ 
	NAME = 0,
	QUANTITY = 1,
	EQUIPMENT = 2,
	USABLE = 3,
	METERIAL = 4,
	QUEST = 5,
	ETC = 6,
	NEW = 7,
	DISABLED = 8,
	ENCHANTITEM = 9,
	PERIOD = 10,
	CRAFTCOSTUME = 11,
	ELEMENT_ENCHANT_ITEM = 12
};


-- Variables of confirm frame
luaExInventory.m_bConfirmItemQuantityToShop = false;
luaExInventory.m_cbConfirmItemQuantity = nil;
luaExInventory.m_cbConfirmMoneyAmount = nil;
luaExInventory.nConfirmMoneyAmountGold = 40000;

-- Default Position
luaExInventory.nDefaultX	= 625;
luaExInventory.nDefaultY	= 80;

-- Arrange Time
luaExInventory.nArrangeTime			= 10000;
luaExInventory.nArrangeStartTime	= 0;


-- OnShowInventoryFrame
function luaExInventory:OnShowInventoryFrame()

	frmConfirmDropInvenItem:Show( false);
	frmConfirmItemQuantity:Show( false);
	frmConfirmMoneyAmount:Show( false);
	frmConfirmClaimInvelItem:Show( false);
	frmDyeingOk:Show( false);

	-- Show
	if ( frmExInventory:GetShow() == true)  then
	
		local x, y = frmInventory:GetPosition();
		local w, h = frmInventory:GetSize();
		frmExInventory:SetPosition( x+w+10, y);
	
		luaExInventory:RefreshInventory();
		
        picExinven:SetImage("iconInventoryOpen");
		
	-- Hide
	else
	
		-- Stop dyeing and GemEnchant
		luaDyeing:CloseDyeingFrame();
		luaCraftingCostume:CloseCraftingCostumeFrame();
		luaGemEnchant:CloseGemEnchantFrame();
		
		
		-- Clear all flags of new item
		gamefunc:ClearAllInvenNewItemFlag();

		-- 물품 등록창 닫기
		if( true == frmRegisterItem:GetShow() )	then
			frmRegisterItem:Show( false );
		end

        picExinven:SetImage("iconInventoryClose");

	end
	
	
	luaGame:ShowWindow( frmExInventory);
end





-- RefreshInventory
function luaExInventory:RefreshInventory()

	if ( frmInventory:GetShow() == false)  then  return;
	end


	-- Stop all interface works
	frmConfirmDropInvenItem:Show( false);
	frmConfirmItemQuantity:Show( false);
	frmConfirmMoneyAmount:Show( false);
	frmConfirmClaimInvelItem:Show( false);


	-- Stop dyeing and GemEnchant
	luaDyeing:CloseDyeingFrame();
	luaCraftingCostume:CloseCraftingCostumeFrame();
	luaGemEnchant:CloseGemEnchantFrame();


	-- Refresh UI
	luaExInventory:RefreshInventoryList();
	luaExInventory:RefreshControls();
end





-- RefreshInventoryList
function luaExInventory:RefreshInventoryList()
	
	if ( frmInventory:GetShow() == false)  then  return;
	end

	
	local nCurSel = lcExInventory:GetCurSel();
	
	lcExInventory:DeleteAllItems();
	

	for  i = 80, (gamefunc:GetInvenItemMaxCount() - 1)  do

		local nID = gamefunc:GetInvenItemID( i);
		if ( nID <= 0)  then
		
			local nIndex = lcExInventory:AddItem( "", "");
			lcExInventory:SetItemData( nIndex, i);
			
		else
		
			local strName = gamefunc:GetInvenItemName( i );
			local strImage = gamefunc:GetItemImage( nID);
			if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
			end
			
			-- Add list item
			local nIndex = lcExInventory:AddItem( strName, strImage);
			lcExInventory:SetItemData( nIndex, i);
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.EQUIPMENT,		"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,		"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.METERIAL,		"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.QUEST,			"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ETC,			"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.NEW,			"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.DISABLED,		"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ENCHANTITEM,	"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.PERIOD,		"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.CRAFTCOSTUME,	"0");
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ELEMENT_ENCHANT_ITEM,	"0");
			
			
			-- Quantity
			lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.QUANTITY, gamefunc:GetInvenItemQuantity( i));

			-- Item type
			local nType = gamefunc:GetItemType( nID);
				if ( nType == ITEM_TYPE.WEAPON)		then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.EQUIPMENT, "1");
			elseif ( nType == ITEM_TYPE.ARMOR)		then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.EQUIPMENT, "1");
			elseif ( nType == ITEM_TYPE.LOOK)		then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.EQUIPMENT, "1");
			elseif ( nType == ITEM_TYPE.USABLE)		then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,	"1");
			elseif ( nType == ITEM_TYPE.GEMENCHANT)	then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,	"1");
			elseif ( nType == ITEM_TYPE.GEMREMOVE)	then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,	"1");
			elseif ( nType == ITEM_TYPE.GEMEXTRACT)	then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,	"1");
			elseif ( nType == ITEM_TYPE.DYE)		then	lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.USABLE,	"1");
			end
			
			if ( nType == ITEM_TYPE.INVENTORY )  then
				if ( gamefunc:IsItemRecipeMaterial( nID) == true) then
					lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.METERIAL, "1");
				end
			end
			
			if ( gamefunc:IsItemQuestRelated( nID) == true) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.QUEST, "1");
			end

			local nTier = gamefunc:GetItemTier( nID);
			if ( nTier == ITEM_TIER.VERYCOMMON) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ETC, "1");
			end
			
			-- New item
			if ( gamefunc:IsInvenNewItem( i) == true) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.NEW, "1");
			end

			-- Disabled
			local nReqLevel = gamefunc:GetItemEquipReqLevel( nID);
			if ( nReqLevel > 0)  and  ( gamefunc:GetLevel() < nReqLevel) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.DISABLED, "1");
			end
			
			local nDurability = gamefunc:GetInvenItemDurability( i)
			local nMaxdurability = gamefunc:GetInvenItemMaxDurability( i);
			if ( nMaxdurability > 0)  and  ( nDurability == 0) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.DISABLED, "1");
			end
			
			
			local nLicense = gamefunc:GetItemReqLicense( nID);
			if ( ITEM_TYPE.LOOK ~= nType ) then
				if ( nLicense ~= LICENSE_TYPE.NONE)  and  ( gamefunc:HasItemReqLicense( nID, nLicense) == false)  then
					lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.DISABLED, "1");
				end
			end
			
			-- ENCHANTITEM
			if( true == gamefunc:IsShowInvenEnchantItem( i ) )	then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ENCHANTITEM, "1");
			end
			
			if( true == gamefunc:IsShowInvenElementEnchantItem( i ) )	then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.ELEMENT_ENCHANT_ITEM, "1");
			end
			
			-- 기간제 아이템
			if ( true == gamefunc:IsPeriodRemainTime(nID) ) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.PERIOD, "1");
			end
			
			-- 코스튬 가능 아이템
			if ( true == gamefunc:IsItemCraftableCostume(nID) ) then
				lcExInventory:SetItemText( nIndex, luaExInventory.COLUMN.CRAFTCOSTUME, "1");
			end
			
		end
	end
	
	lcExInventory:SetCurSel( nCurSel);
	
	
	-- Item count
	labExInvenItemCount:SetText( gamefunc:GetInvenItemCount(1) .. " / " .. 80);
end





-- RefreshTime
function luaExInventory:RefreshTime()
	
	if ( frmExInventory:GetShow() == false)  then  return;
	end
	
	local strString = "";
	
	if (gamefunc:IsExInventory() == true)	then
	
		local strConvert = luaGame:ConvertTimeToStrOne( gamefunc:GetExInvenRemainTime(1), "fntSmallChat");
		
		if ( strConvert ~= nil) then
			local strTime = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}"
				.. strConvert .. "{FONT name=\"fntSmallChat\"}";
		
			strString = "   " .. FORMAT( "UI_INVEN_EXTIME", strTime) .. "{/FONT}";
		end
	else
		
		strString = "{COLUMN h=22}{ALIGN hor=\"left\" ver=\"bottom\"}" .. STR( "UI_INVEN_EXTIME_EXPIRE");
	end
	
	tvwExInvenTime:SetText( strString);
end





-- RefreshControls
function luaExInventory:RefreshControls()

	if ( frmInventory:GetShow() == false)  then  return;
	end

	if (luaExInventory.nArrangeStartTime == 0) then
		btnArrangeExInventory:Enable(gamefunc:IsExInventory());	
	end
end





-- OnLoadedInvenFilterTabCtrl
function luaExInventory:OnLoadedInvenFilterTabCtrl()

	tbcExInvenTypeFilter:SetTabName( 0, STR( "UI_INVEN_SHOWALL"));
	tbcExInvenTypeFilter:SetTabName( 1, STR( "UI_INVEN_SHOWEQIUPMENT"));
	tbcExInvenTypeFilter:SetTabName( 2, STR( "UI_INVEN_SHOWUSABLE"));
	tbcExInvenTypeFilter:SetTabName( 3, STR( "UI_INVEN_SHOWMETERIAL"));
	tbcExInvenTypeFilter:SetTabName( 4, STR( "UI_INVEN_SHOWQUESTITEM"));
	tbcExInvenTypeFilter:SetTabName( 5, STR( "UI_INVEN_SHOWETC"));


	local px = 0;
	for  i = 0, 5  do
	
		local x, y, w, h = tbcExInvenTypeFilter:GetTabRect( i);
		w = gamedraw:GetTextWidth( "fntScript", tbcExInvenTypeFilter:GetTabName( i)) + 20;
		tbcExInvenTypeFilter:SetTabRect( i, px, y, w, h);

		px = px + w;
	end
end





-- OnDrawItemInvenListCtrl
function luaExInventory:OnDrawItemInvenListCtrl()

	local nIndex = EventArgs:GetItemIndex();
	local nSlotID = lcExInventory:GetItemData(nIndex);
	local x, y, w, h = EventArgs:GetItemRect();


	local bDraw = false;
	local bFiltered = false;
	local bCooltime = false;

	local strImage = lcExInventory:GetItemImage( nIndex);
	if ( strImage ~= nil)  and  ( strImage ~= "")  then  bDraw = true;
	end
	
	local nFilter = tbcExInvenTypeFilter:GetSelIndex();
	if ( luaDyeing.m_bDyeing == true)  or ( luaGemEnchant.m_bGemEnchant == true)  then  nFilter = 1;
	end
	
	if( luaCraftingCostume.m_bCraftingCostume == true)	then nFilter = 10;
	end
	
	-- Enchant Check
	if( true == frmEnchant:GetShow() )			then
	
		if ( "1" ~= lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.ENCHANTITEM ) )  then
			bFiltered		= true;
		end
		
	end
	
	-- Enchant Check
	if( true == frmElementEnchant:GetShow() )			then
	
		if ( "1" ~= lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.ELEMENT_ENCHANT_ITEM ) )  then
			bFiltered		= true;
		end
		
	end
	
	if ( nFilter ~= 0)  and  ( lcExInventory:GetItemText( nIndex, nFilter + 1) ~= "1")  then  bFiltered = true;
	end

	if ( bDraw == true)  and  ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.USABLE) == "1")  then

		if ( gamefunc:GetInvenItemReuseTimeRemaining( nSlotID) > 0)  then  bCooltime = true;
		end
	end
	
	if( nIndex == luaMyMarket.RegisterItemSlotID )	then
		bFiltered		= true;
	end
	
	if( true == luaEnchant:IsSelectedEnchantItem( nIndex ) )	then
		bFiltered		= true;
	end
	
	if( true == luaMailBox:IsAttachedObj( nIndex ) )	then
		bFiltered		= true;
	end

	
	-- Draw item
	gamedraw:SetBitmap( strImage);
	if ( bDraw == true)  then
	
		if ( ( ( bFiltered == true)  and  ( bCooltime == false) ) )	then

			gamedraw:SetColorEx( 32, 32, 32, 220);

			if ( lcExInventory:GetItemText( nIndex, nFilter + 1)  == "2" ) then
			--	gamedraw:SetColorEx( 80, 80, 80, 200);
			end

			gamedraw:FillRect( x, y, w, h);
			
		elseif ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.DISABLED) == "1")  then
		
			local r, g, b = gamedraw:SetBitmapColor( 255, 128, 128);
			gamedraw:Draw( x, y, w, h);
			gamedraw:SetBitmapColor( r, g, b);

			gamedraw:SetColorEx( 128, 0, 0, 64);
			gamedraw:FillRect( x, y, w, h);
			
		elseif ( bFiltered == false)  and  ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.NEW) == "1")  then
		
			local _effect = gamedraw:SetEffect( "add");
			local _opacity = gamedraw:SetOpacity( 0.6 * math.sin( gamefunc:GetUpdateTime() * 0.005));
			gamedraw:SetBitmap( strImage);
			gamedraw:Draw( x, y, w, h);
			gamedraw:SetOpacity( _opacity);
			gamedraw:SetEffect( _effect);
		
		elseif ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.PERIOD) == "1")  then
		
			--local r, g, b = gamedraw:SetBitmapColor( 230, 222, 68);
			--gamedraw:Draw( x, y, w, h);
			--gamedraw:SetBitmapColor( r, g, b);

		end		
		
		-- ExInventory
		if (gamefunc:IsExInventory() == false)	then

			gamedraw:SetColorEx( 12, 12, 12, 100);
			
			gamedraw:FillRect( x, y, w, h);
		end
	end
	
	-- Draw glass pannel
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);
	
	if ( bDraw == false)  then  return;
	end


	-- Draw quantity
	local nQuantity = tonumber( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.QUANTITY));
	if ( nQuantity ~= nil)  and  ( nQuantity > 1)  then

		if ( bFiltered == true)  then		gamedraw:SetColorEx( 210, 210, 210, 32);
		else								gamedraw:SetColor( 210, 210, 210);
		end
		
		gamedraw:SetFont( "fntScriptStrong");
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( x, y, w - 1, h - 1, nQuantity);
	end
	

	-- Draw usable cooltime
	if ( bCooltime == true)  then
	
		local nReuseTime = gamefunc:GetItemReuseTime( gamefunc:GetInvenItemID( nSlotID));
		local nRemained = gamefunc:GetInvenItemReuseTimeRemaining( nSlotID);
		local fTimeRatio = nRemained / nReuseTime;
	
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
		gamedraw:SetTextAlign( "center", "center");
		gamedraw:TextEx( x, y, w - 1, h - 1, luaGame:ConvertTimeToStrForInven( nRemained));
	end
	
	
	local _opacity;
	if ( bFiltered == true)  then		_opacity = gamedraw:SetOpacity( 0.2);
	else								_opacity = gamedraw:SetOpacity( 1.0);
	end
	
	
	-- Draw new item marker
	if ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.NEW) == "1")  then
	
		gamedraw:SetBitmap( "iconNewMarker");
		gamedraw:DrawEx( x, y, 14, 14, 0, 0, 14, 14);
	end


	-- Draw quest item marker
	if ( lcExInventory:GetItemText( nIndex, luaExInventory.COLUMN.QUEST) == "1")  then
	
		gamedraw:SetBitmap( "iconQuestMarker");
		gamedraw:DrawEx( x + w - 14, y, 14, 14, 0, 0, 14, 14);
	end
	
	gamedraw:SetOpacity( _opacity);
end





-- OnItemDblClickInvenListCtrl
function luaExInventory:OnItemDblClickInvenListCtrl()

	if( gamefunc:IsExInventory() == false) then	return;
	end

	local nCurSel = lcExInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcExInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	
	if( frmMailBox:GetShow() == true) and ( tbcMailBoxTabCtrl:GetSelIndex() == 1 ) then
		luaMailBox:OnSelectedItemFormInventory( nIndex, nID );
		
	elseif ( frmShop:GetShow() == true)  then

		if ( gamefunc:IsItemSellable( nID) == false)  then  return;
		end
	
		luaInventory:OpenConfirmItemQuantityFrame_ByIndex( luaShop.CallbackOnDropSellItem, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMSELLITEM"), nIndex, true);
	
	elseif( frmRegisterItem:GetShow() == true )	then
		luaMyMarket:OnSelectedItemFromInventory(nIndex, nID);

	elseif( frmTrade:GetShow() == true )	then
		luaInventory:OnSelectedTradeItem( nIndex );
		
	elseif( frmEnchant:GetShow() == true )	then
		luaInventory:OnSelecteEnchantItem( nIndex, nID );

	elseif( frmElementEnchant:GetShow() == true )	then
		luaInventory:OnSelecteElementEnchantItem( nIndex, nID );
	
	elseif( frmStorage:GetShow() == true )	then
		luaStorage:OnSelectedItemFormInventory( nIndex, nID );

	elseif( frmGuildStorage:GetShow() == true )	then
		luaGuildStorage:OnSelectedItemFormInventory( nIndex, nID );

	else
		
		if ( lcExInventory:GetItemText( nCurSel, luaExInventory.COLUMN.EQUIPMENT) == "1")  then		luaExInventory:DoEquipInvenItem( nIndex);
		elseif ( lcExInventory:GetItemText( nCurSel, luaExInventory.COLUMN.USABLE) == "1")  then	luaExInventory:DoUseInvenItem( nIndex);
		end
	end
end


-- OnItemRClickInvenListCtrl
function luaExInventory:OnItemRClickInvenListCtrl()

	luaExInventory:OnItemDblClickInvenListCtrl();
end


-- OnSelChangeInvenListCtrl
function luaExInventory:OnSelChangeInvenListCtrl()

	luaExInventory:RefreshControls();
end





-- OnDragBeginInvenListCtrl
function luaExInventory:OnDragBeginInvenListCtrl()

	DragEventArgs:SetEffect( "add");
	local nItemCount = DragEventArgs:GetItemCount();
	if ( nItemCount <= 0)  then  return false;
	end
	
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return false;
	end
	
	-- 위탁거래소에 등록 중인 아이템 드래그 불가
	if( nIndex == luaMyMarket.RegisterItemSlotID )	then
		return false;
	end
	
	-- 강화 등록중 아이템 드래그 불가
	if( true == luaEnchant:IsSelectedEnchantItem( nIndex ) )	then
		return false;
	end
	
	-- 우편 등록 아이템 드래그 불가
	if( true == luaMailBox:IsAttachedObj( nIndex ) )	then
		return false;
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
function luaExInventory:OnDragEndInvenListCtrl()

	-- Stop dyeing and GemEnchant
	if ( frmDyeing:GetShow() == true)  then		luaDyeing:CloseDyeItem();
	else										luaDyeing:CloseDyeingFrame();
	end

	if ( frmCraftingCostume:GetShow() == true)  then		luaCraftingCostume:CloseCraftingCostumeItem();
	else										luaCraftingCostume:CloseCraftingCostumeFrame();
	end
	
	if ( frmGemEnchant:GetShow() == true)  then	luaGemEnchant:CloseGemEnchantItem();
	else										luaGemEnchant:CloseGemEnchantFrame();
	end
	
	return false;
end





-- OnDropInvenListCtrl
function luaExInventory:OnDropInvenListCtrl()

    local _sender = _G[ DragEventArgs:GetSender():GetName()];
    
    -- Self drop : merge, exchange, dyeing, GemEnchant, CraftingCostume
    local bRetVal = false;
    if ( luaInventory:DropItemCheck(_sender) == true)  then
		
		local nSrcIndex = DragEventArgs:GetItemData( 0);
		local nSrcID = gamefunc:GetInvenItemID( nSrcIndex);

		local nMouseOver = lcExInventory:GetMouseOver();
		if ( nMouseOver >= 0)  then

			local nTarIndex = lcExInventory:GetItemData( nMouseOver);
			local nTarID = gamefunc:GetInvenItemID( nTarIndex);

			-- 위탁 거래소에서 물품 등록중인 아이템일 경우 위치 바꾸기막기
			if( ( nSrcIndex == luaMyMarket.RegisterItemSlotID )	or ( nTarIndex == luaMyMarket.RegisterItemSlotID ) )		then
				return ;
			end
			
			-- 강화 등록중 아이템 위치 바꾸기 막기
			if( ( true == luaEnchant:IsSelectedEnchantItem( nSrcIndex ) ) or ( true == luaEnchant:IsSelectedEnchantItem( nTarIndex ) ) )	then
				return ;
			end

			-- 우편 등록중 아이템 위치 바꾸기 막기
			if( ( true == luaMailBox:IsAttachedObj( nSrcIndex ) ) or ( true == luaMailBox:IsAttachedObj( nTarIndex ) ) )	then
				return ;
			end
	
			if ( nSrcIndex ~= nTarIndex)  then
			
				-- Dyeing
				if ( luaDyeing.m_bDyeing == true)  and  ( gamefunc:GetItemType( nSrcID) == ITEM_TYPE.DYE)  then
				
					bRetVal = luaDyeing:OpenDyeingFrame( luaDyeing.DYE_TYPE.INVENTORY, nTarIndex);

				-- Crafting Costume
				elseif ( luaCraftingCostume.m_bCraftingCostume == true)  and  ( gamefunc:GetItemType( nSrcID) == ITEM_TYPE.USABLE) and (gamefunc:GetItemUsableType( nSrcID) == USABLE_TYPE.CRAFT_COSTUME )  then
				
					bRetVal = luaCraftingCostume:OpenCraftingCostumeFrame( luaCraftingCostume.CRAFTING_COSTUME_TYPE.INVENTORY, nTarIndex);

				-- GemEnchant
				elseif ( luaGemEnchant.m_bGemEnchant == true) then
				
					if(gamefunc:GetItemType( nSrcID) == ITEM_TYPE.GEMENCHANT) or
					  (gamefunc:GetItemType( nSrcID) == ITEM_TYPE.GEMREMOVE)  or
					  (gamefunc:GetItemType( nSrcID) == ITEM_TYPE.GEMEXTRACT) then
						bRetVal = luaGemEnchant:OpenGemEnchantFrame( luaGemEnchant.TARGET_TYPE.INVENTORY, nTarIndex);
					end
					
				-- Merge, exchange
				else
				
					gamefunc:MoveInvenItem( nSrcIndex, nTarIndex);
					bRetVal = true;
				end
					

				lcExInventory:SetCurSel( nTarIndex);
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
	elseif ( _sender == isFaceDeco)  or  ( _sender == isHead)  or  ( _sender == isBody)  or  ( _sender == isHands)  or  ( _sender == isFeet)  or
		   ( _sender == isLeg)  or  ( _sender == isEarring)  or  ( _sender == isNecklace)  or  ( _sender == isRingR)  or  ( _sender == isRingL)  or
		   ( _sender == isWeapon1)  or  ( _sender == isWeapon1Sub)  or  ( _sender == isWeapon2)  or  ( _sender == isWeapon2Sub)  or
		   ( _sender == isLookHead)	 or  ( _sender == isLookBody)  or  ( _sender == isLookHands)  or  ( _sender == isLookLeg)  or  ( _sender == isLookFeet) or
		   ( _sender == isLookWeapon1)  or  ( _sender == isLookWeapon1Sub)  or  ( _sender == isLookWeapon2)  or  ( _sender == isLookWeapon2Sub)  or
		   ( _sender == isLookAccessary) or  ( _sender == isLookBack) or ( _sender == isTalisman) or ( _sender == isBelt) or ( _sender == isLookTitle) then
		   
		luaCharacter:OnDragOutEquippedItemSlot();
		bRetVal = true;
		
	elseif ( _sender == lcStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcExInventory:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcExInventory:GetItemData( nMouseOver);

					luaStorage.nTargetIndex = nTarIndex;

					luaStorage:OpenConfirmItemQuantityFrame( luaExInventory.CallbackOnDropMoveItem, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"));
				
					bRetVal = true;
				end
			end
		end
		
	elseif ( _sender == lcGuildStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetGuildStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcExInventory:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcExInventory:GetItemData( nMouseOver);

					luaGuildStorage.nTargetIndex = nTarIndex;

					luaGuildStorage:OpenConfirmItemQuantityFrame( luaExInventory.CallbackOnDropMoveItemGuild, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"));
				
					bRetVal = true;
				end
			end
		end
	
	elseif ( _sender == lcCashInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
			luaCashShop:OpenCorfirmMovetoInven(nIndex);
		end	
	end
	
	
	return bRetVal;
end





-- Callback functions
function luaExInventory:CallbackOnDropMoveItem(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end

	gamefunc:WithdrawItem(nIndex, luaStorage.nTargetIndex, nQuantity);
end


function luaExInventory:CallbackOnDropMoveItemGuild(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetGuildStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end

	gamefunc:WithdrawGuildItem(nIndex, luaGuildStorage.nTargetIndex, nQuantity);
end





-- OnToolTipInvenListCtrl
function luaExInventory:OnToolTipInvenListCtrl()

	local strToolTip = "";

	local nSel = lcExInventory:GetMouseOver();
	if ( nSel >= 0)  then
	
		local nIndex = lcExInventory:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then

					strToolTip = strToolTip .. "{divide}" ..
								ToolTipDivideColor() .. "< " .. STR( "UI_EQUIPPEDITEM") .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nID);
				end
			end
		end
	end

	lcExInventory:SetToolTip( strToolTip);
end





-- DoUseInvenItem
function luaExInventory:DoUseInvenItem( nIndex)

	if(gamefunc:IsArenaField() == true) then
		luaGame:OnEventChattingMsg( STR( "ARENA_CANNOT_USE_ITEM" ), CHATFILTER_TYPE.SYSTEM );
		return;
	end

	if ( nIndex < 0)  then  return false;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end
	
	local nType = gamefunc:GetItemType( nID);
	local nUsableType = gamefunc:GetItemUsableType( nID);

	if (( nType == ITEM_TYPE.USABLE ) and (nUsableType == USABLE_TYPE.CRAFT_COSTUME ) )	then
	
		luaCraftingCostume:OpenCraftingCostume( nIndex);	
		
	elseif (( nType == ITEM_TYPE.USABLE ) and (nUsableType == USABLE_TYPE.RANDOM_BOX) )	then
	
		local nUsableItem = gamefunc:GetItemIDWithRandomBox( nID);
		if ( true == gamefunc:IsPeriodRemainTime(nUsableItem)) then
			luaExInventory:OpenConfirmPeriodInvenItem(nIndex);
		else
			luaRandomBoxEffect:OpenRandomBox(nIndex);
		end
	
	elseif (( nType == ITEM_TYPE.USABLE ) and (nUsableType == USABLE_TYPE.RENAME))	then
	
		luaChangeName:OnShowfrmChangeName(nIndex);
		
	elseif ( nType == ITEM_TYPE.USABLE)			then		gamefunc:UseInvenItem( nIndex);
	elseif ( nType == ITEM_TYPE.DYE)			then		luaDyeing:OpenDyeItem( nIndex);
	elseif ( nType == ITEM_TYPE.GEMENCHANT ) or
		   ( nType == ITEM_TYPE.GEMREMOVE ) or
		   ( nType == ITEM_TYPE.GEMEXTRACT )	then		luaGemEnchant:OpenGemEnchantItem( nIndex, nType);
	end
end





-- DoEquipInvenItem
function luaExInventory:DoEquipInvenItem( nIndex, nTargetSlot)

	if ( nIndex < 0)  then  return false;
	end

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end

	if ( nTargetSlot == nil) then	nTargetSlot = 0;
	end
	
	-- Check item type
	local nType = gamefunc:GetItemType( nID);
	if ( nType ~= ITEM_TYPE.WEAPON)  and  ( nType ~= ITEM_TYPE.ARMOR)  and  ( nType ~= ITEM_TYPE.LOOK)  then  return;
	end


	-- Check required claim
	if ( frmConfirmClaimInvelItem:GetShow() == false)  then
	
		if ( gamefunc:IsItemRequiredClaim( nID) == true)  and  ( gamefunc:IsInvenItemClaimed( nIndex) == false)  then
		
			if ( nTargetSlot ~= 0) then	btnClaimInvenItemOK:SetUserData( nTargetSlot);
			end
			
			luaExInventory:OpenConfirmClaimInvenItem();	
			return;						
		end
	end
	

	-- Get target slot
	local nSlot = gamefunc:GetItemSlot( nID);
	if ( nSlot == ITEM_SLOT.RFINGER)  and  ( gamefunc:GetEquippedItemID( ITEM_SLOT.RFINGER) > 0)  then  nSlot = ITEM_SLOT.LFINGER;
	end
	
	if ( nTargetSlot ~= 0) then	nSlot = nTargetSlot;
	end
	

	-- Play sound
	local strSound = gamefunc:GetItemPutDownSound( nID);
	gamefunc:PlaySound( strSound);


	-- Equip item
	gamefunc:EquipInvenItem( nSlot, nIndex);
end





-- OnClickFilterInvenItemType
function luaExInventory:OnClickFilterInvenItemTypeMenu( nFilterType, strIconImage, strToolTip)
	
	luaExInventory.m_nFilteringType = nFilterType;
end


function luaExInventory:OnDblClickInvenMoney()

	if( frmTrade:GetShow() == true )	then
		luaExInventory:OpenConfirmMoneyAmountFrame( luaTrade.CallbackDropTradeMoney, gamefunc:GetMyTradeMoney());

	elseif( tbcMailBoxTabCtrl:GetSelIndex() == 1 ) then
		luaExInventory:OpenConfirmMoneyAmountFrame( luaMailBox.CallbackDropSendMailAttachedMoney, luaMailBox.m_Attached.money);

	end

end

function luaExInventory:OnRClickInvenMoney()

	luaExInventory:OnDblClickInvenMoney();

end


-- OnDragBeginMoney
function luaExInventory:OnDragBeginMoney()

	DragEventArgs:AddDragData( STR( "MONEY"), "iconMoney", gamefunc:GetMoney());
	DragEventArgs:SetFont( "fntRegular");
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetHotSpot( 20, 20);
	
	
	-- Play sound
	local strSound = gamefunc:GetMoneyPutUpSound();
	gamefunc:PlaySound( strSound);

	return true;
end






function luaExInventory:OnDropMoney()

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




-- OpenConfirmClaimInvenItem
function luaExInventory:OpenConfirmClaimInvenItem()

	local nCurSel = lcExInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcExInventory:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	luaInventory.Move.nIndex	= nIndex;

	-- Set description
	local strName = gamefunc:GetInvenItemName( nIndex );
	local strImage = gamefunc:GetItemImage( nID);
	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetInvenItemName( nIndex );
	tvwClaimItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwClaimItemDesc:SetToolTip( strToolTip);
	

	-- Show frame
	local x, y = frmConfirmClaimInvelItem:GetParent():GetPosition();
	local w, h = frmConfirmClaimInvelItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmClaimInvelItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmClaimInvelItem:DoModal();
end





-- OnValueChangedConfirmItemQuantity
function luaExInventory:OnValueChangedConfirmItemQuantity()

	local nCurSel = lcExInventory:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcExInventory:GetItemData( nCurSel);
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
	if ( luaExInventory.m_bConfirmItemQuantityToShop == true)  then
	
		local nPrice = gamefunc:GetInvenItemSellCost( nIndex) * tonumber( edtConfirmItemQuantity:GetText());
		local strString = "{COLUMN h=23}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}{BITMAP name=\"iconCoin\" w=18 h=18}" .. luaGame:ConvertMoneyToStr( nPrice, "fntSmall");
		tvwConfirmItemPriceDesc:SetText( strString);
	end
end






















-- OpenConfirmMoneyAmountFrame
function luaExInventory:OpenConfirmMoneyAmountFrame( callbackFunc, nDefaultMoney)

	if ( callbackFunc == nil)  then  return;
	end
	
	
	nDefaultMoney = nDefaultMoney or 0;
	
	
	
	-- Set callback function
	luaExInventory.m_cbConfirmMoneyAmount = callbackFunc;

	
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
end





-- ClosConfirmMoneyAmountFrame
function luaExInventory:ClosConfirmMoneyAmountFrame()

	luaExInventory.m_cbConfirmMoneyAmount = nil;
	
	frmConfirmMoneyAmount:Show( false);
	
	luaExInventory:RefreshControls();
end





-- OnValueChangedConfirmMoneyAmountGold
function luaExInventory:OnValueChangedConfirmMoneyAmountGold()

	local strText = edtConfirmMoneyAmountGold:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmMoneyAmountGold:SetText( "0");
		edtConfirmMoneyAmountGold:SetSel( 0, edtConfirmMoneyAmountGold:GetLength());

	elseif ( tonumber( strText) > luaExInventory.nConfirmMoneyAmountGold )  then

		edtConfirmMoneyAmountGold:SetText( luaExInventory.nConfirmMoneyAmountGold );
		edtConfirmMoneyAmountGold:SetSel( 0, edtConfirmMoneyAmountGold:GetLength() );
		edtConfirmMoneyAmountSilver:SetText( "0" );
		edtConfirmMoneyAmountCopper:SetText( "0" );
	end
end





-- OnValueChangedConfirmMoneyAmountSilver
function luaExInventory:OnValueChangedConfirmMoneyAmountSilver()

	local strText = edtConfirmMoneyAmountGold:GetText();
	if( ( nil ~= strText ) and ( luaExInventory.nConfirmMoneyAmountGold <= tonumber( strText ) ) )	then
		edtConfirmMoneyAmountSilver:SetText( "0" );
		edtConfirmMoneyAmountSilver:SetSel( 0, edtConfirmMoneyAmountSilver:GetLength() );
		return ;
	end
	
	strText = edtConfirmMoneyAmountSilver:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmMoneyAmountSilver:SetText( "0");
		edtConfirmMoneyAmountSilver:SetSel( 0, edtConfirmMoneyAmountSilver:GetLength());
		
	elseif ( tonumber( strText) >= 100)  then

		edtConfirmMoneyAmountSilver:SetText( "99");
		edtConfirmMoneyAmountSilver:SetSel( 0, edtConfirmMoneyAmountSilver:GetLength());
	end
end





-- OnValueChangedConfirmMoneyAmountCopper
function luaExInventory:OnValueChangedConfirmMoneyAmountCopper()

	local strText = edtConfirmMoneyAmountGold:GetText();
	if( ( nil ~= strText ) and ( luaExInventory.nConfirmMoneyAmountGold <= tonumber( strText ) ) )	then
		edtConfirmMoneyAmountCopper:SetText( "0" );
		edtConfirmMoneyAmountCopper:SetSel( 0, edtConfirmMoneyAmountCopper:GetLength() );
		return ;
	end
	
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
function luaExInventory:DoConfirmMoneyAmount()

	if ( luaExInventory.m_cbConfirmMoneyAmount ~= nil)  then

		local _gold = tonumber( edtConfirmMoneyAmountGold:GetText());
		local _silver = tonumber( edtConfirmMoneyAmountSilver:GetText());
		local _copper = tonumber( edtConfirmMoneyAmountCopper:GetText());
		
		local nMoney = _gold * 10000  +  _silver * 100  +  _copper;
		
		luaExInventory:m_cbConfirmMoneyAmount( nMoney);


		-- Play sound
		local strSound = gamefunc:GetMoneyPutDownSound();
		gamefunc:PlaySound( strSound);
	end


	luaExInventory:ClosConfirmMoneyAmountFrame();
end




function luaExInventory:CreateQuestMessage()

	for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do

		local nID = gamefunc:GetInvenItemID( i);
		if ( nID >= 0)  then

			local bQuestUsable = gamefunc:IsMessagePopupItem(nID);
			if( bQuestUsable == true ) then
				--gamedebug:Log( "nID : " .. nID );
				luaGame:OnEventQuest( "ADDITEM", nID, gamefunc:GetInvenItemQuantity( i ) )
			end
		
		end
	end

end


function luaExInventory:DeleteQuestMessage(nID, nAmount)

	local bQuestUsable = gamefunc:IsMessagePopupItem(nID);
	if( bQuestUsable == true ) then

		local bHaveItem = false;
		for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do

			local nInvenItemID = gamefunc:GetInvenItemID( i);
			if( nID == nInvenItemID ) then
				bHaveItem = true;
			end
		end

		if( bHaveItem == false ) then
			luaMessageBox:DeleteMessageBoxType( "quest" );
		end
	end

end




function luaExInventory:UseQuestItem( nItemID )

	for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do

		local nID = gamefunc:GetInvenItemID( i);
		if ( nID == nItemID )  then

			luaExInventory:DoUseInvenItem( i );

		end
	end

end




function luaExInventory:GetInventoryEmptyIndex()

	for  i = 0, (gamefunc:GetInvenItemMaxCount() - 1)  do

		local nID = gamefunc:GetInvenItemID( i);
		if ( nID <= 0)  then	return i; end
	end
	
	return -1;
end



function luaExInventory:OnSelectedItemFromStorage( nIndex, nID )

	local nTargetIndex = luaExInventory:GetInventoryEmptyIndex()
	if ( nTargetIndex > -1)  then
	
		luaStorage.nTargetIndex = nTargetIndex;
		luaStorage:OpenConfirmItemQuantityFrame_ByIndex( luaExInventory.CallbackOnDropMoveItem, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"), nIndex);
	end
end



function luaExInventory:OnSelectedItemFromGuildStorage( nIndex, nID )

	local nTargetIndex = luaExInventory:GetInventoryEmptyIndex()
	if ( nTargetIndex > -1)  then
	
		luaGuildStorage.nTargetIndex = nTargetIndex;
		luaGuildStorage:OpenConfirmItemQuantityFrame_ByIndex( luaExInventory.CallbackOnDropMoveItemGuild, STR( "UI_CONFIRM"), STR( "UI_INVEN_CONFIRMMOVETOINVEN"), nIndex);
	end
end

function luaExInventory:OnClickbtnArrangeInventory()
	
	-- 인벤 정리 요청
	gamefunc:PlaySound( "item_universal_down" );
	
	gamefunc:ArrangeInventory(1);
	
end

function luaExInventory:OnTimerArrangeInventory()
	
	btnArrangeExInventory:Enable( gamefunc:IsExInventory() );
	btnArrangeExInventory:KillTimer();
	luaExInventory.nArrangeStartTime = 0;
	
end

function luaExInventory:UnableArrange()
	
	btnArrangeExInventory:Enable( false );
	btnArrangeExInventory:SetTimer( luaExInventory.nArrangeTime, 0 );
	luaExInventory.nArrangeStartTime = gamefunc:GetUpdateTime();
end




function luaExInventory:OnRefleshArrangeInventoryToolTip()
	
	if( true == btnArrangeExInventory:GetEnable() or
		luaExInventory.nArrangeStartTime == 0	)	then
	
		btnArrangeExInventory:SetToolTip( STR( "UI_INVEN_ARRANGE_ENABLE" ) );
	
	else
	
		local nTime = luaExInventory.nArrangeTime - (gamefunc:GetUpdateTime() - luaExInventory.nArrangeStartTime);
		nTime = math.floor(nTime * 0.001);
		local strTime = FORMAT( "UI_INVEN_ARRANGE_COOLTIME", nTime + 1);
		btnArrangeExInventory:SetToolTip(strTime);
		btnArrangeExInventory:ModifyToolTip();
	
	end
	
end

function luaExInventory:OnUserArgument()
	
	local arg = EventArgs:GetUserArgument();
	if ( arg == "RESTORE_UI")  then

        luaGame:RestoreUIPosition( frmExInventory);

        if ( gamefunc:GetAccountParam( "frmExInventory", "hold") ~= nil)  then  btnHoldExInventory:SetCheck( true);
        end

        local _tab = gamefunc:GetAccountParam( "frmExInventory", "tab")  or  0;
        tbcExInvenTypeFilter:SetSelIndex( _tab);

    elseif ( arg == "RECORD_UI")  then

        luaGame:RecordUIPosition( frmExInventory);

        if ( btnHoldExInventory:GetCheck() == true)  then  gamefunc:SetAccountParam( "frmExInventory", "hold", "1");
        end

        gamefunc:SetAccountParam( "frmExInventory", "tab", tbcExInvenTypeFilter:GetSelIndex());
    
    elseif ( arg == "RESET_UI")  then
    
		luaExInventory:ResetUI();
    
    end
        
end



function luaExInventory:ResetUI()
	
	frmExInventory:SetPosition( luaExInventory.nDefaultX, luaExInventory.nDefaultY );
	btnHoldExInventory:SetCheck( false );
	
end



function luaExInventory:OpenConfirmPeriodInvenItem(nIndex)

	if ( nIndex < 0)  then  return false;
	end

	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end


	btnPeriodInvenItemOK:SetUserData( nIndex);
	
	local x, y = frmConfirmPeriodInvenItem:GetParent():GetPosition();
	local w, h = frmConfirmPeriodInvenItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmPeriodInvenItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmPeriodInvenItem:DoModal();
end



function luaExInventory:CloseConfirmPeriodInvenItem()

	btnPeriodInvenItemOK:SetUserData(0);
	frmConfirmPeriodInvenItem:Show(false);
end




function luaExInventory:OnPeriodInvenItemOK()

	local nIndex = btnPeriodInvenItemOK:GetUserData();
	luaRandomBoxEffect:OpenRandomBox(nIndex);
end
