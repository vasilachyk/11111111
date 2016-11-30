--[[
	Game dying LUA script
--]]


-- Global instance
luaDyeing = {};


-- Type of target item
luaDyeing.DYE_TYPE = { NONE = 0,  INVENTORY = 1,  EQUIPPED = 2 };


-- Variables of deying
luaDyeing.m_bDyeing = false;
luaDyeing.m_bPostCancelDyeing = false;
luaDyeing.m_nDyeItemInvenIndex = -1;
luaDyeing.m_nTargetItemType = luaDyeing.DYE_TYPE.NONE;
luaDyeing.m_nTargetItemIndex = -1;


-- Progress bar timer
luaDyeing.m_fProgressBarTimer = nil;





-- OnShowDyeingFrame
function luaDyeing:OnShowDyeingFrame()

	-- Show
	if ( frmDyeing:GetShow() == true)  then
	
	
	-- Hide
	else

		luaDyeing:CloseDyeingFrame();
	end
end





-- OnTimerDyeingFrame
function luaDyeing:OnTimerDyeingFrame()

	local bEnable = true;
	local strMessage = "";
	
	local nID = 0;
	if ( lcInventory:IsMouseIncluded() == true)  then
	
		local nMouseOver = lcInventory:GetMouseOver();
		if ( nMouseOver >= 0)  then  nID = gamefunc:GetInvenItemID( nMouseOver);
		end
		
	else
	
		local _slots = { isHead, isBody, isHands, isLeg, isFeet };
		for i, _slot  in pairs( _slots)  do
		
			if ( _slot:IsMouseIncluded() == true)  then
			
				nID = _slot:GetItemID();
				break;
			end
		end
	end
	

	if ( nID <= 0)  then
	
		bEnable = false;
		strMessage = STR( "UI_DYEING_SELECTITEM");
	
	elseif ( gamefunc:IsItemDyeable( nID) == false)  then
		
		bEnable = false;
		strMessage = STR( "UI_DYEING_INVALIDITEM");
	end

	
	if ( bEnable == true)  then
	
		DragEventArgs:SetItemText( 0, STR( "UI_DYEING_AVAILABLEDYEING"));
		DragEventArgs:SetColor( 255, 255, 255);
		
	else
	
		DragEventArgs:SetItemText( 0, strMessage);
		DragEventArgs:SetColor( 255, 64, 64);
	end
end





-- OpenDyeItem
function luaDyeing:OpenDyeItem( nIndex)

	if ( luaDyeing.m_bDyeing == true)  or  ( nIndex < 0)  then  return;
	end
	
	local nDyeingID = gamefunc:GetInvenItemID( nIndex);
	if ( nDyeingID <= 0)  then  return;
	end
	
	
	-- Open dyeing
	if ( gamefunc:OpenDyeItem( nIndex) == false)  then  return;
	end
	
	
	-- Set variables
	luaDyeing.m_bDyeing = true;
	luaDyeing.m_bPostCancelDyeing = true;
	luaDyeing.m_nDyeItemInvenIndex = nIndex;


	-- Begin drag item
	lcInventory:AttachDragItem( "", gamefunc:GetItemImage( nDyeingID), nIndex);
	DragEventArgs:SetFont( "fntScriptStrong");
	DragEventArgs:SetHotSpot( 20, 20);
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetOpacity( 0.8);
	

	-- Set timer
	frmDyeing:SetTimer( 100, 0);
end





-- CloseDyeItem
function luaDyeing:CloseDyeItem()

	-- Kill timer
	frmDyeing:KillTimer();
	
	
	-- Cancel dyeing
	if ( luaDyeing.m_bDyeing == false)  then
	
		-- Post cancel
		if ( luaDyeing.m_bPostCancelDyeing == true)  then
		
			luaDyeing.m_bPostCancelDyeing = false;
			
			gamefunc:CancelDyeItem();
		end
	end
end





