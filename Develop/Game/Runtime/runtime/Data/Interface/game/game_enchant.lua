--[[
	Game enchant LUA script
--]]


-- Global instance
luaEnchant = {};


-- Type of target item
luaEnchant.ENCHANT_TYPE = { NONE = 0,  INVENTORY = 1,  EQUIPPED = 2 };


-- Maximum value of enchantable slot
luaEnchant.MAX_ENCHANTHOLE = 5;


-- Variables of enchant
luaEnchant.m_bEnchanting = false;
luaEnchant.m_bPostCancelEnchant = false;
luaEnchant.m_nTargetItemType = luaEnchant.ENCHANT_TYPE.NONE;
luaEnchant.m_nTargetItemIndex = -1;
luaEnchant.m_nEnchantStoneInvenIndex = -1;
luaEnchant.m_nAgentItemID = 0;


-- Progress bar timer
luaEnchant.m_fProgressBarTimer = nil;





-- OnShowEnchantFrame
function luaEnchant:OnShowEnchantFrame()

	-- Show
	if ( frmEnchant:GetShow() == true)  then
	
	
	-- Hide
	else

		luaEnchant:CloseEnchantFrame();
	end
end





-- OnTimerEnchantFrame
function luaEnchant:OnTimerEnchantFrame()

	local bEnable = true;
	local strMessage = "";

	local nID = 0;
	local nEnchantStoneID = gamefunc:GetInvenItemID( luaEnchant.m_nEnchantStoneInvenIndex);
	local nIndex = -1;
	local nType = luaEnchant.ENCHANT_TYPE.NONE;
	if ( lcInventory:IsMouseIncluded() == true)  then
	
		nIndex = lcInventory:GetMouseOver();
		nType = luaEnchant.ENCHANT_TYPE.INVENTORY;
		if ( nIndex >= 0)  then  nID = gamefunc:GetInvenItemID( nIndex);
		end
		
	else
	
		local _slots = { isFace, isHead, isBody, isHands, isLeg, isFeet, isNecklace, isEarring, isRingR, isRingL, isWeapon1, isWeapon1Sub, isWeapon2, isWeapon2Sub };
		for i, _slot  in pairs( _slots)  do
		
			if ( _slot:IsMouseIncluded() == true)  then
			
				nID = _slot:GetItemID();
				nIndex = _slot:GetSlotType();
				nType = luaEnchant.ENCHANT_TYPE.EQUIPPED;
			end
		end
	end
	

	if ( nID <= 0)  then
	
		bEnable = false;
		strMessage = STR( "UI_ENCHANT_SELECTITEM");
	
	else
	
		local bFind = false;
		local nEnchantStoneType = gamefunc:GetItemEnchantType( nEnchantStoneID);
		local nCount = gamefunc:GetItemEnchantHoleCount( nID);
		if ( nCount > 0)  then
		
			for i = 0, ( nCount - 1)  do
	
				local nEnchantHoleType = ENCHANTHOLE_TYPE.NONE;
				local bEnchantHoleBroken = false;
				local nEnchantStoneID = 0;
				if ( nType == luaEnchant.ENCHANT_TYPE.INVENTORY)  then
				
					nEnchantHoleType = gamefunc:GetItemEnchantHoleType( gamefunc:GetInvenItemID( nIndex), i);
					nEnchantStoneID = gamefunc:GetInvenItemEnchantedStoneID( nIndex, i);
					
				elseif ( nType == luaEnchant.ENCHANT_TYPE.EQUIPPED)  then
				
					nEnchantHoleType = gamefunc:GetItemEnchantHoleType( gamefunc:GetEquippedItemID( nIndex), i);
					nEnchantStoneID = gamefunc:GetEquippedItemEnchantedStoneID( nIndex, i);
				end
				

				if ( nEnchantStoneID == 0)  and  ( nEnchantStoneType == nEnchantHoleType)  then
				
					bFind = true;
					break;
				end
			end
		end
		
		if ( bFind == false)  then
		
			bEnable = false;
			strMessage = STR( "UI_ENCHANT_NOTEXISTENCHANTHOLE");
		end
	end


	if ( bEnable == true)  then
	
		local nWeaponType = gamefunc:GetItemWeaponType( nID);
		if ( nWeaponType > 0)  then
		
			for i = 0, ( gamefunc:GetItemUnchantableWeaponTypeCount( nEnchantStoneID) - 1)  do
			
				if ( nWeaponType == gamefunc:GetItemUnchantableWeaponType( nEnchantStoneID, i))  then
				
					bEnable = false;
					strMessage = STR( "UI_ENCHANT_INVALIDITEM");
					break;
				end
			end
		end
	end
	
	
	if ( bEnable == true)  then
	
		local nArmorType = gamefunc:GetItemArmorType( nID);
		if ( nArmorType > 0)  then

			for i = 0, ( gamefunc:GetItemUnchantableArmorSlotCount( nEnchantStoneID) - 1)  do
			
				if ( nArmorType == gamefunc:GetItemUnchantableArmorType( nEnchantStoneID, i))  then
				
					bEnable = false;
					strMessage = STR( "UI_ENCHANT_INVALIDITEM");
					break;
				end
			end
		end
	end
	
	

	if ( bEnable == true)  then
	
		DragEventArgs:SetItemText( 0, STR( "UI_ENCHANT_AVAILABLEENCHANT"));
		DragEventArgs:SetColor( 255, 255, 255);
		
	else
	
		DragEventArgs:SetItemText( 0, strMessage);
		DragEventArgs:SetColor( 255, 64, 64);
	end
