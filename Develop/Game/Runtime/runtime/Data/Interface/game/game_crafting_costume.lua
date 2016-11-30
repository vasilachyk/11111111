--[[
	Game Crafting Costume LUA script
--]]


-- Global instance
luaCraftingCostume = {};


-- Type of target item
luaCraftingCostume.CRAFTING_COSTUME_TYPE = { NONE = 0,  INVENTORY = 1,  EQUIPPED = 2 };


-- Variables of deying
luaCraftingCostume.m_bCraftingCostume = false;
luaCraftingCostume.m_bPostCancelCraftingCostume = false;
luaCraftingCostume.m_nTargetItemInvenIndex = -1;
luaCraftingCostume.m_nTargetItemType = luaCraftingCostume.CRAFTING_COSTUME_TYPE.NONE;
luaCraftingCostume.m_nTargetItemIndex = -1;


-- Progress bar timer
luaCraftingCostume.m_fProgressBarTimer = nil;





-- OnShowCraftingCostumeFrame
function luaCraftingCostume:OnShowCraftingCostumeFrame()

	-- Show
	if ( frmCraftingCostume:GetShow() == true)  then
	
	
	-- Hide
	else

		luaCraftingCostume:CloseCraftingCostumeFrame();
	end
end





-- OnTimerCraftingCostumeFrame
function luaCraftingCostume:OnTimerCraftingCostumeFrame()

	local bEnable = true;
	local strMessage = "";
	local nIndex = -1;
	
	local nID = 0;
	if ( lcInventory:IsMouseIncluded() == true)  then
	
		-- 인벤 아이템
		local nCurSel = lcInventory:GetMouseOver();
		if ( nCurSel >= 0) then
			nIndex = lcInventory:GetItemData( nCurSel);
			if ( nIndex >= 0)  then  nID = gamefunc:GetInvenItemID( nIndex);
			end
		end
		
	elseif ( lcExInventory:IsMouseIncluded() == true)  then
	
		-- 확장 인벤 아이템
		local nCurSel = lcExInventory:GetMouseOver();
		if ( nCurSel >= 0) then
			nIndex = lcExInventory:GetItemData( nCurSel);
			if ( nIndex >= 0)  then  nID = gamefunc:GetInvenItemID( nIndex);
			end
		end	
		
	else
	
		local _slots = { isHead, isBody, isHands, isLeg, isFeet, isWeapon1, isWeapon2, isWeapon1Sub, isWeapon2Sub };

		for i, _slot  in pairs( _slots)  do
		
			if ( _slot:IsMouseIncluded() == true)  then
			
				nID = _slot:GetItemID();
				break;
			end
		end
	end

	-- 확장인벤 검사
	if	(nIndex >= 80 and gamefunc:IsExInventory() == false)	then
		return;
	end
	

	if ( nID <= 0)  then
	
		bEnable = false;
		strMessage = STR( "UI_CRAFTING_COSTUME_SELECTITEM");
	else	
		if ( gamefunc:IsItemCraftableCostume( nID) == false)  then
		
			bEnable = false;
			strMessage = STR( "UI_CRAFTING_COSTUME_INVALIDITEM");
		end
	end

	
	if ( bEnable == true)  then
	
		DragEventArgs:SetItemText( 0, STR( "UI_CRAFTING_COSTUME_AVAILABLE"));
		DragEventArgs:SetColor( 255, 255, 255);
		
	else
	
		DragEventArgs:SetItemText( 0, strMessage);
		DragEventArgs:SetColor( 255, 64, 64);
	end
end