-- OpenDyeingFrame
function luaDyeing:OpenDyeingFrame( nTargetType, nTargetIndex)

	if ( frmDyeing:GetShow() == true)  or  ( luaDyeing.m_bDyeing == false)  or  ( luaDyeing.m_nDyeItemInvenIndex < 0)  then
	
		luaDyeing:CloseDyeingFrame();
		return false;
	end
	
	
	-- Close dye item
	luaDyeing:CloseDyeItem();
	

	-- Get item ID
	local nItemID = 0;
	local nDyeItemID = 0;
	luaDyeing.m_nTargetItemType = nTargetType;
	luaDyeing.m_nTargetItemIndex = nTargetIndex;
	luaDyeing.m_bPostCancelDyeing = true;
		
	if ( luaDyeing.m_nTargetItemType == luaDyeing.DYE_TYPE.INVENTORY)  then
	
		if ( luaDyeing.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetInvenItemID( luaDyeing.m_nTargetItemIndex);
		end
	
	elseif ( luaDyeing.m_nTargetItemType == luaDyeing.DYE_TYPE.EQUIPPED)  then

		if ( luaDyeing.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetEquippedItemID( luaDyeing.m_nTargetItemIndex);
		end
	end


	-- Check item type
	if ( nItemID <= 0)  or  ( gamefunc:IsItemDyeable( nItemID) == false)  then
	
		luaDyeing:CloseDyeingFrame();
		return false;
	end
	
	
	-- Get dye item ID
	nDyeItemID = gamefunc:GetInvenItemID( luaDyeing.m_nDyeItemInvenIndex);
	if ( nDyeItemID <= 0)  then
	
		luaDyeing:CloseDyeingFrame();
		return false;
	end
	
	
	-- Set target item
	picDyeTargetItem:SetImage( gamefunc:GetItemImage( nItemID));
	
	local strToolTip = "";
	if ( luaDyeing.m_nTargetItemType == luaDyeing.DYE_TYPE.INVENTORY)  then		strToolTip = luaToolTip:GetItemToolTip( nItemID, luaDyeing.m_nTargetItemIndex, nil);
	else																		strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, luaDyeing.m_nTargetItemIndex);
	end
	picDyeTargetItem:SetToolTip( strToolTip);


	-- Set dye item
	picDyeItem:SetImage( gamefunc:GetItemImage( nDyeItemID));

	local strToolTip = luaToolTip:GetItemToolTip( nDyeItemID, nil, nil);
	picDyeItem:SetToolTip( strToolTip);
	
	
	-- Set dye colors
	lcDyeingColors:DeleteAllItems();
	local nColorCount = gamefunc:GetItemDyeColorCount( nDyeItemID);
	for  i = 0, ( nColorCount - 1)  do
	
		local r, g, b, a = gamefunc:GetItemDyeColor( nDyeItemID, i);

		local nIndex = lcDyeingColors:AddItem( r, "bmpGlassPanel");
		lcDyeingColors:SetItemText( nIndex, 1, g);
		lcDyeingColors:SetItemText( nIndex, 2, b);
		lcDyeingColors:SetItemText( nIndex, 3, a);
		lcDyeingColors:SetItemData( nIndex, i);
	end
	
	
	-- Reposition dye colors
	local pw, ph = lcDyeingColors:GetParent():GetSize();
	local x, y, w, h = lcDyeingColors:GetRect();
	w = 32 * math.min( 5, nColorCount);
	lcDyeingColors:SetRect( (pw * 0.5) - (w * 0.5), y, w, h);
	
	
	-- Set message
	local strMessage = "";
	if ( nColorCount > 1)  then
	
		strMessage = "{BITMAP name=\"iconDefExclamation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=192 g=154 b=63}" .. STR( "UI_DYEING_DYEINGMSG1");

	else

		strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_DYEING_DYEINGMSG2");
	end
	tvwDyeMessage:SetText( strMessage);
	

	-- Begin state
	if ( gamefunc:BeginDyeItem( luaDyeing.m_nTargetItemType, luaDyeing.m_nTargetItemIndex, luaDyeing.m_nDyeItemInvenIndex) == false)  then
	
		luaDyeing:CloseDyeingFrame();
		return false;
	end


	-- Show frame
	local x, y = frmDyeing:GetParent():GetPosition();
	local w, h = frmDyeing:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmDyeing:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmDyeing:DoModal();
	
	
	-- Hide progress bar
	frmDyeingProgress:Show( false);
	
	
	return true;
end





-- CloseDyeingFrame
function luaDyeing:CloseDyeingFrame()

	-- Set variables
	luaDyeing.m_bDyeing = false;
	
	
	-- Close dye item
	luaDyeing:CloseDyeItem();
	
	
	-- Hide frame
	frmDyeing:Show( false);


	-- Hide progress bar
	frmDyeingProgress:Show( false);
end





-- OnDrawItemBkgrndDyeingColorsListCtrl
function luaDyeing:OnDrawItemBkgrndDyeingColorsListCtrl()

	local nSubItem = EventArgs:GetItemSubItem();

	if ( nSubItem == 0)  then

		local nIndex = EventArgs:GetItemIndex();
		local x, y, w, h = EventArgs:GetItemRect();
		
		local r = tonumber( lcDyeingColors:GetItemText( nIndex, 0));
		local g = tonumber( lcDyeingColors:GetItemText( nIndex, 1));
		local b = tonumber( lcDyeingColors:GetItemText( nIndex, 2));
		local a = tonumber( lcDyeingColors:GetItemText( nIndex, 3));
		gamedraw:SetColor( r, g, b, a);
		gamedraw:FillRect( x, y, w, h);
	end
end





-- OnClickDoDyeing
function luaDyeing:OnClickDoDyeing()

	if ( luaDyeing.m_bDyeing == false)  then  return;
	end
	
	
	-- Set variables
	luaDyeing.m_bPostCancelDyeing = false;

	
	-- Hide frame
	frmDyeing:Show( false);
	

	-- Reset progress bar
	luaDyeing.m_fProgressBarTimer = gamefunc:GetUpdateTime();
	pcDyeingProgress:SetPos( 0);
	
	
	-- Reposition frame
	local x, y = frmDyeingProgress:GetParent():GetPosition();
	local w, h = frmDyeingProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmDyeingProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmDyeingProgress:DoModal();
	
	
	-- Do dyeing
	gamefunc:DoDyeingItem( luaDyeing.m_nTargetItemType, luaDyeing.m_nTargetItemIndex, luaDyeing.m_nDyeItemInvenIndex);
end







function luaDyeing:OnShowDyeingProgress()

	-- Show
	if ( frmDyeingProgress:GetShow() == true)  then
	
	
	-- Hide
	else

		-- 중간에 취소
		if ( luaDyeing.m_fProgressBarTimer ~= nil)  then
			
			gamefunc:CancelDyeItem();			
		end

	end
end











-- OnUpdateDyeingProgressBar
function luaDyeing:OnUpdateDyeingProgressBar()

	if ( luaDyeing.m_fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaDyeing.m_fProgressBarTimer + 100;
	local nPos = fElapsed / 20.0;
	pcDyeingProgress:SetPos( nPos);
	
	
	if ( nPos >= 100)  then  luaDyeing.m_fProgressBarTimer = nil;
	end
end