end





-- OpenEnchantItem
function luaEnchant:OpenEnchantItem( nIndex)

	-- Check validate
	if ( luaEnchant.m_bEnchanting == true)  or  ( nIndex < 0)  then  return;
	end

	local nEnchantStoneID = gamefunc:GetInvenItemID( nIndex);
	local nEnchantStoneType = gamefunc:GetItemEnchantType( nEnchantStoneID);
	if ( gamefunc:GetItemType( nEnchantStoneID) ~= ITEM_TYPE.ENCHANT)  or
		( ( nEnchantStoneType ~= ENCHANT_TYPE.STONE)  and  ( nEnchantStoneType ~= ENCHANT_TYPE.SPECIALSTONE))  then	
		return;
	end
	

	-- Open enchanting
	if ( gamefunc:OpenEnchantItem( nIndex) == false)  then  return;
	end


	-- Set variables
	luaEnchant.m_bEnchanting = true;
	luaEnchant.m_bPostCancelEnchant = true;
	luaEnchant.m_nTargetItemType = luaEnchant.ENCHANT_TYPE.NONE;
	luaEnchant.m_nTargetItemIndex = -1;
	luaEnchant.m_nEnchantStoneInvenIndex = nIndex;
	luaEnchant.m_nAgentItemID = 0;


	-- Begin drag item
	lcInventory:AttachDragItem( "", gamefunc:GetItemImage( nEnchantStoneID), nIndex);
	DragEventArgs:SetFont( "fntScriptStrong");
	DragEventArgs:SetHotSpot( 20, 20);
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetOpacity( 0.8);


	-- Set timer
	frmEnchant:SetTimer( 100, 0);
end





-- CloseEnchantItem
function luaEnchant:CloseEnchantItem()

	-- Kill timer
	frmEnchant:KillTimer();
	
	
	-- Cancel enchanting
	if ( luaEnchant.m_bEnchanting == false)  then
	
		-- Post cancel
		if ( luaEnchant.m_bPostCancelEnchant == true)  then
		
			luaEnchant.m_bPostCancelEnchant = false;
			
			gamefunc:CancelEnchantItem();
		end
	end
end





