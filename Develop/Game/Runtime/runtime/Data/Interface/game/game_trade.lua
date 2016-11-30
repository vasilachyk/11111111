--[[
	Game trade LUA script
--]]


-- Global instance
luaTrade = {};


-- Flag successful trading
luaTrade.m_bPostCancelTrading = true;





-- OnShowTradeFrame
function luaTrade:OnShowTradeFrame()

	-- Show
	if ( frmTrade:GetShow() == true)  then
	
		luaMessageBox:DeleteMessageBoxType( "trade");

		luaTrade.m_bPostCancelTrading = true;


		-- Hide message box
		luaMessageBox:DeleteMessageBoxType( "trade");
		

		-- Show inventory
		frmInventory:Show( true);
		

		-- Refresh UI
		lcOtherTradeItems:SetCurSel( -1);
		lcMyTradeItems:SetCurSel( -1);


		-- Refresh trade frame
		luaTrade:RefreshTrade();

	
	-- Hide
	else
	
		--frmInventory:Show( false);
	
		if ( luaTrade.m_bPostCancelTrading == true)  then  gamefunc:CancelTrade();
		end
	end
	
	
	luaGame:ShowWindow( frmTrade);
end





-- RefreshTrade
function luaTrade:RefreshTrade()

	if ( frmTrade:GetShow() == false)  then  return;
	end


	-- Update other name
	local strOtherName = FORMAT( "UI_TRADE_OTHERTRADEITEMS", gamefunc:GetRequesterName());
	labTradeOtherName:SetText( strOtherName);


	-- Refresh UI
	luaTrade:RefreshTradeList();
	luaTrade:RefreshControls();
end





-- RefreshTradeList
function luaTrade:RefreshTradeList()

	if ( frmTrade:GetShow() == false)  then  return;
	end
	
	
	-- Update other trade items
	local nCurSel = lcOtherTradeItems:GetCurSel();
	
	lcOtherTradeItems:DeleteAllItems();

	local nMoney = gamefunc:GetOtherTradeMoney();
	if ( nMoney > 0)  then

		lcOtherTradeItems:AddItem( STR( "MONEY"), "iconMoney");
		lcOtherTradeItems:SetItemText( 0, 1, "$$" .. luaGame:ConvertMoneyToStr( nMoney));
		lcOtherTradeItems:SetItemData( nIndex, -1);
	end

	for  i = 0, ( gamefunc:GetOtherTradeItemCount() - 1)  do

		local nID = gamefunc:GetOtherTradeItemID( i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nQuantity = gamefunc:GetOtherTradeItemQuantity( i);

		local nIndex = lcOtherTradeItems:AddItem( strName, strImage);
		lcOtherTradeItems:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);
		lcOtherTradeItems:SetItemData( nIndex, i);
	end
	
	lcOtherTradeItems:SetCurSel( nCurSel);
	
	
	
	-- Update my trade items
	local nCurSel = lcMyTradeItems:GetCurSel();

	lcMyTradeItems:DeleteAllItems();

	local nMoney = gamefunc:GetMyTradeMoney();
	if ( nMoney > 0)  then
	
		lcMyTradeItems:AddItem( STR( "MONEY"), "iconMoney");
		lcMyTradeItems:SetItemText( 0, 1, "$$" .. luaGame:ConvertMoneyToStr( nMoney));
		lcMyTradeItems:SetItemData( nIndex, -1);
	end

	for  i = 0, ( gamefunc:GetMyTradeItemCount() - 1)  do

		local nID = gamefunc:GetMyTradeItemID( i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		local nQuantity = gamefunc:GetMyTradeItemQuantity( i);

		local nIndex = lcMyTradeItems:AddItem( strName, strImage);
		lcMyTradeItems:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);
		lcMyTradeItems:SetItemData( nIndex, i);
	end
	
	lcMyTradeItems:SetCurSel( nCurSel);
end





-- RefreshControls
function luaTrade:RefreshControls()

	-- Message other
	local strString = "{FONT name=\"fntScript\"}";
	if ( gamefunc:IsOtherReadyToTrade() == true)  then		strString = strString .. "{COLOR r=150 g=50 b=40}" .. STR( "UI_TRADE_MESSAGE1");
	else													strString = strString .. "{COLOR r=120 g=120 b=120}" .. STR( "UI_TRADE_MESSAGE2");
	end
	tvwTradeMessageOther:SetText( strString);
	
	
	-- Message me
	local strString = "{FONT name=\"fntScript\"}";
	if ( gamefunc:GetMyTradeItemCount() == 0)  and
	   ( gamefunc:GetMyTradeMoney() == 0)  then				strString = strString .. "{COLOR r=120 g=120 b=120}" .. STR( "UI_TRADE_MESSAGE3");
	elseif ( lcMyTradeItems:GetItemCount() >= 5)  then		strString = strString .. "{COLOR r=150 g=50 b=40}" .. STR( "UI_TRADE_MESSAGE4");
	else													strString = strString .. "{COLOR r=120 g=120 b=120}" .. STR( "UI_TRADE_MESSAGE5");
	end
	tvwTradeMessageMe:SetText(strString);
	
	
	local bReadyToTrade = gamefunc:IsReadyToTrade();
	if ( bReadyToTrade == true)  then		btnReadyToTrade:Enable( false);
	else									btnReadyToTrade:Enable( true);
	end
