--[[
	Game storage LUA script
--]]


-- Global instance
luaStorage = {};

luaStorage.nTargetIndex = 0;
luaStorage.m_cbConfirmItemQuantity = nil;



function luaStorage:OnShowFrame()

	-- Show
	if ( frmStorage:GetShow() == true)  then
	
		local nCount = gamefunc:GetStorageItemMaxCount();
		if ( nCount == 40) then
			lcStorage:SetSize(336, 232);
		
		elseif ( nCount == 80) then
			lcStorage:SetSize(336, 464);
		end
	
	
		frmInventory:Show( true);
		luaStorage:Refresh();
		
	-- Hide
	else
	
		frmInventory:Show( false);
	
		-- Clear all flags of new item
		--gamefunc:ClearAllInvenNewItemFlag();
	end
	
	
	luaGame:ShowWindow( frmStorage);

end





function luaStorage:Refresh()

	if ( frmStorage:GetShow() == false)  then  return;
	end

	-- Refresh UI
	luaStorage:RefreshList();
	luaStorage:RefreshMoney();
	luaStorage:RefreshControls();
end






function luaStorage:RefreshList()

	if ( frmStorage:GetShow() == false)  then  return;
	end

	local nCurSel = lcStorage:GetCurSel();
	
	lcStorage:DeleteAllItems();

	for  i = 0, (gamefunc:GetStorageItemMaxCount() - 1)  do

		local nID = gamefunc:GetStorageItemID( i);
		if ( nID <= 0)  then
		
			local nIndex = lcStorage:AddItem( "", "");
			lcStorage:SetItemData( nIndex, i);
			
		else
				
			local nType = gamefunc:GetItemType( nID);
			local strName = gamefunc:GetItemName( nID);
			local strImage = gamefunc:GetItemImage( nID);
			if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
			end
			
			local nQuantity = gamefunc:GetStorageItemQuantity( i);
			
			local nType = gamefunc:GetItemType( nID);
			local nItemType = luaInventory.FILTER_TYPE.NONE;
			if ( nType == ITEM_TYPE.WEAPON)  or  ( nType == ITEM_TYPE.ARMOR)  then										nItemType = luaInventory.FILTER_TYPE.EQUIPMENT;
			elseif ( nType == ITEM_TYPE.USABLE)  or  ( nType == ITEM_TYPE.ENCHANT)  or ( nType == ITEM_TYPE.DYE)  then	nItemType = luaInventory.FILTER_TYPE.USABLE;
			end
			

			-- Add list item
			local nIndex = lcStorage:AddItem( strName, strImage);
			lcStorage:SetItemText( nIndex, 1, nQuantity);
			lcStorage:SetItemText( nIndex, 2, nItemType);
			lcStorage:SetItemData( nIndex, i);
		end
	end
	
	lcStorage:SetCurSel( nCurSel);
	
	
	-- Item count
	labStorageItemCount:SetText( gamefunc:GetStorageItemCount() .. " / " .. gamefunc:GetStorageItemMaxCount());
end





function luaStorage:RefreshMoney()

	if ( frmStorage:GetShow() == false)  then  return;
	end
	
	local nMoney = gamefunc:GetStorageMoney();

	local strMoney = "{FONT name=\"fntBold\"}{COLUMN h=22}{ALIGN hor=\"right\" ver=\"bottom\"}" .. luaGame:ConvertMoneyToStr( nMoney, "fntSmall") .. "{SPACE w=10}";
	tvwStorageMoney:SetText( strMoney);
end





function luaStorage:RefreshControls()

	if ( frmStorage:GetShow() == false)  then  return;
	end

	local bEnable = false;
	local nCurSel = lcStorage:GetCurSel();
	if ( nCurSel >= 0)  then
		
		local nIndex = lcStorage:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
			
			local nID = gamefunc:GetStorageItemID( nIndex);
			if ( nID > 0)  then

				bEnable = true;
			end
		end
	end
	
	btnDropStorageItem:Enable( bEnable);
end




function luaStorage:OnDrawItemListCtrl()

	local x, y, w, h = EventArgs:GetItemRect();
	
	-- Draw glass pannel	
	gamedraw:SetBitmap( "bmpGlassPanel");
	gamedraw:Draw( x, y, w, h);


	local nSlotID = EventArgs:GetItemIndex();
	local nID = gamefunc:GetStorageItemID( nSlotID);
	if ( nID <= 0)  then  return
	end
	
	-- Draw quantity
	local nQuantity = tonumber( lcStorage:GetItemText( nSlotID, 1));
	if ( nQuantity > 1)  then

		gamedraw:SetColor( 210, 210, 210);
		gamedraw:SetFont( "fntScriptStrong");
		gamedraw:SetTextAlign( "right", "bottom");
		gamedraw:TextEx( x, y, w - 1, h - 1, nQuantity);
	end
end






function luaStorage:OnItemRClickListCtrl()
end





function luaStorage:OnItemDblClickListCtrl()
end





function luaStorage:OnSelChangeListCtrl()

	luaStorage:RefreshControls();
end