-- OpenEnchantFrame
function luaEnchant:OpenEnchantFrame( nTargetType, nTargetIndex)

	-- Check validate
	if ( frmEnchant:GetShow() == true)  or  ( luaEnchant.m_bEnchanting == false)  or  ( luaEnchant.m_nEnchantStoneInvenIndex < 0)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end


	-- Close enchant item
	luaEnchant:CloseEnchantItem();

	
	-- Set variables
	luaEnchant.m_nTargetItemType = nTargetType;
	luaEnchant.m_nTargetItemIndex = nTargetIndex;
	luaEnchant.m_nAgentItemID = 0;
	
	
	-- Get item ID
	local nItemID = 0;
	local nEnchantItemID = 0;
	if ( luaEnchant.m_nTargetItemType == luaEnchant.ENCHANT_TYPE.INVENTORY)  then
	
		if ( luaEnchant.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetInvenItemID( luaEnchant.m_nTargetItemIndex);
		end
	
	elseif ( luaEnchant.m_nTargetItemType == luaEnchant.ENCHANT_TYPE.EQUIPPED)  then

		if ( luaEnchant.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetEquippedItemID( luaEnchant.m_nTargetItemIndex);
		end
	end

	
	-- Get Enchant item ID
	nEnchantItemID = gamefunc:GetInvenItemID( luaEnchant.m_nEnchantStoneInvenIndex);
	if ( nEnchantItemID <= 0)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end
	
	

	-- Set target item image and tooltip
	picEnchantItem:SetImage( gamefunc:GetItemImage( nItemID));

	local strToolTip = "";
	if ( luaEnchant.m_nTargetItemType == luaEnchant.ENCHANT_TYPE.INVENTORY)  then	strToolTip = luaToolTip:GetItemToolTip( nItemID, luaEnchant.m_nTargetItemIndex, nil);
	else																			strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, luaEnchant.m_nTargetItemIndex);
	end
	picEnchantItem:SetToolTip( strToolTip);
	
	
	
	-- Set enchant stone images
	local nEnchantStoneType = gamefunc:GetItemEnchantType( nEnchantItemID);
	if ( nEnchantStoneType ~= ENCHANT_TYPE.STONE)  and  ( nEnchantStoneType ~= ENCHANT_TYPE.SPECIALSTONE)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end
	
	local nCount = gamefunc:GetItemEnchantHoleCount( nItemID);
	if ( nCount == 0)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end

	local nSelectedHole = nil;
	for i = 0, ( nCount - 1)  do
	
		local _slot = _G[ "picEnchantStoneSlot" .. i];
		local _wnd = _G[ "picEnchantStone" .. i];
		
		if ( _slot == nil)  or  ( _wnd == nil)  then  break;
		end
		
	
		-- Get enchant hole type and enchanted stone ID
		local nEnchantHoleType = ENCHANTHOLE_TYPE.NONE;
		local bEnchantHoleBroken = false;
		local nEnchantStoneID = 0;
		if ( luaEnchant.m_nTargetItemType == luaEnchant.ENCHANT_TYPE.INVENTORY)  then
		
			nEnchantHoleType = gamefunc:GetItemEnchantHoleType( gamefunc:GetInvenItemID( luaEnchant.m_nTargetItemIndex), i);
			nEnchantStoneID = gamefunc:GetInvenItemEnchantedStoneID( luaEnchant.m_nTargetItemIndex, i);
			
		elseif ( luaEnchant.m_nTargetItemType == luaEnchant.ENCHANT_TYPE.EQUIPPED)  then
		
			nEnchantHoleType = gamefunc:GetItemEnchantHoleType( gamefunc:GetEquippedItemID( luaEnchant.m_nTargetItemIndex), i);
			nEnchantStoneID = gamefunc:GetEquippedItemEnchantedStoneID( luaEnchant.m_nTargetItemIndex, i);
		end
		
		
		-- Brokened hole
		if ( nEnchantStoneID < 0)  then
		
			bEnchantHoleBroken = true;
			nEnchantStoneID = 0;
		end
		


		-- Get enchant slot image
		local strEnchantSlotImage = "";
		if  ( nEnchantHoleType == ENCHANTHOLE_TYPE.GENERAL)  then		strEnchantSlotImage = "bmpEnchantSlot";
		elseif ( nEnchantHoleType == ENCHANTHOLE_TYPE.SPECIAL)  then	strEnchantSlotImage = "bmpEnchantSlotS";
		end
		
		_slot:SetImage( strEnchantSlotImage);


		-- Get enchanted stone image and tooltip
		local strEnchantStoneImage = "";
		local strEnchantStoneToolTip = "";

		-- Unknown hole
		if ( nEnchantHoleType == ENCHANTHOLE_TYPE.NONE)  then
		
			_wnd:SetEffect( "normal");


		-- Brokened hole
		elseif ( bEnchantHoleBroken == true)  then
		
			_wnd:SetEffect( "normal");

			if  ( nEnchantHoleType == ENCHANTHOLE_TYPE.GENERAL)  then
		
				strEnchantStoneImage = "iconEnchantHoleBroken";
				strEnchantStoneToolTip = STR( "BROKENEDENCHANTSLOT");

			elseif ( nEnchantHoleType == ENCHANTHOLE_TYPE.SPECIAL)  then
		
				strEnchantStoneImage = "iconEnchantHoleBrokenS";
				strEnchantStoneToolTip = STR( "BROKENEDSPECIALENCHANTSLOT");
			end
		
		
		-- Enchanted hole
		else
		
			-- Empty hole
			if ( nEnchantStoneID == 0)  then
			
				_wnd:SetEffect( "normal");

				if ( nEnchantHoleType == ENCHANTHOLE_TYPE.GENERAL)  then
			
					strEnchantStoneImage = "iconEnchantHole";
					strEnchantStoneToolTip = STR( "ENCHANTSLOT");

					if ( nEnchantStoneType ~= ENCHANT_TYPE.SPECIALSTONE)  then  nSelectedHole = i;
					end

				elseif ( nEnchantHoleType == ENCHANTHOLE_TYPE.SPECIAL)  then
				
					strEnchantStoneImage = "iconEnchantHoleS";
					strEnchantStoneToolTip = STR( "SPECIALENCHANTSLOT");
					
					if ( nEnchantStoneType == ENCHANT_TYPE.SPECIALSTONE)  then  nSelectedHole = i;
					end
				end


			-- Enchanted stone
			else
		
				_wnd:SetEffect( "add");

				strEnchantStoneImage = gamefunc:GetItemImage( nEnchantStoneID);
				strEnchantStoneToolTip = luaToolTip:GetItemToolTip( nEnchantStoneID, nil, nil);
			end
		end
		
		
		-- Set enchanted stone image and tooltip
		_wnd:SetImage( strEnchantStoneImage);
		_wnd:SetToolTip( strEnchantStoneToolTip);
	end
	
	
	
	-- Check remained hole
	if ( nSelectedHole == nil)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end
	
	
	-- Check Unchantable type
	local nWeaponType = gamefunc:GetItemWeaponType( nItemID);
	if ( nWeaponType > 0)  then
	
		for i = 0, ( gamefunc:GetItemUnchantableWeaponTypeCount( nEnchantItemID) - 1)  do
		
			if ( nWeaponType == gamefunc:GetItemUnchantableWeaponType( nEnchantItemID, i))  then
			
				luaEnchant:CloseEnchantFrame();
				return false;
			end
		end
	end
	
	local nArmorType = gamefunc:GetItemArmorType( nItemID);
	if ( nArmorType > 0)  then

		for i = 0, ( gamefunc:GetItemUnchantableArmorSlotCount( nEnchantItemID) - 1)  do
		
			if ( nArmorType == gamefunc:GetItemUnchantableArmorType( nEnchantItemID, i))  then
			
				luaEnchant:CloseEnchantFrame();
				return false;
			end
		end
	end
	
	
	-- Reposition enchant holes
	local x, y, w, h = picEnchantItem:GetRect();
	x = x + ( w * 0.5);
	y = y + ( h * 0.5);

	local fDelta = ( 2.0 * 3.141) / nCount;
	local fRadian = 0.0 - ( fDelta * nSelectedHole);
	
	for i = 0, ( luaEnchant.MAX_ENCHANTHOLE - 1)  do
	
		if ( i < nCount)  then

			local px = x + 100.0 * math.sin( fRadian);
			local py = y + 100.0 * math.cos( fRadian);
		
			local _wnd = _G[ "picEnchantStoneSlot" .. i];
			local pw, ph = _wnd:GetSize();
			_wnd:SetPosition( px - (pw / 2), py - (ph / 2));
			_wnd:Show( true);


			local _wnd = _G[ "picEnchantStone" .. i];
			local pw, ph = _wnd:GetSize();
			_wnd:SetPosition( px - (pw / 2), py - (ph / 2));
			_wnd:Show( true);
			

			fRadian = fRadian + fDelta;
			
			
		else
		
			local _wnd = _G[ "picEnchantStoneSlot" .. i];
			_wnd:Show( false);

			local _wnd = _G[ "picEnchantStone" .. i];
			_wnd:Show( false);
		end
	end

	

	-- Enchant stone item
	picEnchantStoneItem:SetImage( gamefunc:GetItemImage( nEnchantItemID));

	local strToolTip = luaToolTip:GetItemToolTip( nEnchantItemID, nil, nil);
	picEnchantStoneItem:SetToolTip( strToolTip);



	-- Enchant agent item
	local nAgentIndex = 0;
	local nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemEnchantAgentIDRange( nEnchantItemID);
	for  i = nAgentIDBegin, nAgentIDEnd  do
	
		if ( gamefunc:GetInvenItemQuantityByID( i) > 0)  then
		
			-- Set default agent item
			if ( luaEnchant.m_nAgentItemID == 0)  then  luaEnchant.m_nAgentItemID = i;
			end
			

			-- Set popup menus
			local strName = gamefunc:GetItemName( i);
			local strImage = gamefunc:GetItemImage( i);
		
			local _wnd = _G[ "btnEnchantAgentItem" .. nAgentIndex];
			_wnd:SetText( strName);
			_wnd:SetIcon( strImage);
			_wnd:SetUserData( i);
			
			nAgentIndex = nAgentIndex + 1;
		end
	end
	
	
	-- Set agent popup menu
	if ( nAgentIndex > 0)  then

		local w, h = pmEnchantAgentItem:GetSize();
		pmEnchantAgentItem:SetSize( w, nAgentIndex * 35);

		btnSelAgentItem:Enable( true);

	else
	
		btnSelAgentItem:Enable( false);
	end
	
	
	
	-- Refresh agent item
	luaEnchant:RefreshControls();


	-- Begin enchanting
	if ( gamefunc:BeginEnchantItem( luaEnchant.m_nTargetItemType, luaEnchant.m_nTargetItemIndex, luaEnchant.m_nEnchantStoneInvenIndex) == false)  then
	
		luaEnchant:CloseEnchantFrame();
		return false;
	end


	-- Show frame
	local x, y = frmEnchant:GetParent():GetPosition();
	local w, h = frmEnchant:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmEnchant:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmEnchant:DoModal();
	
	
	-- Hide progress bar
	frmEnchantProgress:Show( false);
	
	
	return true;
end





-- CloseEnchantFrame
function luaEnchant:CloseEnchantFrame()

	-- Set variables
	luaEnchant.m_bEnchanting = false;


	-- Close enchant item
	luaEnchant:CloseEnchantItem();
	
	
	-- Hide frame
	frmEnchant:Show( false);


	-- Hide progress bar
	frmEnchantProgress:Show( false);
end





-- RefreshControls
function luaEnchant:RefreshControls()

	-- Set agent image
	local strAgentImage = "";
	if ( luaEnchant.m_nAgentItemID > 0)  then  strAgentImage = gamefunc:GetItemImage( luaEnchant.m_nAgentItemID);
	end
	
	picEnchantAgentItem:SetImage( strAgentImage);
	
	
	-- Check validate enchanting
	local bEnchantable = true;
	local strSuccessRatio = "";
	local strMessage = "";
	
	if ( luaEnchant.m_nAgentItemID > 0)  then
	
		picEnchantArrowRight:Show( true);
		
		picEnchantAgentItem:SetImage( gamefunc:GetItemImage( luaEnchant.m_nAgentItemID));
		picEnchantAgentItem:SetToolTip( luaToolTip:GetItemToolTip( luaEnchant.m_nAgentItemID, nil, nil));
		picEnchantAgentItem:Enable( true);
		
	else
	
		picEnchantArrowRight:Show( false);
		
		picEnchantAgentItem:SetImage( "");
		picEnchantAgentItem:SetToolTip( STR( "ENCHANTAGENT"));
		picEnchantAgentItem:Enable( false);


		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "ENCHANTINGSUCCESSRATE") .. "{CR}" .. 
			"{FONT name=\"fntLargeStrong\"}" .. 0 .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefStop\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_ENCHANT_ENCHANTINGMSG1");
		tvwEnchantMessage:SetText( strText);

		bEnchantable = false;
	end
	
		
	if ( gamefunc:GetItemEnchantLevel( gamefunc:GetInvenItemID( luaEnchant.m_nEnchantStoneInvenIndex)) <= gamefunc:GetLevel())  then
	
		picEnchantArrowLeft:Show( true);

	else
	
		picEnchantArrowLeft:Show( false);

		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "ENCHANTINGSUCCESSRATE") .. "{CR}" .. 
			"{FONT name=\"fntLargeStrong\"}" .. 0 .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefStop\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_ENCHANT_ENCHANTINGMSG2");
		
		bEnchantable = false;
	end


	if ( bEnchantable == true)  then
	
		picEnchantTargetSlot:Show( true);
	
		local fSuccessRatio = gamefunc:GetEnchantSuccessPercent( gamefunc:GetInvenItemID( luaEnchant.m_nEnchantStoneInvenIndex) );
		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScript\"}{COLOR r=180 g=180 b=180}" .. STR( "ENCHANTINGSUCCESSRATE") .. "{CR}" ..
			"{FONT name=\"fntLargeStrong\"}" .. math.floor( fSuccessRatio) .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_ENCHANT_ENCHANTINGMSG3");
			
	else
	
		picEnchantTargetSlot:Show( false);
	end
	
	
	tvwEnchantSuccessRatio:SetText( strSuccessRatio);
	tvwEnchantMessage:SetText( strMessage);

	btnDoEnchanting:Enable( bEnchantable);
