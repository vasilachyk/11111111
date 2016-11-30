--[[
	Game guild storage LUA script
--]]


-- Global instance
luaGuildStorage = {};

luaGuildStorage.nTargetIndex = 0;
luaGuildStorage.m_cbConfirmItemQuantity = nil;


function luaGuildStorage:OnShowFrame()

	-- Show
	if ( frmGuildStorage:GetShow() == true)  then
	
		frmInventory:Show( true);
		luaGuildStorage:Refresh();
		
	-- Hide
	else
	
		frmInventory:Show( false);
	
		-- Clear all flags of new item
		--gamefunc:ClearAllInvenNewItemFlag();
	end
	
	
	luaGame:ShowWindow( frmGuildStorage);
end





function luaGuildStorage:Refresh()

	if ( frmGuildStorage:GetShow() == false)  then  return;
	end

	-- Refresh UI
	luaGuildStorage:RefreshList();
	luaGuildStorage:RefreshMoney();
	luaGuildStorage:RefreshControls();
end





function luaGuildStorage:RefreshList()

	if ( frmGuildStorage:GetShow() == false)  then  return;
	end

	local nCurSel = lcGuildStorage:GetCurSel();
	
	lcGuildStorage:DeleteAllItems();

	for  i = 0, (gamefunc:GetGuildStorageItemMaxCount() - 1)  do

		local nID = gamefunc:GetGuildStorageItemID( i);
		if ( nID <= 0)  then
		
			local nIndex = lcGuildStorage:AddItem( "", "");
			lcGuildStorage:SetItemData( nIndex, i);
			
		else
				
			local nType = gamefunc:GetItemType( nID);
			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
			end
			
			local nQuantity = gamefunc:GetGuildStorageItemQuantity( i);
			
			local nType = gamefunc:GetItemType( nID);
			local nItemType = luaInventory.FILTER_TYPE.NONE;
			if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then										nItemType = luaInventory.FILTER_TYPE.EQUIPMENT;
			elseif ( nType == ITEM_TYPE.USABLE)  or  ( nType == ITEM_TYPE.ENCHANT)  or ( nType == ITEM_TYPE.DYE)  then	nItemType = luaInventory.FILTER_TYPE.USABLE;
			end
			

			-- Add list item
			local nIndex = lcGuildStorage:AddItem( strName, strImage);
			lcGuildStorage:SetItemText( nIndex, 1, nQuantity);
			lcGuildStorage:SetItemText( nIndex, 2, nItemType);
			lcGuildStorage:SetItemData( nIndex, i);
		end
	end
	
	lcGuildStorage:SetCurSel( nCurSel);
	
	
	-- Item count
	labGuildStorageItemCount:SetText( gamefunc:GetGuildStorageItemCount() .. " / " .. gamefunc:GetGuildStorageItemMaxCount());
end





function luaGuildStorage:RefreshMoney()

	if ( frmGuildStorage:GetShow() == false)  then  return;
	end
	
	local nMoney = gamefunc:GetGuildStorageMoney();

	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( nMoney, "fntSmall") .. "{SPACE w=10}";
	tvwGuildStorageMoney:SetText( strMoney);
end





function luaGuildStorage:RefreshControls()
end





function luaGuildStorage:OnDrawItemListCtrl()
	local x, y, w, h = EventArgs:GetItemRect();
	
	-- Draw glass pannel	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local nSlotID = EventArgs:GetItemIndex();
	local nID = gamefunc:GetGuildStorageItemID( nSlotID);
	if ( nID <= 0)  then  return
	end
	
	-- Draw quantity
	local nQuantity = tonumber( lcGuildStorage:GetItemText( nSlotID, 1));
	if ( nQuantity > 1)  then

		gamedraw:SetColor( 210, 210, 210);
		gamedraw:SetFont( "fntScriptStrong");
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( x, y, w - 1, h - 1, nQuantity);
	end
end






function luaGuildStorage:OnItemRClickListCtrl()
end





function luaGuildStorage:OnItemDblClickListCtrl()
end





function luaGuildStorage:OnSelChangeListCtrl()
end





