--[[
	Game map LUA script
--]]


-- Global instance
luaMap = {};




-- OnShowMapFrame
function luaMap:OnShowMapFrame()

	-- Show
	if ( frmMap:GetShow() == true)  then

		luaMap:RefreshMapInfo();
		
		
	-- Hide
	else
	
		mapFieldMap:AddMarkerArtisan( 0);
		mapMiniMap:AddMarkerArtisan( 0);
	end
	
	
	luaGame:ShowWindow( frmMap);
end





-- RefreshMapInfo
function luaMap:RefreshMapInfo()

	luaMap:RefreshFieldMapList();
	luaMap:RefreshFieldMap();
	luaMap:RefreshWorldMapInfo();
end





-- RefreshFieldMapList
function luaMap:RefreshFieldMapList()

	if ( frmMap:GetShow() == false)  then  return;
	end

	if ( tbcMapTabCtrl:GetSelIndex() ~= 0)  then  return;
	end


	cmbFieldList:ResetContent();
	

	local nCurField = gamefunc:GetCurrentFieldID();

	for  i = 0, (gamefunc:GetFieldListCount() - 1)  do
	
		local nID = gamefunc:GetFieldID( i);
		
		local bShow = gamefunc:IsShowFieldMap( nID);
		
		if (gamefunc:IsServerModeExpo() == false) then
			if (nID == 8891) then
				bShow = false;
			elseif (nID == 8892) then
				bShow = false;
			end
		end
		
		if ( bShow == true ) then
					
			local strName = gamefunc:GetFieldName( nID);
			
			local nIndex = cmbFieldList:AddString( strName);
			cmbFieldList:SetItemData( nIndex, nID);
			
			if ( nID == nCurField)  then  cmbFieldList:SetCurSel( nIndex);
			end
		end
	end
end





-- RefreshFieldMap
function luaMap:RefreshFieldMap()

	if ( frmMap:GetShow() == false)  then  return;
	end

	if ( tbcMapTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	local nCurSel = cmbFieldList:GetCurSel();
	if ( nCurSel < 0)  then
	
		local nCurField = gamefunc:GetCurrentFieldID();
		if ( gamefunc:IsShowFieldMap(nCurField) == false) then
			mapFieldMap:UpdateInfo( nCurField);
			local strName = gamefunc:GetFieldName( nCurField);
			cmbFieldList:SetText( strName);
		end
		
		return;
	end
	
	local nID = cmbFieldList:GetItemData( nCurSel);
	if ( nID <= 0)  then  return;
	end
	

	mapFieldMap:UpdateInfo( nID);
end





-- RefreshWorldMapInfo
function luaMap:RefreshWorldMapInfo()

	if ( frmMap:GetShow() == false)  then  return;
	end

	if ( tbcMapTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
end





-- OnSelChangeFieldList
function luaMap:OnSelChangeFieldList()

	luaMap:RefreshFieldMap();
end





-- OnClickMoveToMyLocation
function luaMap:OnClickMoveToMyLocation()

	local nCurField = gamefunc:GetCurrentFieldID();
	if ( gamefunc:IsShowFieldMap(nCurField) == false) then

		mapFieldMap:UpdateInfo( nCurField);
		local strName = gamefunc:GetFieldName( nCurField);
		cmbFieldList:SetText( strName);
		return;
	end
	
	for  i = 0, (cmbFieldList:GetItemCount() - 1)  do
	
		local nID = cmbFieldList:GetItemData( i);
		
		if ( nID == nCurField)  then  cmbFieldList:SetCurSel( i);
		end
	end
	
	mapFieldMap:ResetDragOffset();
	
	luaMap:RefreshFieldMap();
end





-- OnClickFieldMapOption
function luaMap:OnClickFieldMapOption()

	btnShowCraftIcon:SetCheck( gameoption:IsShowCraftIcon());
	btnShowShopIcon:SetCheck( gameoption:IsShowShopIcon());
	btnShowAreaIcon:SetCheck( gameoption:IsShowAreaIcon());
	btnShoQuestIcon:SetCheck( gameoption:IsShowQuestIcon());

	pmFieldMapOption:SetPosition( gamefunc:GetCursorPos());
	pmFieldMapOption:BringToTop();
	pmFieldMapOption:Show( true);
	pmFieldMapOption:SetFocus();
end