end





-- OnClickPopupAgentItem
function luaEnchant:OnClickPopupAgentItem()

	btnSelAgentItem:TrackPopupMenu( "pmEnchantAgentItem");
end





-- OnClickSelectAgentItem
function luaEnchant:OnClickSelectAgentItem()

	local _owner = EventArgs:GetOwner();
	local _wnd = _G[ _owner:GetName()];
	
	local nID = _wnd:GetUserData();
	if ( nID <= 0)  then  return;
	end
	
	
	luaEnchant.m_nAgentItemID = nID;
	
	
	luaEnchant:RefreshControls();
end





-- OnClickDoEnchanting
function luaEnchant:OnClickDoEnchanting()

	if ( luaEnchant.m_bEnchanting == false)  then  return;
	end
	

	-- Set variables
	luaEnchant.m_bPostCancelEnchant = false;


	-- Hide frame
	frmEnchant:Show( false);
	

	-- Reset progress bar
	luaEnchant.m_fProgressBarTimer = gamefunc:GetUpdateTime();
	pcEnchantProgress:SetPos( 0);
	
	
	-- Reposition frame
	local x, y = frmEnchantProgress:GetParent():GetPosition();
	local w, h = frmEnchantProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmEnchantProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmEnchantProgress:DoModal();
	
	
	-- Do enchanting
	luaEnchant:DoEnchanting();