-- OpenCraftingCostume
function luaCraftingCostume:OpenCraftingCostume( nIndex)

	if ( luaCraftingCostume.m_bCraftingCostume == true)  or  ( nIndex < 0)  then  return;
	end
	
	local nItemID = gamefunc:GetInvenItemID( nIndex);
	if ( nItemID <= 0)  then  return;
	end
	
	
	-- Open Crafting Costume
	if ( gamefunc:OpenCraftingCostumeItem( nIndex) == false)  then
		return;
	end
	
	-- Set variables
	luaCraftingCostume.m_bCraftingCostume = true;
	luaCraftingCostume.m_bPostCancelCraftingCostume = true;
	luaCraftingCostume.m_nTargetItemInvenIndex = nIndex;

	-- Begin drag item
	lcInventory:AttachDragItem( "", gamefunc:GetItemImage( nItemID), nIndex);
	DragEventArgs:SetFont( "fntScriptStrong");
	DragEventArgs:SetHotSpot( 20, 20);
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetOpacity( 0.8);
	

	-- Set timer
	frmCraftingCostume:SetTimer( 100, 0);
end





-- CloseCraftingCostumeItem
function luaCraftingCostume:CloseCraftingCostumeItem()

	-- Kill timer
	frmCraftingCostume:KillTimer();
	
	
	-- Cancel Crafting Costume
	if ( luaCraftingCostume.m_bCraftingCostume == false)  then
	
		-- Post cancel
		if ( luaCraftingCostume.m_bPostCancelCraftingCostume == true)  then
		
			luaCraftingCostume.m_bPostCancelCraftingCostume = false;
			
			gamefunc:CancelCraftingCostumeItem();
		end
	end
end





