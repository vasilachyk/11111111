--[[
	Game assign looting LUA script
--]]


-- Global instance
luaAssignLooting = {};





-- OnLoadedAssignLootingFrame
function luaAssignLooting:OnLoadedAssignLootingFrame()

	luaGame:RegisterWindow( frmAssignLooting);
	
	
	if ( frmAssignLooting:GetShow() == false)  then
	
		local nCount = gamefunc:GetAssignLootingCount();
		if ( nCount > 0)  then

			local strString = FORMAT( "UI_GAME_EXISTLOOTITEMS", nCount);
			luaMessageBox:MessageBox( strString, 0, "assignlooting", nil, luaGame.OnCallbackAssignLooting);
		end
	end
end





-- OnShowAssignLootingFrame
function luaAssignLooting:OnShowAssignLootingFrame()

	-- Show
	if ( frmAssignLooting:GetShow() == true)  then
	
		luaAssignLooting:RefreshAssignLooting();
		
	
	-- Hide
	else
	
		local nCount = gamefunc:GetAssignLootingCount();
		if ( nCount > 0)  then
		
			local strString = FORMAT( "UI_GAME_EXISTLOOTITEMS", nCount);
			luaMessageBox:MessageBox( strString, 0, "assignlooting", nil, luaGame.OnCallbackAssignLooting);
		end
	end
	
	
	luaGame:ShowWindow( frmAssignLooting);
end





-- RefreshAssignLooting
function luaAssignLooting:RefreshAssignLooting()

	luaAssignLooting:RefreshAssignLootingList();
	luaAssignLooting:RefreshLooterList();
	luaAssignLooting:RefreshControls();
end





-- RefreshAssignLootingList
function luaAssignLooting:RefreshAssignLootingList()

	if ( frmAssignLooting:GetShow() == false)  then  return;
	end
	

	local nCount = gamefunc:GetAssignLootingCount();
	if ( nCount == 0)  then  frmAssignLooting:Show( false);
	end

	
	-- Looting list	
	local nCurSel = math.max( 0, lcAssignLooting:GetCurSel());
	
	lcAssignLooting:DeleteAllItems();
	for i = 0, (nCount - 1)  do
	
		local nID = gamefunc:GetAssignLootingID( i);
		local nQuantity = gamefunc:GetAssignLootingQuantity( i);
		local strName = gamefunc:GetItemName( nID);
		local strImage = gamefunc:GetItemImage( nID);
		

		local nIndex = lcAssignLooting:AddItem( strName, strImage);
		lcAssignLooting:SetItemText( nIndex, 1, STR( "QUANTITY") .. " : " .. nQuantity);

		local strTier = GetItemTierString( nID);
		local r, g, b = GetItemColor( nID);
		lcAssignLooting:SetItemText( nIndex, 2, strTier);
		lcAssignLooting:SetItemColor( nIndex, 2, r, g, b);
		lcAssignLooting:SetItemData( nIndex, i);
	end
	
	lcAssignLooting:SetCurSel( nCurSel);

	labAssignLootingCount:SetText( STR( "COOUNT") .. " : " .. nCount);
end




	
-- RefreshLooterList
function luaAssignLooting:RefreshLooterList()

	local nCurSel = lcAssignLooting:GetCurSel();
	if ( nCurSel < 0)  then
	
		lcLooter:DeleteAllItems();
		return;
	end
	
	local nItemIndex = lcAssignLooting:GetItemData( nCurSel);
	if ( nItemIndex < 0)  then

		lcLooter:DeleteAllItems();
		return;
	end
	
	

	-- Member list
	local nCurSel = math.max( 0, lcLooter:GetCurSel());
	
	lcLooter:DeleteAllItems();
	
	for i = 0, (gamefunc:GetLooterCount( nItemIndex) - 1)  do
	
		local strName = gamefunc:GetLooterName( nItemIndex, i);

		local nIndex = lcLooter:AddItem( strName, "iconDefender");
	end

	lcLooter:SetCurSel( nCurSel);
end