end





-- OnEventSuccessTrading
function luaTrade:OnEventSuccessTrading( bSuccess)

	if ( bSuccess == true)  then	pbPresentationLower:Add( STR( "UI_TRADE_COMPLETED"), 2);
	else							pbPresentationLower:Add( STR( "UI_TRADE_CANCELED"), 1);
	end


	luaTrade.m_bPostCancelTrading = false;
end





-- OnToolTipOtherTradeItem
function luaTrade:OnToolTipOtherTradeItem()

	local strToolTip = "";
	
	local nCurSel = lcOtherTradeItems:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcOtherTradeItems:GetItemData( nCurSel);
		if ( nIndex >= 0) then
		
			local nID = gamefunc:GetOtherTradeItemID( nIndex);
			strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
		end
	end

	lcOtherTradeItems:SetToolTip( strToolTip);
end





-- OnToolTipMyTradeItem
function luaTrade:OnToolTipMyTradeItem()

	local strToolTip = "";
	
	local nCurSel = lcMyTradeItems:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcMyTradeItems:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetMyTradeItemID( nIndex);
			strToolTip = luaToolTip:GetItemToolTip( nID, nil, nil);
		end
	end

	lcMyTradeItems:SetToolTip( strToolTip);
end






-- OnDragBeginMyTradeItem
function luaTrade:OnDragBeginMyTradeItem()

	local nIndex = DragEventArgs:GetItemData( 0);


	-- Drag money
	if ( gamefunc:GetMyTradeMoney() > 0)  and  ( nIndex == -1)  then
	
		-- Play sound
		local strSound = gamefunc:GetMoneyPutUpSound( nID);
		gamefunc:PlaySound( strSound);
		
		return true;
		

	-- Drag item
	elseif ( nIndex >= 0)  then
	
		local nID = gamefunc:GetMyTradeItemID( nIndex);
		if ( nID > 0)  then
		
			-- Play sound
			local strSound = gamefunc:GetItemPutUpSound( nID);
			gamefunc:PlaySound( strSound);

			return true;
		end
	end
	
	
	return false;
end





-- OnDragEndMyTradeItem
function luaTrade:OnDragEndMyTradeItem()

	if ( DragEventArgs:IsDropped() == true)  then  return;
	end


	-- Drop money
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( gamefunc:GetMyTradeMoney() > 0)  and  ( nIndex == -1)  then
	
		gamefunc:PutDownMoney( gamefunc:GetMyTradeMoney());
		
		
		-- Play sound
		local strSound = gamefunc:GetMoneyPutDownSound();
		gamefunc:PlaySound( strSound);

		return;
	end


	-- Drop item
	if ( nIndex >= 0)  then
	
		local nID = gamefunc:GetMyTradeItemID( nIndex);
		if ( nID > 0)  then

			gamefunc:PutDownTradeItem( nIndex);
					
					
			-- Play sound
			local strSound = gamefunc:GetItemPutDownSound( nID);
			gamefunc:PlaySound( strSound);
		end
	end
end





-- OnDropMyTradeItem
function luaTrade:OnDropMyTradeItem()

	if (lcMyTradeItems:GetItemCount() >= 5) then
		return;
	end

    local _sender = _G[ DragEventArgs:GetSender():GetName()];
    
    -- Self drop
    if ( _sender == lcMyTradeItems)  then
    
		return true;


	-- Drop inventory item
	elseif ( _sender == lcInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
			
				luaInventory:OpenConfirmItemQuantityFrame( luaTrade.CallbackDropTradeItem, STR( "UI_CONFIRM"), STR( "UI_TRADE_CONFIRMTRADEITEMS"));
			end
		end
		
		return true;


	-- Drop money
	elseif ( _sender == tvwMoney)  then
	
		luaInventory:OpenConfirmMoneyAmountFrame( luaTrade.CallbackDropTradeMoney, gamefunc:GetMyTradeMoney());
		return true;
	end
	
	
	return false;
end





-- CallbackDropTradeItem
function luaTrade:CallbackDropTradeItem( nIndex, nQuantity)

	gamefunc:PutUpTradeItem( nIndex, nQuantity);
end





-- CallbackDropTradeMoney
function luaTrade:CallbackDropTradeMoney( nMoney)

	gamefunc:PutUpMoney( nMoney);
end





-- OnClickReadyToTrade
function luaTrade:OnClickReadyToTrade()

	local bReadyToTrade = gamefunc:IsReadyToTrade();
	gamefunc:ReadyToTrade( not bReadyToTrade);
end