function luaGuildStorage:OnDragBeginListCtrl()

	local nItemCount = DragEventArgs:GetItemCount();
	if ( nItemCount <= 0)  then  return false;
	end
	
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return false;
	end
	
	local nID = gamefunc:GetGuildStorageItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end
	
	
	-- Play sound
	local strSound = gamefunc:GetItemPutUpSound( nID);
	gamefunc:PlaySound( strSound);
	
	return true;
end





function luaGuildStorage:OnDragEndListCtrl()
end





function luaGuildStorage:OnDropListCtrl()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end
	
	
	local bRetVal = false;

	-- Inventory item
	if ( _sender == lcGuildStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetGuildStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcGuildStorage:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcGuildStorage:GetItemData( nMouseOver);

					gamefunc:MoveGuildStorageItem(nIndex, nTarIndex);
				
					bRetVal = true;
				end
			end
		end
	
	elseif ( _sender == lcInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcGuildStorage:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcGuildStorage:GetItemData( nMouseOver);

					luaGuildStorage.nTargetIndex = nTarIndex;

					luaInventory:OpenConfirmItemQuantityFrame( luaGuildStorage.CallbackOnDropMoveItem, "아이템 이동 확인", "다음의 아이템을 길드보관함으로 이동하시겠습니까?", false);

					bRetVal = true;
				end
			end
		end
	end
	
end





function luaGuildStorage:CallbackOnDropMoveItem(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	gamefunc:DepositGuildItem(nIndex, luaGuildStorage.nTargetIndex, nQuantity);	
end





function luaGuildStorage:OnToolTipListCtrl()


	local strToolTip = "";

	local nSel = lcGuildStorage:GetMouseOver();
	if ( nSel >= 0)  then
	
		local nIndex = lcGuildStorage:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nID = gamefunc:GetGuildStorageItemID( nIndex);
			if ( nID > 0)  then

				strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
				
				local nSlotType = gamefunc:GetItemSlot( nID);
				if ( nSlotType ~= ITEM_SLOT.NONE)  and  ( gamefunc:GetEquippedItemID( nSlotType) > 0)  then

					strToolTip = "{COLOR r=100 g=160 b=100}< " .. "선택한 아이템" .. " >{/COLOR}\n" .. strToolTip .. "{divide}" ..
						"{COLOR r=100 g=160 b=100}< " .. "장착하고 있는 아이템" .. " >{/COLOR}\n" .. luaToolTip:OnToolTipEquipItem( nID);
				end
			end
		end
	end

	lcGuildStorage:SetToolTip( strToolTip);
	
end




function luaGuildStorage:OnDragBeginMoney()

	DragEventArgs:AddDragData( "길드보관금액", "iconMoney", gamefunc:GetGuildStorageMoney());
	DragEventArgs:SetFont( "fntRegular");
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetHotSpot( 20, 20);
	
	
	-- Play sound
	local strSound = gamefunc:GetMoneyPutUpSound();
	gamefunc:PlaySound( strSound);

	return true;
end




function luaGuildStorage:OnDropMoney()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end

	local bRetVal = false;

	if ( _sender == tvwMoney)  then
	
		luaInventory:OpenConfirmMoneyAmountFrame( luaGuildStorage.CallbackDropMoney, gamefunc:GetMoney());
		
		bRetVal = true;
	end
	

	return bRetVal;
end




function luaGuildStorage:CallbackDropMoney( nMoney)

	nMoney = math.min( nMoney, gamefunc:GetMoney());

	gamefunc:DepositGuildMoney(nMoney);
end





function luaGuildStorage:CallbackDropWithdrawMoney( nMoney)

	nMoney = math.min( nMoney, gamefunc:GetGuildStorageMoney());

	gamefunc:WithdrawGuildMoney(nMoney);
end





function luaGuildStorage:OpenConfirmMoneyAmountFrame( callbackFunc, nDefaultMoney)

	if ( callbackFunc == nil)  then  return;
	end
	
	
	nDefaultMoney = nDefaultMoney or 0;
	
	
	
	-- Set callback function
	luaInventory.m_cbConfirmMoneyAmount = callbackFunc;

	
	-- Set message and tooltip
	local strMoney = luaGame:ConvertMoneyToStr( gamefunc:GetGuildStorageMoney(), "fntSmall");
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"iconMoney\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. "보관금액" .. "{/COLOR}{/FONT}{CR h=23}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" ..
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
	
	
	--btnDropStorageItem:Enable( false);
end




-- OpenConfirmItemQuantityFrame
function luaGuildStorage:OpenConfirmItemQuantityFrame(callbackFunc, strTitle, strMessage)

   	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return;
	end

	luaGuildStorage:OpenConfirmItemQuantityFrame_ByIndex(callbackFunc, strTitle, strMessage, nIndex)

end





function luaGuildStorage:OpenConfirmItemQuantityFrame_ByIndex(callbackFunc, strTitle, strMessage, nIndex)

	local nID = gamefunc:GetGuildStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	if ( callbackFunc == nil)  then  return;
	end
	

	-- Set variables
	luaGuildStorage.m_cbConfirmItemQuantity = callbackFunc;


	-- Direct call
	local nQuantity = gamefunc:GetGuildStorageItemQuantity( nIndex);
	if ( nQuantity == 1)  then

		luaGuildStorage:m_cbConfirmItemQuantity( nIndex, nQuantity);
		
		
		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( nID);
		gamefunc:PlaySound( strSound);
		
		return;
	end
		

	-- Set title and message
	frmConfirmGuildStorageItemQuantity:SetText( strTitle);
	tvwConfirmGuildStorageItemQuantityMessage:SetText( strMessage);


	-- Set message and tooltip
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) .. "{/COLOR}{/FONT}{CR h=23}" ..
		"{FONT name=\"fntScript\"}" .. "수량" .. " : " .. nQuantity;
	tvwConfirmGuildStorageItemQuantityDesc:SetText( strString);

	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwConfirmGuildStorageItemQuantityDesc:SetToolTip( strToolTip);
	
	
	-- Initialize quantity edit
	edtConfirmGuildStorageItemQuantity:SetText( nQuantity);
	
	-- Show frame
	local x, y = frmConfirmGuildStorageItemQuantity:GetParent():GetPosition();
	local w, h = frmConfirmGuildStorageItemQuantity:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmGuildStorageItemQuantity:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmGuildStorageItemQuantity:DoModal();
	

	-- Set focus	
	edtConfirmGuildStorageItemQuantity:SetFocus();
	edtConfirmGuildStorageItemQuantity:SetSel( 0, edtConfirmGuildStorageItemQuantity:GetLength());

end






-- DoConfirmItemQuantity
function luaGuildStorage:DoConfirmItemQuantity()

	local nCurSel = lcGuildStorage:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcGuildStorage:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetGuildStorageItemID( nIndex);
			if ( nID > 0)  then
		
				if ( luaGuildStorage.m_cbConfirmItemQuantity ~= nil)  then

					local nQuantity = tonumber( edtConfirmGuildStorageItemQuantity:GetText());

					luaGuildStorage:m_cbConfirmItemQuantity( nIndex, nQuantity);
					
					
					-- Play sound
					local strSound = gamefunc:GetItemPutDownSound( nID);
					gamefunc:PlaySound( strSound);
				end
			end
		end
	end


	luaGuildStorage:CloseConfirmItemQuantityFrame();
end





function luaGuildStorage:CloseConfirmItemQuantityFrame()

	frmConfirmGuildStorageItemQuantity:Show( false);
	
	luaGuildStorage:RefreshControls();
end




function luaGuildStorage:OnValueChangedConfirmItemQuantity()

	local nCurSel = lcGuildStorage:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcGuildStorage:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end

	local nMaxQuantity = gamefunc:GetGuildStorageItemQuantity( nIndex);
	
	local strText = edtConfirmGuildStorageItemQuantity:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmGuildStorageItemQuantity:SetText( "1");
		edtConfirmGuildStorageItemQuantity:SetSel( 0, edtConfirmGuildStorageItemQuantity:GetLength());

	else
	
		local nQuantity = tonumber( strText);
		if ( nQuantity < 1)  then
			
			edtConfirmGuildStorageItemQuantity:SetText( "1");
			edtConfirmGuildStorageItemQuantity:SetSel( 0, edtConfirmGuildStorageItemQuantity:GetLength());

		elseif ( nQuantity > nMaxQuantity)  then

			edtConfirmGuildStorageItemQuantity:SetText( tostring( nMaxQuantity));
			edtConfirmGuildStorageItemQuantity:SetSel( 0, edtConfirmGuildStorageItemQuantity:GetLength());
		end
	end
end