function luaStorage:OnDragBeginListCtrl()

	local nItemCount = DragEventArgs:GetItemCount();
	if ( nItemCount <= 0)  then  return false;
	end
	
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return false;
	end
	
	local nID = gamefunc:GetStorageItemID( nIndex);
	if ( nID <= 0)  then  return false;
	end
	
	
	-- Play sound
	local strSound = gamefunc:GetItemPutUpSound( nID);
	gamefunc:PlaySound( strSound);
	
	return true;
end





function luaStorage:OnDragEndListCtrl()
end





function luaStorage:OnDropListCtrl()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end
	
	
	local bRetVal = false;

	-- Inventory item
	if ( _sender == lcStorage)  then

		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetStorageItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcStorage:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcStorage:GetItemData( nMouseOver);

					gamefunc:MoveStorageItem(nIndex, nTarIndex);
				
					bRetVal = true;
				end
			end
		end
	
	elseif ( _sender == lcInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
			
				local nMouseOver = lcStorage:GetMouseOver();
				if ( nMouseOver >= 0)  then
					local nTarIndex = lcStorage:GetItemData( nMouseOver);

					luaStorage.nTargetIndex = nTarIndex;

					luaInventory:OpenConfirmItemQuantityFrame( luaStorage.CallbackOnDropMoveItem, "아이템 이동 확인", "다음의 아이템을 보관함으로 이동하시겠습니까?", false);

					bRetVal = true;
				end
			end
		end
	end
	
end



function luaStorage:CallbackOnDropMoveItem(nIndex, nQuantity)

	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetInvenItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	gamefunc:DepositItem(nIndex, luaStorage.nTargetIndex, nQuantity);	
end


function luaStorage:OnToolTipListCtrl()

	local strToolTip = "";

	local nSel = lcStorage:GetMouseOver();
	if ( nSel >= 0)  then
	
		local nIndex = lcStorage:GetItemData( nSel);
		if ( nIndex >= 0)  then

			local nID = gamefunc:GetStorageItemID( nIndex);
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

	lcStorage:SetToolTip( strToolTip);
end









function luaStorage:OnDragBeginMoney()

	DragEventArgs:AddDragData( "보관금액", "iconMoney", gamefunc:GetMoney());
	DragEventArgs:SetFont( "fntRegular");
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetHotSpot( 20, 20);
	
	
	-- Play sound
	local strSound = gamefunc:GetMoneyPutUpSound();
	gamefunc:PlaySound( strSound);

	return true;
end





-- CallbackDrop
function luaStorage:CallbackDropMoney( nMoney)

	nMoney = math.min( nMoney, gamefunc:GetMoney());

	gamefunc:DepositMoney(nMoney);
end



function luaStorage:CallbackDropWithdrawMoney( nMoney)

	nMoney = math.min( nMoney, gamefunc:GetStorageMoney());

	gamefunc:WithdrawMoney(nMoney);
end



function luaStorage:OnDropMoney()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	if ( _sender == nil)  then  return false;
	end

	local bRetVal = false;

	if ( _sender == tvwMoney)  then
	
		luaInventory:OpenConfirmMoneyAmountFrame( luaStorage.CallbackDropMoney, gamefunc:GetMoney());
		
		bRetVal = true;
	end
	

	return bRetVal;
end





function luaStorage:OpenConfirmMoneyAmountFrame( callbackFunc, nDefaultMoney)

	if ( callbackFunc == nil)  then  return;
	end
	
	
	nDefaultMoney = nDefaultMoney or 0;
	
	
	
	-- Set callback function
	luaInventory.m_cbConfirmMoneyAmount = callbackFunc;

	
	-- Set message and tooltip
	local strMoney = luaGame:ConvertMoneyToStr( gamefunc:GetStorageMoney(), "fntSmall");
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
	
	
	btnDropStorageItem:Enable( false);
end






function luaStorage:OpenConfirmDropItem()

	local nCurSel = lcStorage:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcStorage:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end
	
	local nID = gamefunc:GetStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	

	-- Set description
	local strText = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) ..
		"{/COLOR}{/FONT}{CR}{FONT name=\"fntScript\"}{COLOR r=80 g=130 b=130}" .. "수량" .. " : " .. gamefunc:GetStorageItemQuantity( nIndex);
	tvwStorageDropItemDesc:SetText( strText);
	
	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwStorageDropItemDesc:SetToolTip( strToolTip);
	

	-- Show frame
	local x, y = frmConfirmDropStorageItem:GetParent():GetPosition();
	local w, h = frmConfirmDropStorageItem:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmDropStorageItem:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmDropStorageItem:DoModal();
	
	
	btnDropStorageItem:Enable( false);
end


-- 버리기
function luaStorage:OnDropStorageItemOK()

	local nCurSel = lcStorage:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcStorage:GetItemData( nCurSel);
		if ( nIndex >= 0)  then  gamefunc:DropStorageItem( nIndex);
		end
		

		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( gamefunc:GetStorageItemID( nIndex));
		gamefunc:PlaySound( strSound);
	end

	luaStorage:CloseConfirmDropStorageItem();