end









function luaEnchant:OnShowEnchantProgress()

	-- Show
	if ( frmEnchantProgress:GetShow() == true)  then
	
	
	-- Hide
	else

		-- 중간에 취소
		if ( luaEnchant.m_fProgressBarTimer ~= nil)  then
		
			gamefunc:CancelEnchantItem();
		end
	end
end









-- OnUpdateEnchantProgressBar
function luaEnchant:OnUpdateEnchantProgressBar()

	if ( luaEnchant.m_fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaEnchant.m_fProgressBarTimer + 100;
	local nPos = fElapsed / 30.0;
	pcEnchantProgress:SetPos( nPos);
	
	
	if ( nPos >= 100)  then  luaEnchant.m_fProgressBarTimer = nil;
	end
end





-- DoEnchanting
function luaEnchant:DoEnchanting()

	-- Find inventory index of agent
	local nAgentIndex = -1;
	for  i = 0, ( gamefunc:GetInvenItemMaxCount() - 1)  do
	
		local nID = gamefunc:GetInvenItemID( i);
		if ( nID == luaEnchant.m_nAgentItemID)  then
		
			nAgentIndex = i;
			break;
		end
	end
	

	if ( nAgentIndex < 0)  then  return;
	end
	
	
	gamefunc:DoEnchantingItem( luaEnchant.m_nTargetItemType, luaEnchant.m_nTargetItemIndex, nAgentIndex);
end