-- RefreshControls
function luaAssignLooting:RefreshControls()

	if ( frmAssignLooting:GetShow() == false)  then  return;
	end
	
	
	local nCurSel = lcAssignLooting:GetCurSel();
	if ( nCurSel < 0)  then
	
		btnSelectedAssignLooting:Enable( false);
		btnRandomAssignLooting:Enable( false);
		return;
	end

	local nIndex = lcAssignLooting:GetItemData( nCurSel);
	if ( nIndex < 0)  then
	
		btnSelectedAssignLooting:Enable( false);
		btnRandomAssignLooting:Enable( false);
		return;
	end
	


	local nCurSel = lcLooter:GetCurSel();
	if ( nCurSel < 0)  then

		btnSelectedAssignLooting:Enable( false);
		btnRandomAssignLooting:Enable( false);
		return;
	end
	
	local nIndex = lcLooter:GetItemData( nCurSel);
	if ( nIndex < 0)  then
	
		btnSelectedAssignLooting:Enable( false);
		btnRandomAssignLooting:Enable( false);
		return;
	end


	btnSelectedAssignLooting:Enable( true);
	btnRandomAssignLooting:Enable( true);
end





-- OnSelChangeLootingList
function luaAssignLooting:OnSelChangeLootingList()

	luaAssignLooting:RefreshLooterList();
	luaAssignLooting:RefreshControls();
end





-- OnToolTipAssignLooting
function luaAssignLooting:OnToolTipAssignLooting()

	local strString = "";
	
	local nCurSel = lcAssignLooting:GetMouseOver();
	if ( nCurSel >= 0)  then
	
		local nIndex = lcAssignLooting:GetItemData( nCurSel);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetAssignLootingID( nIndex);
			if ( nID > 0)  then  strString = luaToolTip:GetItemToolTip( nID, nil, nil);
			end
		end
	end
	
	lcAssignLooting:SetToolTip( strString);
end





-- OnItemDblClickLooterList
function luaAssignLooting:OnItemDblClickLooterList()

	local nCurSelLooting = lcAssignLooting:GetCurSel();
	if ( nCurSelLooting < 0)  then  return;
	end
	
	local nItemIndex = lcAssignLooting:GetItemData( nCurSelLooting);
	if ( nItemIndex < 0)  then  return;
	end


	local nCurSelLooter = lcLooter:GetCurSel();
	if ( nCurSelLooter < 0)  then  return;
	end
	
	local nLooterIndex = lcLooter:GetItemData( nCurSelLooter);
	if ( nLooterIndex < 0)  then  return;
	end
	
	
	gamefunc:DoAssignLooting( nItemIndex, nLooterIndex);
	
	luaAssignLooting:RefreshAssignLooting();
end






-- OnClickSelectedAssignLooting
function luaAssignLooting:OnClickSelectedAssignLooting()

	local nCurSelLooting = lcAssignLooting:GetCurSel();
	if ( nCurSelLooting < 0)  then  return;
	end
	
	local nItemIndex = lcAssignLooting:GetItemData( nCurSelLooting);
	if ( nItemIndex < 0)  then  return;
	end


	local nCurSelLooter = lcLooter:GetCurSel();
	if ( nCurSelLooter < 0)  then  return;
	end
	
	local nLooterIndex = lcLooter:GetItemData( nCurSelLooter);
	if ( nLooterIndex < 0)  then  return;
	end
	
	
	gamefunc:DoAssignLooting( nItemIndex, nLooterIndex);

	luaAssignLooting:RefreshAssignLooting();
end





-- OnClickRandomAssignLooting
function luaAssignLooting:OnClickRandomAssignLooting()

	local nCurSelLooting = lcAssignLooting:GetCurSel();
	if ( nCurSelLooting < 0)  then  return;
	end
	
	local nItemIndex = lcAssignLooting:GetItemData( nCurSelLooting);
	if ( nItemIndex < 0)  then  return;
	end


	local nLooterIndex = math.random( 0, gamefunc:GetLooterCount( nItemIndex) - 1);
	
	gamefunc:DoAssignLooting( nItemIndex, nLooterIndex);

	luaAssignLooting:RefreshAssignLooting();
end