-- OpenCraftingCostumeFrame
function luaCraftingCostume:OpenCraftingCostumeFrame( nTargetType, nTargetIndex)

	if ( frmCraftingCostume:GetShow() == true)  or  ( luaCraftingCostume.m_bCraftingCostume == false)  or  ( luaCraftingCostume.m_nTargetItemInvenIndex < 0)  then
	
		luaCraftingCostume:CloseCraftingCostumeFrame();
		return false;
	end
	
	
	-- Close Crafting Costume item
	luaCraftingCostume:CloseCraftingCostumeItem();
	

	-- Get item ID
	local nItemID = 0;
	local nCraftingCostumeItemID = 0;
	luaCraftingCostume.m_nTargetItemType = nTargetType;
	luaCraftingCostume.m_nTargetItemIndex = nTargetIndex;
	luaCraftingCostume.m_bPostCancelCraftingCostume = true;
		
	if ( luaCraftingCostume.m_nTargetItemType == luaCraftingCostume.CRAFTING_COSTUME_TYPE.INVENTORY)  then
	
		if ( luaCraftingCostume.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetInvenItemID( luaCraftingCostume.m_nTargetItemIndex);
		end
	
	elseif ( luaCraftingCostume.m_nTargetItemType == luaCraftingCostume.CRAFTING_COSTUME_TYPE.EQUIPPED)  then

		if ( luaCraftingCostume.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetEquippedItemID( luaCraftingCostume.m_nTargetItemIndex);
		end
	end

	-- 확장인벤 검사
	if	(nTargetIndex >= 80 and gamefunc:IsExInventory() == false)	then
		return;
	end

	-- Check item type
	if (luaCraftingCostume:CheckCraftingCostume( nItemID) == false) then
		luaCraftingCostume:CloseCraftingCostumeFrame();
		return false;
	end
	
	
	-- Get Crafting Costume item ID
	nCraftingCostumeItemID = gamefunc:GetInvenItemID( luaCraftingCostume.m_nTargetItemInvenIndex);
	if ( nCraftingCostumeItemID <= 0)  then
	
		luaCraftingCostume:CloseCraftingCostumeFrame();
		return false;
	end
	
	
	-- Set target item
	picCraftingCostumeTargetItem:SetImage( gamefunc:GetItemImage( nItemID));
	
	local strToolTip = "";
	if ( luaCraftingCostume.m_nTargetItemType == luaCraftingCostume.CRAFTING_COSTUME_TYPE.INVENTORY)  then		strToolTip = luaToolTip:GetItemToolTip( nItemID, luaCraftingCostume.m_nTargetItemIndex, nil);
	else																		strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, luaCraftingCostume.m_nTargetItemIndex);
	end
	picCraftingCostumeTargetItem:SetToolTip( strToolTip);


	-- Set Crafting Costume item
	picCraftingCostumeItem:SetImage( gamefunc:GetItemImage( nCraftingCostumeItemID));

	local strToolTip = luaToolTip:GetItemToolTip( nCraftingCostumeItemID, nil, nil);
	picCraftingCostumeItem:SetToolTip( strToolTip);
	
	
	
	-- Set message
	local strMessage = "";
	strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_CRAFTING_COSTUME_MSG1");
	
	tvwCraftingCostumeMessage:SetText( strMessage);
	

	-- Begin state
	if ( gamefunc:BeginCraftingCostumeItem( luaCraftingCostume.m_nTargetItemType, luaCraftingCostume.m_nTargetItemIndex, luaCraftingCostume.m_nTargetItemInvenIndex) == false)  then
	
		luaCraftingCostume:CloseCraftingCostumeFrame();
		return false;
	end


	-- Show frame
	local x, y = frmCraftingCostume:GetParent():GetPosition();
	local w, h = frmCraftingCostume:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmCraftingCostume:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmCraftingCostume:DoModal();
	
	
	-- Hide progress bar
	frmCraftingCostumeProgress:Show( false);
	
	
	return true;
end


function luaCraftingCostume:CheckCraftingCostume( nItemID)

	if ( nItemID <= 0) then
		return false;
	end

	if ( gamefunc:IsItemCraftableCostume( nItemID) == false)  then
		return false;
	end

	return true;
end



-- CloseCraftingCostumeFrame
function luaCraftingCostume:CloseCraftingCostumeFrame()

	-- Set variables
	luaCraftingCostume.m_bCraftingCostume = false;
	
	
	-- Close Crafting Costume item
	luaCraftingCostume:CloseCraftingCostumeItem();
	
	
	-- Hide frame
	frmCraftingCostume:Show( false);


	-- Hide progress bar
	frmCraftingCostumeProgress:Show( false);
end










-- OnClickDoCraftingCostume
function luaCraftingCostume:OnClickDoCraftingCostume()

	if ( luaCraftingCostume.m_bCraftingCostume == false)  then  return;
	end
	
	
	-- Set variables
	luaCraftingCostume.m_bPostCancelCraftingCostume = false;

	
	-- Hide frame
	frmCraftingCostume:Show( false);
	

	-- Reset progress bar
	luaCraftingCostume.m_fProgressBarTimer = gamefunc:GetUpdateTime();
	pcCraftingCostumeProgress:SetPos( 0);
	
	
	-- Reposition frame
	local x, y = frmCraftingCostumeProgress:GetParent():GetPosition();
	local w, h = frmCraftingCostumeProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmCraftingCostumeProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmCraftingCostumeProgress:DoModal();
	
	
	-- Do Crafting Costume Item
	gamefunc:DoCraftingCostumeItem( luaCraftingCostume.m_nTargetItemType, luaCraftingCostume.m_nTargetItemIndex, luaCraftingCostume.m_nTargetItemInvenIndex);
end







function luaCraftingCostume:OnShowCraftingCostumeProgress()

	-- Show
	if ( frmCraftingCostumeProgress:GetShow() == true)  then
	
	
	-- Hide
	else

		-- 중간에 취소
		if ( luaCraftingCostume.m_fProgressBarTimer ~= nil)  then
			
			gamefunc:CancelCraftingCostumeItem();			
		end

	end
end











-- OnUpdateCraftingCostumeProgressBar
function luaCraftingCostume:OnUpdateCraftingCostumeProgressBar()

	if ( luaCraftingCostume.m_fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaCraftingCostume.m_fProgressBarTimer + 100;
	local nPos = fElapsed / 20.0;
	pcCraftingCostumeProgress:SetPos( nPos);
	
	
	if ( nPos >= 100)  then  luaCraftingCostume.m_fProgressBarTimer = nil;
	end
end