end



function luaStorage:CloseConfirmDropStorageItem()
	frmConfirmDropStorageItem:Show( false);
	
	luaStorage:RefreshControls();
end





-- OpenConfirmItemQuantityFrame
function luaStorage:OpenConfirmItemQuantityFrame(callbackFunc, strTitle, strMessage)

   	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex < 0)  then  return;
	end

	luaStorage:OpenConfirmItemQuantityFrame_ByIndex(callbackFunc, strTitle, strMessage, nIndex)

end


function luaStorage:OpenConfirmItemQuantityFrame_ByIndex(callbackFunc, strTitle, strMessage, nIndex)

	local nID = gamefunc:GetStorageItemID( nIndex);
	if ( nID <= 0)  then  return;
	end
	
	if ( callbackFunc == nil)  then  return;
	end
	

	-- Set variables
	luaStorage.m_cbConfirmItemQuantity = callbackFunc;


	-- Direct call
	local nQuantity = gamefunc:GetStorageItemQuantity( nIndex);
	if ( nQuantity == 1)  then

		luaStorage:m_cbConfirmItemQuantity( nIndex, nQuantity);
		
		
		-- Play sound
		local strSound = gamefunc:GetItemPutDownSound( nID);
		gamefunc:PlaySound( strSound);
		
		return;
	end
		

	-- Set title and message
	frmConfirmStorageItemQuantity:SetText( strTitle);
	tvwConfirmStorageItemQuantityMessage:SetText( strMessage);


	-- Set message and tooltip
	local strString = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}{SPACE w=1}{BITMAP name=\"" .. gamefunc:GetItemImage( nID) .. "\" w=40 h=40}{CR h=0}" .. 
		"{INDENT dent=45}{FONT name=\"fntRegular\"}{COLOR r=160 g=160 b=160}" .. gamefunc:GetItemName( nID) .. "{/COLOR}{/FONT}{CR h=23}" ..
		"{FONT name=\"fntScript\"}" .. "수량" .. " : " .. nQuantity;
	tvwConfirmStorageItemQuantityDesc:SetText( strString);

	local strToolTip = luaToolTip:GetItemToolTip( nID, nIndex, nil);
	tvwConfirmStorageItemQuantityDesc:SetToolTip( strToolTip);
	
	
	-- Initialize quantity edit
	edtConfirmStorageItemQuantity:SetText( nQuantity);
	
	-- Show frame
	local x, y = frmConfirmStorageItemQuantity:GetParent():GetPosition();
	local w, h = frmConfirmStorageItemQuantity:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmStorageItemQuantity:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmConfirmStorageItemQuantity:DoModal();
	

	-- Set focus	
	edtConfirmStorageItemQuantity:SetFocus();
	edtConfirmStorageItemQuantity:SetSel( 0, edtConfirmStorageItemQuantity:GetLength());


	btnDropStorageItem:Enable( false);
end





-- DoConfirmItemQuantity
function luaStorage:DoConfirmItemQuantity()

	local nCurSel = lcStorage:GetCurSel();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcStorage:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetStorageItemID( nIndex);
			if ( nID > 0)  then
		
				if ( luaStorage.m_cbConfirmItemQuantity ~= nil)  then

					local nQuantity = tonumber( edtConfirmStorageItemQuantity:GetText());

					luaStorage:m_cbConfirmItemQuantity( nIndex, nQuantity);
					
					
					-- Play sound
					local strSound = gamefunc:GetItemPutDownSound( nID);
					gamefunc:PlaySound( strSound);
				end
			end
		end
	end


	luaStorage:CloseConfirmItemQuantityFrame();
end





function luaStorage:CloseConfirmItemQuantityFrame()

	frmConfirmStorageItemQuantity:Show( false);
	
	luaStorage:RefreshControls();
end




function luaStorage:OnValueChangedConfirmItemQuantity()

	local nCurSel = lcStorage:GetCurSel();
	if ( nCurSel < 0)  then  return;
	end
	
	local nIndex = lcStorage:GetItemData( nCurSel);
	if ( nIndex < 0)  then  return;
	end

	local nMaxQuantity = gamefunc:GetStorageItemQuantity( nIndex);
	
	local strText = edtConfirmStorageItemQuantity:GetText();
	if ( strText == nil)  or  ( strText == "")  then
	
		edtConfirmStorageItemQuantity:SetText( "1");
		edtConfirmStorageItemQuantity:SetSel( 0, edtConfirmStorageItemQuantity:GetLength());

	else
	
		local nQuantity = tonumber( strText);
		if ( nQuantity < 1)  then
			
			edtConfirmStorageItemQuantity:SetText( "1");
			edtConfirmStorageItemQuantity:SetSel( 0, edtConfirmStorageItemQuantity:GetLength());

		elseif ( nQuantity > nMaxQuantity)  then

			edtConfirmStorageItemQuantity:SetText( tostring( nMaxQuantity));
			edtConfirmStorageItemQuantity:SetSel( 0, edtConfirmStorageItemQuantity:GetLength());
		end
	end
end
