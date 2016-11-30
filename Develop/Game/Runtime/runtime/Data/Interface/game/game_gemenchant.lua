--[[
	Game GemEnchant LUA script
--]]


-- Global instance
luaGemEnchant = {};


-- Type of target item
luaGemEnchant.TARGET_TYPE				= { NONE = 0,  INVENTORY = 1,  EQUIPPED = 2 };

luaGemEnchant.GEMENCHANT_TYPE			= { TYPE_INVALIDITEM = 0, TYPE_SELECTITEM = 1, TYPE_NOTEXISTGEMHOLE = 2, TYPE_LIMITLEVEL = 3, TYPE_NOTTYPEGEMHOLE = 4, TYPE_NOTAGENT = 5, TYPE_AVAILABLE = 6 };

-- Maximum value of GemEnchant slot
luaGemEnchant.MAX_GEMENCHANTSLOT			= 5;


-- Variables of GemEnchant
luaGemEnchant.m_bGemEnchant				= false;
luaGemEnchant.m_bPostCancelGemEnchant	= false;
luaGemEnchant.m_nTargetItemType			= luaGemEnchant.TARGET_TYPE.NONE;
luaGemEnchant.m_nTargetItemIndex		= -1;
luaGemEnchant.m_nGemEnchantInvenIdx		= -1;
luaGemEnchant.m_nAgentItemID			= 0;
luaGemEnchant.m_nGemItemType			= ITEM_TYPE.GEMENCHANT;
luaGemEnchant.m_nSeleteGemSlotIndex		= -1;
luaGemEnchant.m_nSeleteGemSlotItemID	= -1;


-- Progress bar timer
luaGemEnchant.m_fProgressBarTimer		= nil;





-- OnShowGemEnchantFrame
function luaGemEnchant:OnShowGemEnchantFrame()

	-- Show
	if ( frmGemEnchant:GetShow() == true)  then
	
	-- Hide
	else
		
		luaGemEnchant:CloseGemEnchantFrame();
		
	end
end

-- CheckGemEnchantable
function luaGemEnchant:CheckGemEnchantable( nIndex, nID, nType )

	local nGemEnchantGemID	= gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx );
	
	--[[
	1. 장비인지 아닌지 체크 : 무기, 방어구, 장신구에만 보석 강화가 가능합니다.
	2. 사용 가능한 보석 장착 슬롯이 있는지 체크(보석강화) : 사용 가능한 보석 강화 슬롯이 없습니다.
	2_1. 제거 가능한 보석 장착 슬롯이 있는지 체크(보석제거) : 제거 가능한 보석이 없습니다.
	2_2. 추출 가능한 보석 장착 슬롯이 있는지 체크(보석추출) : 추출 가능한 보석이 없습니다.
	3. 보석 강화 가능한 장비 레벨인지 체크(보석강화만) : 장비의 착용 제한 레벨이 높아 장착할 수 없습니다.
	4. 보석 강화 가능한 장비 종류인지 체크(보석강화만) : 이 보석을 장착할 수 없는 부위의 장비입니다.
	5. 보석 강화제가 있는지 체크(보석강화만) : 보석 강화에 사용 가능한 보석 강화제가 없습니다.
	]]--
	
	-- 1. 장비인지 아닌지 체크 : 무기, 방어구, 장신구에만 보석 강화가 가능합니다.
	local nItemType		= gamefunc:GetItemType( nID );
	if( ( ITEM_TYPE.WEAPON == nItemType ) or ( ITEM_TYPE.ARMOR == nItemType ) or ( ITEM_TYPE.LOOK == nItemType ) )	then
		
		-- 2. 사용 가능한 보석 장착 슬롯이 있는지 체크 : 사용 가능한 보석 강화 슬롯이 없습니다.
		-- 2_1. 제거 가능한 보석 장착 슬롯이 있는지 체크(보석제거) : 제거 가능한 보석이 없습니다.
		-- 2_2. 제거 가능한 보석 장착 슬롯이 있는지 체크(보석추출) : 추출 가능한 보석이 없습니다.
		local bHoldCheck			= false;
		local nGemEnchantGemType	= gamefunc:GetItemGemEnchantType( nGemEnchantGemID );
		local nCount				= gamefunc:GetItemGemEnchantHoleCount( nID );
		if( 0 < nCount )	then
				
			for i = 0, ( nCount - 1 )  do
					
				local nGemEnchantHoleType	= ENCHANT_CATEGORY.EC_NONE;
				local nGemEnchantGemID		= 0;
					
				if( nType == luaGemEnchant.TARGET_TYPE.INVENTORY )  then
				
					nGemEnchantHoleType	= gamefunc:GetItemGemEnchantHoleType( gamefunc:GetInvenItemID( nIndex ), i );
					nGemEnchantGemID	= gamefunc:GetInvenItemGemEnchantedStoneID( nIndex, i );
					
				elseif( nType == luaGemEnchant.TARGET_TYPE.EQUIPPED )  then
				
					nGemEnchantHoleType = gamefunc:GetItemGemEnchantHoleType( gamefunc:GetEquippedItemID( nIndex ), i );
					nGemEnchantGemID	= gamefunc:GetEquippedItemGemEnchantedStoneID( nIndex, i );
					
				end
				
				if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
					if( 0 == nGemEnchantGemID )  and  ( nGemEnchantGemType == nGemEnchantHoleType )  then
						bHoldCheck = true;
						break;
					end
				
				elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) or (luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
					if( 0 < nGemEnchantGemID ) then
						bHoldCheck = true;
						break;
					end
				end
				
			end
			
		end
			
		if( false == bHoldCheck )  then
			
			return luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTEXISTGEMHOLE;
		end
		

		-- 3, 4, 5 은 보석 강화일때만 검사
		if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then 

		-- 3. 보석 강화 가능한 장비 레벨인지 체크 : 장비의 착용 제한 레벨이 높아 장착할 수 없습니다.
		if( gamefunc:GetItemGemEnchantLevel( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx )) > gamefunc:GetItemEquipReqLevel( nID ) )	then
		
			return luaGemEnchant.GEMENCHANT_TYPE.TYPE_LIMITLEVEL;
		
		end
		-- 3. 보석 강화 가능한 장비 레벨인지 체크 : 장비의 착용 제한 레벨이 높아 장착할 수 없습니다.(종료)
		
		-- 4. 보석 강화 가능한 장비 종류인지 체크 : 이 보석을 장착할 수 없는 부위의 장비입니다.
		if(luaGemEnchant:CheckAllowEquipMents(nID, nGemEnchantGemID) ~= true) and
			(luaGemEnchant:CheckAllowWeapon(nID, nGemEnchantGemID) ~= true) and
			(luaGemEnchant:CheckAllowArmors(nID, nGemEnchantGemID) ~= true) then
			
			return luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTTYPEGEMHOLE;
		end
		-- 4. 보석 강화 가능한 장비 종류인지 체크 : 이 보석을 장착할 수 없는 부위의 장비입니다.(종료)

	
		-- 5. 보석 강화제가 있는지 체크 : 보석 강화에 사용 가능한 보석 강화제가 없습니다.
		-- 강화제 유/무 체크
		local nAgentIDBegin, nAgentIDEnd;
		if( nType == luaGemEnchant.TARGET_TYPE.INVENTORY )			then
				
			nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemGemEnchantAgentIDRange( gamefunc:GetInvenItemID( nIndex ) );
					
		elseif( nType == luaGemEnchant.TARGET_TYPE.EQUIPPED )		then
			
			nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemGemEnchantAgentIDRange( gamefunc:GetEquippedItemID( nIndex ) );
			
		end
	
		local bAgent		= false;
		local nTempIndex	= 0;
		for  i = nAgentIDBegin, nAgentIDEnd  do
	
			if ( gamefunc:GetInvenItemQuantityByIDFromInvenIndex(0, i) > 0)  then
				
				bAgent		= true;
				nTempIndex	= i;
				
			end
			
			if	(gamefunc:IsExInventory() == true)	then

				if ( gamefunc:GetInvenItemQuantityByIDFromInvenIndex(1, i) > 0)  then
					
					bAgent		= true;
					nTempIndex	= i;
					
				end
			
			end
			
		end
	
		if( false == bAgent )	then
			
			-- 강화제 없음
			return luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTAGENT;
			
		end
		-- 5. 보석 강화제가 있는지 체크 : 보석 강화에 사용 가능한 보석 강화제가 없습니다.(종료)

		end
		-- 3, 4, 5 은 보석 강화일때만 검사(종료)
					
	else
		
		return luaGemEnchant.GEMENCHANT_TYPE.TYPE_INVALIDITEM;
		
	end
	
	return luaGemEnchant.GEMENCHANT_TYPE.TYPE_AVAILABLE;
		
end

function luaGemEnchant:CheckAllowEquipMents(nID, nGemEnchantGemID)

	local nSlotType = gamefunc:GetItemSlot( nID );
	local TypeCount = gamefunc:GetItemEnchantableEquipSlotCount( nGemEnchantGemID )
				
	for i = 0, TypeCount- 1  do
		if( nSlotType == gamefunc:GetItemEnchantableEquipSlot( nGemEnchantGemID, i))  then
			return true;
		end
	end

	return false;
end

function luaGemEnchant:CheckAllowWeapon(nID, nGemEnchantGemID)
		
	local nWeaponType	= gamefunc:GetItemWeaponType( nID );
	local TypeCount		= gamefunc:GetItemEnchantableWeaponTypeCount( nGemEnchantGemID );
	
	for i = 0, TypeCount - 1 do
		if( nWeaponType == gamefunc:GetItemEnchantableWeaponType( nGemEnchantGemID, i ) )  then
			return true;
		end
	end

	return false;
end

function luaGemEnchant:CheckAllowArmors(nID, nGemEnchantGemID)

	local nArmorType	= gamefunc:GetItemArmorType( nID );
	local TypeCount		= gamefunc:GetItemEnchantableArmorTypeCount( nGemEnchantGemID )
						
	for i = 0, TypeCount- 1  do
		if( nArmorType == gamefunc:GetItemEnchantableArmorType( nGemEnchantGemID, i ) )  then
			return true;
		end
	end

	return false;
end


-- OnTimerGemEnchantFrame
function luaGemEnchant:OnTimerGemEnchantFrame()

	local nID				= 0;
	local nIndex			= -1;
	local nType				= luaGemEnchant.TARGET_TYPE.NONE;
	local nResult			= luaGemEnchant.GEMENCHANT_TYPE.TYPE_INVALIDITEM;
	
	if ( lcInventory:IsMouseIncluded() == true)  then
	
		-- 인벤 아이템
		local nCurSel = lcInventory:GetMouseOver();
		if ( nCurSel >= 0) then
			nIndex = lcInventory:GetItemData( nCurSel);
			nType	= luaGemEnchant.TARGET_TYPE.INVENTORY;
			if ( nIndex >= 0)  then  nID = gamefunc:GetInvenItemID( nIndex);
			end
		end

	elseif ( lcExInventory:IsMouseIncluded() == true)  then
	
		-- 확장 인벤 아이템
		local nCurSel = lcExInventory:GetMouseOver();
		if ( nCurSel >= 0) then
			nIndex = lcExInventory:GetItemData( nCurSel);
			nType	= luaGemEnchant.TARGET_TYPE.INVENTORY;
			if ( nIndex >= 0)  then  nID = gamefunc:GetInvenItemID( nIndex);
			end
		end		
	else
	
		-- 착용중 아이템
		local _slots = { isFaceDeco, isHead, isBody, isHands, isLeg, isFeet, isNecklace, isEarring, isRingR, isRingL, isWeapon1, isWeapon1Sub, isWeapon2, isWeapon2Sub,
			isLookHead, isLookBody, isLookHands, isLookLeg, isLookFeet, isLookWeapon1, isLookWeapon2, isLookWeapon1Sub, isLookWeapon2Sub };
		for i, _slot  in pairs( _slots)  do
		
			if ( _slot:IsMouseIncluded() == true)  then
			
				nID		= _slot:GetItemID();
				nIndex	= _slot:GetSlotType();
				nType	= luaGemEnchant.TARGET_TYPE.EQUIPPED;
			end
		end
	end
	

	if ( nID <= 0)  then
		-- 선택 아이템 없음	
		nResult		= luaGemEnchant.GEMENCHANT_TYPE.TYPE_SELECTITEM;
	else
		
		nResult	= luaGemEnchant:CheckGemEnchantable( nIndex, nID, nType );

	end

	-- 확장인벤 검사
	if	(nIndex >= 80 and gamefunc:IsExInventory() == false)	then
		return;
	end
	
	-- 최종 메세지 처리
	if( luaGemEnchant.GEMENCHANT_TYPE.TYPE_AVAILABLE == nResult )				then
		
		if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_AVAILABLEGEMENCHANT") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_AVAILABLEGEMREMOVE") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_AVAILABLEGEMEXTRACT") );
		end
		
		DragEventArgs:SetColor( 255, 255, 255);
	
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_SELECTITEM == nResult )			then
		
		if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_SELECTITEM") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_SELECTITEMREMOVE") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_SELECTITEMEXTRACT") );
		end

		DragEventArgs:SetColor( 255, 64, 64);
		
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_INVALIDITEM == nResult )			then
		
		if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_INVALIDITEM") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_INVALIDITEMREMOVE") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_INVALIDITEMEXTRACT") );
		end
		
		DragEventArgs:SetColor( 255, 64, 64);
	
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTEXISTGEMHOLE == nResult )		then
		
		if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_NOTEXISTGEMHOLE") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_NOTREMOVEGEM") );
		elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
			DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_NOTEXTRACTGEM") );
		end
		
		DragEventArgs:SetColor( 255, 64, 64);
	
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTTYPEGEMHOLE == nResult )		then
		
		DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_NOTTYPEGEMHOLE") );
		DragEventArgs:SetColor( 255, 64, 64);
		
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_LIMITLEVEL == nResult )			then
		
		DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_MSG2") );
		DragEventArgs:SetColor( 255, 64, 64);
		
	elseif( luaGemEnchant.GEMENCHANT_TYPE.TYPE_NOTAGENT == nResult )			then
		
		DragEventArgs:SetItemText( 0, STR( "UI_GEMENCHANT_MSG1") );
		DragEventArgs:SetColor( 255, 64, 64);
		
	end

end





-- OpenGemEnchantItem
function luaGemEnchant:OpenGemEnchantItem( nIndex, nType)

	-- Check validate
	if ( luaGemEnchant.m_bGemEnchant == true)  or  ( nIndex < 0)  then  return;
	end
	
	local nGemEnchantGemID = gamefunc:GetInvenItemID( nIndex);
	if ( gamefunc:GetItemType( nGemEnchantGemID ) ~= nType ) then	return;
	end

	if ( nType == ITEM_TYPE.GEMENCHANT) then
		local nGemEnchantGemType = gamefunc:GetItemGemEnchantType( nGemEnchantGemID );
		if ( nGemEnchantGemType ~= ENCHANT_CATEGORY.EC_NORMAL )  and  ( nGemEnchantGemType ~= ENCHANT_CATEGORY.EC_SPECIAL )  then	return;
		end
	end
	
	-- Open GemEnchant
	if ( gamefunc:OpenGemEnchantItem( nIndex) == false)  then  return;
	end
	
	-- Set variables
	luaGemEnchant.m_bGemEnchant				= true;
	luaGemEnchant.m_bPostCancelGemEnchant	= true;
	luaGemEnchant.m_nTargetItemType			= luaGemEnchant.TARGET_TYPE.NONE;
	luaGemEnchant.m_nTargetItemIndex		= -1;
	luaGemEnchant.m_nGemEnchantInvenIdx		= nIndex;
	luaGemEnchant.m_nAgentItemID			= 0;
	luaGemEnchant.m_nGemItemType			= nType;
	luaGemEnchant.m_nSeleteGemSlotIndex		= -1;
	luaGemEnchant.m_nSeleteGemSlotItemID	= -1;


	-- Begin drag item
	lcInventory:AttachDragItem( "", gamefunc:GetItemImage( nGemEnchantGemID ), nIndex);
	DragEventArgs:SetFont( "fntScriptStrong");
	DragEventArgs:SetHotSpot( 20, 20);
	DragEventArgs:SetImageSize( 40, 40);
	DragEventArgs:SetOpacity( 0.8);


	-- Set timer
	frmGemEnchant:SetTimer( 100, 0);

end





-- CloseGemEnchantItem
function luaGemEnchant:CloseGemEnchantItem()

	-- Kill timer
	frmGemEnchant:KillTimer();
	
	
	-- Cancel Doing GemEnchant
	if ( luaGemEnchant.m_bGemEnchant == false)  then
	
		-- Post cancel
		if ( luaGemEnchant.m_bPostCancelGemEnchant == true)  then
		
			luaGemEnchant.m_bPostCancelGemEnchant = false;
			
			gamefunc:CancelGemEnchantItem();
		end
	end
end





-- OpenGemEnchantFrame
function luaGemEnchant:OpenGemEnchantFrame( nTargetType, nTargetIndex)

	-- Check validate
	if ( frmGemEnchant:GetShow() == true)  or  ( luaGemEnchant.m_bGemEnchant == false)  or  ( luaGemEnchant.m_nGemEnchantInvenIdx < 0)  then
	
		luaGemEnchant:CloseGemEnchantFrame();
		return false;
	end
	
	-- Close GemEnchant item
	luaGemEnchant:CloseGemEnchantItem();

	
	-- Set variables
	luaGemEnchant.m_nTargetItemType = nTargetType;
	luaGemEnchant.m_nTargetItemIndex = nTargetIndex;
	luaGemEnchant.m_nAgentItemID = 0;
	
	
	-- Get item ID
	local nItemID = 0;
	local nGemEnchantItemID = 0;
	if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then
	
		if ( luaGemEnchant.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetInvenItemID( luaGemEnchant.m_nTargetItemIndex);
		end
	
	elseif ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.EQUIPPED)  then

		if ( luaGemEnchant.m_nTargetItemIndex >= 0)  then  nItemID = gamefunc:GetEquippedItemID( luaGemEnchant.m_nTargetItemIndex);
		end
	end
	
	-- 확장인벤 검사
	if	(nTargetIndex >= 80 and gamefunc:IsExInventory() == false)	then
		return;
	end

	-- 보석 제련 가능 여부 체크
	if( luaGemEnchant.GEMENCHANT_TYPE.TYPE_AVAILABLE ~= luaGemEnchant:CheckGemEnchantable( nTargetIndex, nItemID, nTargetType ) )	then
		return false;
	end

	
	-- Get GemEnchant item ID
	nGemEnchantItemID = gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx );
	if ( nGemEnchantItemID <= 0)  then
	
		luaGemEnchant:CloseGemEnchantFrame();
		return false;
	end
	
	-- Set target item image and tooltip
	picGemEnchantItem:SetImage( gamefunc:GetItemImage( nItemID));

	local strToolTip = "";
	if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then	strToolTip = luaToolTip:GetItemToolTip( nItemID, luaGemEnchant.m_nTargetItemIndex, nil);
	else																				strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, luaGemEnchant.m_nTargetItemIndex);
	end
	picGemEnchantItem:SetToolTip( strToolTip);
	
	
	
	-- Set GemEnchant Gem images
	local nGemEnchantGemType = gamefunc:GetItemGemEnchantType( nGemEnchantItemID );
	if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
		if ( nGemEnchantGemType ~= ENCHANT_CATEGORY.EC_NORMAL )  and  ( nGemEnchantGemType ~= ENCHANT_CATEGORY.EC_SPECIAL )  then
	
			luaGemEnchant:CloseGemEnchantFrame();
			return false;
		end	
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
		
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
		
	end
	
	
	local nCount = gamefunc:GetItemGemEnchantHoleCount( nItemID);
	if ( nCount == 0)  then
	
		luaGemEnchant:CloseGemEnchantFrame();
		return false;
	end

	local nSelectedHole = nil;
	for i = 0, ( nCount - 1)  do
	
		local _slot = _G[ "picGemEnchantGemSlot" .. i];
		local _wnd = _G[ "picGemEnchantStone" .. i];
		
		if ( _slot == nil)  or  ( _wnd == nil)  then  break;
		end
		
	
		-- Get GemEnchant hole type and GemEnchant stone ID
		local nGemEnchantHoleType = ENCHANT_CATEGORY.EC_NONE;
		local bGemEnchantHoleBroken = false;
		local nGemEnchantGemID = 0;
		if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then
		
			nGemEnchantHoleType = gamefunc:GetItemGemEnchantHoleType( gamefunc:GetInvenItemID( luaGemEnchant.m_nTargetItemIndex), i);
			nGemEnchantGemID = gamefunc:GetInvenItemGemEnchantedStoneID( luaGemEnchant.m_nTargetItemIndex, i);
			
		elseif ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.EQUIPPED)  then
		
			nGemEnchantHoleType = gamefunc:GetItemGemEnchantHoleType( gamefunc:GetEquippedItemID( luaGemEnchant.m_nTargetItemIndex), i);
			nGemEnchantGemID = gamefunc:GetEquippedItemGemEnchantedStoneID( luaGemEnchant.m_nTargetItemIndex, i);
		end
		
		
		-- Brokened hole
		if ( nGemEnchantGemID < 0)  then
		
			bGemEnchantHoleBroken = true;
			nGemEnchantGemID = 0;
		end
		


		-- Get GemEnchant slot image
		local strGemEnchantSlotImage = "";
		if  ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_NORMAL)  then		strGemEnchantSlotImage = "bmpEnchantSlot";
		elseif ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_SPECIAL)  then	strGemEnchantSlotImage = "bmpEnchantSlotS";
		end
		
		_slot:SetImage( strGemEnchantSlotImage );


		-- Get GemEnchant stone image and tooltip
		local strGemEnchantStoneImage = "";
		local strGemEnchantStoneToolTip = "";

		-- Unknown hole
		if ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_NONE)  then
		
			_wnd:SetEffect( "normal");


		-- Brokened hole
		elseif ( bGemEnchantHoleBroken == true)  then
		
			_wnd:SetEffect( "normal");

			if  ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_NORMAL)  then
		
				strGemEnchantStoneImage = "iconEnchantHoleBroken";
				strGemEnchantStoneToolTip = STR( "BROKENEDGEMENCHANTSLOT");

			elseif ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_SPECIAL)  then
		
				strGemEnchantStoneImage = "iconEnchantHoleBrokenS";
				strGemEnchantStoneToolTip = STR( "BROKENEDSPECIALGEMENCHANTSLOT");
			end
		
		
		-- GemEnchant hole
		else
		
			-- Empty hole
			if ( nGemEnchantGemID == 0)  then
				
				_wnd:SetEffect( "normal");

				if ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_NORMAL)  then
			
					strGemEnchantStoneImage = "iconEnchantHole";
					strGemEnchantStoneToolTip = STR( "GEMENCHANTSLOT");
						
					if ( nGemEnchantGemType == ENCHANT_CATEGORY.EC_NORMAL )  then  nSelectedHole = i;
					end

				elseif ( nGemEnchantHoleType == ENCHANT_CATEGORY.EC_SPECIAL)  then
				
					strGemEnchantStoneImage = "iconEnchantHoleS";
					strGemEnchantStoneToolTip = STR( "SPECIALGEMENCHANTSLOT");
					
					if ( nGemEnchantGemType == ENCHANT_CATEGORY.EC_SPECIAL )  then  nSelectedHole = i;
					end
				end


			-- stone
			else
		
				_wnd:SetEffect( "add");

				strGemEnchantStoneImage = gamefunc:GetItemImage( nGemEnchantGemID );
				strGemEnchantStoneToolTip = luaToolTip:GetItemToolTip( nGemEnchantGemID, nil, nil);
			end
		end
		
		
		-- Set stone image and tooltip
		_wnd:SetImage( strGemEnchantStoneImage );
		_wnd:SetToolTip( strGemEnchantStoneToolTip );
	end

	if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) or (luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then 
		nSelectedHole = 0;
	end
	
	-- Check remained hole
	if ( nSelectedHole == nil)  then
	
		luaGemEnchant:CloseGemEnchantFrame();
		return false;
	end
	
	-- Check Unchantable type
	local nWeaponType = gamefunc:GetItemWeaponType( nItemID);
	if ( nWeaponType > 0)  then
	
		for i = 0, ( gamefunc:GetItemEnchantableWeaponTypeCount( nGemEnchantItemID ) - 1)  do
		
			local bFound = false;
			if ( nWeaponType == gamefunc:GetItemEnchantableWeaponType( nGemEnchantItemID, i))  then
				bFound = true;
			end
		end
		
		if (bFound == false) then
			luaGemEnchant:CloseGemEnchantFrame();
			return false;
		end
	end
	
	local nArmorType = gamefunc:GetItemArmorType( nItemID);
	if ( nArmorType > 0)  then

		for i = 0, ( gamefunc:GetItemEnchantableArmorTypeCount( nGemEnchantItemID ) - 1)  do
		
			local bFound = false;
			if ( nArmorType == gamefunc:GetItemEnchantableArmorType( nGemEnchantItemID, i))  then
				bFound = true;
			end
		end
		
		if (bFound == false) then
			luaGemEnchant:CloseGemEnchantFrame();
			return false;
		end
	end
	
	local nSlot = gamefunc:GetItemSlot( nItemID);
	if ( nSlot > 0)  then

		for i = 0, ( gamefunc:GetItemEnchantableEquipSlotCount( nGemEnchantItemID ) - 1)  do
		
			local bFound = false;
			if ( nSlot == gamefunc:GetItemEnchantableEquipSlot( nGemEnchantItemID, i))  then
				bFound = true;
			end
		end
		
		if (bFound == false) then
			luaGemEnchant:CloseGemEnchantFrame();
			return false;
		end
	end
	
	-- Reposition GemEnchant holes
	local x, y, w, h = picGemEnchantItem:GetRect();
	x = x + ( w * 0.5);
	y = y + ( h * 0.5);

	local fDelta = ( 2.0 * 3.141) / nCount;
	local fRadian = 0.0 - ( fDelta * nSelectedHole);
	
	for i = 0, ( luaGemEnchant.MAX_GEMENCHANTSLOT - 1)  do
	
		if ( i < nCount)  then

			local px = x + 100.0 * math.sin( fRadian);
			local py = y + 100.0 * math.cos( fRadian);
		
			local _wnd = _G[ "picGemEnchantGemSlot" .. i];
			local pw, ph = _wnd:GetSize();
			_wnd:SetPosition( px - (pw / 2), py - (ph / 2));
			_wnd:Show( true);


			local _wnd = _G[ "picGemEnchantStone" .. i];
			local pw, ph = _wnd:GetSize();
			_wnd:SetPosition( px - (pw / 2), py - (ph / 2));
			_wnd:Show( true);
			

			fRadian = fRadian + fDelta;
			
			
		else
		
			local _wnd = _G[ "picGemEnchantGemSlot" .. i];
			_wnd:Show( false);

			local _wnd = _G[ "picGemEnchantStone" .. i];
			_wnd:Show( false);
		end
	end

	

	-- GemEnchant stone item
	picGemEnchantGemItem:SetImage( gamefunc:GetItemImage( nGemEnchantItemID ));

	local strToolTip = luaToolTip:GetItemToolTip( nGemEnchantItemID, nil, nil);
	picGemEnchantGemItem:SetToolTip( strToolTip);



	-- GemEnchant agent item
	local nAgentIndex = 0;
	local nAgentIDBegin, nAgentIDEnd;
	--local nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemGemEnchantAgentIDRange( nGemEnchantItemID );
	
	if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then
	
		if ( luaGemEnchant.m_nTargetItemIndex >= 0)  then
			nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemGemEnchantAgentIDRange( gamefunc:GetInvenItemID( luaGemEnchant.m_nTargetItemIndex ) );
		end
	
	elseif ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.EQUIPPED)  then

		if ( luaGemEnchant.m_nTargetItemIndex >= 0)  then
			nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemGemEnchantAgentIDRange( gamefunc:GetEquippedItemID( luaGemEnchant.m_nTargetItemIndex ) );
		end
	end
	
	for  i = nAgentIDBegin, nAgentIDEnd  do
	
		if ( gamefunc:GetInvenItemQuantityByID( i) > 0)  then
		
			if( ( 0 == luaGemEnchant.m_nAgentItemID ) or ( luaGemEnchant.m_nAgentItemID > i ) )	then
				luaGemEnchant.m_nAgentItemID = i;
			end

			-- Set popup menus
			local strName = gamefunc:GetItemName( i);
			local strImage = gamefunc:GetItemImage( i);
		
			local _wnd = _G[ "btnGemEnchantAgentItem" .. nAgentIndex];
			_wnd:SetText( strName);
			_wnd:SetIcon( strImage);
			_wnd:SetUserData( i);
			
			nAgentIndex = nAgentIndex + 1;
		end
	end
	
	-- Set agent popup menu
	if ( nAgentIndex > 0)  then

		local w, h = pmGemEnchantAgentItem:GetSize();
		pmGemEnchantAgentItem:SetSize( w, nAgentIndex * 35);

		btnSelAgentItem:Show( true);
		btnSelAgentItem:Enable( true);

	else
	
		btnSelAgentItem:Enable( false);
	end
	
	
	
	-- Refresh agent item
	luaGemEnchant:RefreshControls();


	-- Begin GemEnchant
	if ( gamefunc:BeginGemEnchantItem( luaGemEnchant.m_nTargetItemType, luaGemEnchant.m_nTargetItemIndex, luaGemEnchant.m_nGemEnchantInvenIdx ) == false)  then
	
		luaGemEnchant:CloseGemEnchantFrame();
		return false;
	end

	-- Show frame
	local x, y = frmGemEnchant:GetParent():GetPosition();
	local w, h = frmGemEnchant:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmGemEnchant:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmGemEnchant:DoModal();
	
	
	-- Hide progress bar
	frmGemEnchantProgress:Show( false);
	
	
	return true;
end





-- CloseGemEnchantFrame
function luaGemEnchant:CloseGemEnchantFrame()

	-- Set variables
	luaGemEnchant.m_bGemEnchant = false;


	-- Close GemEnchant item
	luaGemEnchant:CloseGemEnchantItem();
	
	
	-- Hide frame
	frmGemEnchant:Show( false);


	-- Hide progress bar
	frmGemEnchantProgress:Show( false);
end





-- RefreshControls
function luaGemEnchant:RefreshControls()

	picGemEnchantAgentItem:Show( false);
	picGemEnchantArrowRight:Show( false);
	picGemEnchantArrowLeft:Show( false);
	picGemEnchantTargetSlot:Show( false);
	picGemEnchantSeleteSlot:Show( false);
	btnSelAgentItem:Show( false);

	picGemEnchantGemItem:Show( false);
	picGemEnchantAgentItem:Show( false);
	labGemEnchantAgentItem:Show( false);
	labGemEnchantGemItem:Show( false);

	btnDoingGemEnchant:Enable( false);

	tvwGemEnchantSuccessRatio:SetText("");
	tvwGemEnchantMessage:SetText("");

	if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
		luaGemEnchant:RefreshEnchantControls();
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
		luaGemEnchant:RefreshRemoveControls();
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
		luaGemEnchant:RefreshExtractControls();
	end
end


-- RefreshEnchantControls
function luaGemEnchant:RefreshEnchantControls()

	picGemEnchantBkgrnd:SetImage("bmpEnchantBkgrnd");

	frmGemEnchant:SetText( STR( "UI_GEMENCHANT"));
	btnDoingGemEnchant:SetText( STR( "UI_APPLY"));
	picGemEnchantGemItem:Show( true);
	picGemEnchantAgentItem:Show( true);
	labGemEnchantAgentItem:Show( true);
	labGemEnchantGemItem:Show( true);

	-- Set agent image
	local strAgentImage = "";
	if ( luaGemEnchant.m_nAgentItemID > 0)  then  strAgentImage = gamefunc:GetItemImage( luaGemEnchant.m_nAgentItemID);
	end
	
	picGemEnchantAgentItem:SetImage( strAgentImage);
	
	
	-- Check validate Do GemEnchant
	local bGemEnchantable = true;
	local strSuccessRatio = "";
	local strMessage = "";
	
	if ( luaGemEnchant.m_nAgentItemID > 0)  then
	
		picGemEnchantAgentItem:Show( true);
		picGemEnchantAgentItem:SetImage( gamefunc:GetItemImage( luaGemEnchant.m_nAgentItemID));
		picGemEnchantAgentItem:SetToolTip( luaToolTip:GetItemToolTip( luaGemEnchant.m_nAgentItemID, nil, nil));
		picGemEnchantAgentItem:Enable( true);
		
	else
	
		picGemEnchantArrowRight:Show( false);
		
		picGemEnchantAgentItem:Show( false);
		picGemEnchantAgentItem:SetImage( "");
		picGemEnchantAgentItem:SetToolTip( STR( "GEMENCHANTAGENT"));
		picGemEnchantAgentItem:Enable( false);


		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "GEMENCHANTSUCCESSRATE") .. "{CR}" .. 
			"{FONT name=\"fntLargeStrong\"}" .. 0 .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefStop\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_GEMENCHANT_MSG1");
		tvwGemEnchantMessage:SetText( strText);

		bGemEnchantable = false;
	end
	
		
	--if ( gamefunc:GetItemGemEnchantLevel( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx )) <= gamefunc:GetLevel())  then
	
	-- 보석 체크
	local nItemID;
	if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then
	
		nItemID			= gamefunc:GetInvenItemID( luaGemEnchant.m_nTargetItemIndex );
			
	elseif ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.EQUIPPED)  then
	
		nItemID = gamefunc:GetEquippedItemID( luaGemEnchant.m_nTargetItemIndex );

	end
	
	--gamedebug:Log( "무기 제한" .. gamefunc:GetItemEquipReqLevel( nItemID ) );
	--gamedebug:Log( "보석 제한" .. gamefunc:GetItemGemEnchantLevel( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx )) );
	
	if( gamefunc:GetItemGemEnchantLevel( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx )) <= gamefunc:GetItemEquipReqLevel( nItemID ) )	then
	
		picGemEnchantArrowLeft:Show( true);

	else
	
		picGemEnchantArrowLeft:Show( false);

		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "GEMENCHANTSUCCESSRATE") .. "{CR}" .. 
			"{FONT name=\"fntLargeStrong\"}" .. 0 .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefStop\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_GEMENCHANT_MSG2");
		
		bGemEnchantable = false;
		
	end
	
	--gamedebug:Log( "강화제 제한" .. gamefunc:GetItemGemEnchantLevel( luaGemEnchant.m_nAgentItemID ) );
	
	-- 강화제 체크
	if( gamefunc:GetItemGemEnchantLevel( luaGemEnchant.m_nAgentItemID ) >= gamefunc:GetItemEquipReqLevel( nItemID ) )	then
	
		picGemEnchantArrowRight:Show( true );
	else
		
		picGemEnchantArrowRight:Show( false );
		
		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "GEMENCHANTSUCCESSRATE") .. "{CR}" .. 
			"{FONT name=\"fntLargeStrong\"}" .. 0 .. "{/FONT}%";
		
		
		strMessage = "{BITMAP name=\"iconDefStop\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=170 g=60 b=50}" .. STR( "UI_GEMENCHANT_MSG4");
		bGemEnchantable = false;
		
	end


	if ( bGemEnchantable == true)  then
	
		picGemEnchantTargetSlot:Show( true);
	
		local fSuccessRatio = gamefunc:GetGemEnchantSuccessPercent( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx ) );
		strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScript\"}{COLOR r=180 g=180 b=180}" .. STR( "GEMENCHANTSUCCESSRATE") .. "{CR}" ..
			"{FONT name=\"fntLargeStrong\"}" .. math.floor( fSuccessRatio) .. "{/FONT}%";

		strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_GEMENCHANT_MSG3");
			
	else
		
		picGemEnchantTargetSlot:Show( false);
	end
	
	
	tvwGemEnchantSuccessRatio:SetText( strSuccessRatio);
	tvwGemEnchantMessage:SetText( strMessage);

	btnDoingGemEnchant:Enable( bGemEnchantable );
end


-- RefreshRemoveControls
function luaGemEnchant:RefreshRemoveControls()

	picGemEnchantBkgrnd:SetImage("bmpGemRemoveBkgrnd");

	frmGemEnchant:SetText( STR( "UI_GEMREMOVE"));
	btnDoingGemEnchant:SetText( STR( "UI_REMOVE"));

	local fSuccessRatio = gamefunc:GetGemEnchantSuccessPercent( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx ) );
	local strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScript\"}{COLOR r=180 g=180 b=180}" .. STR( "GEMREMOVESUCCESSRATE") .. "{CR}" ..
			"{FONT name=\"fntLargeStrong\"}" .. math.floor( fSuccessRatio) .. "{/FONT}%";
	local strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_GEMENCHANT_MSG5");

	tvwGemEnchantSuccessRatio:SetText( strSuccessRatio);
	tvwGemEnchantMessage:SetText( strMessage);	
end


-- RefreshExtractControls
function luaGemEnchant:RefreshExtractControls()

	picGemEnchantBkgrnd:SetImage("bmpGemRemoveBkgrnd");
	
	frmGemEnchant:SetText( STR( "UI_GEMEXTRACT"));
	btnDoingGemEnchant:SetText( STR( "UI_EXTRACT"));

	local fSuccessRatio = gamefunc:GetGemEnchantSuccessPercent( gamefunc:GetInvenItemID( luaGemEnchant.m_nGemEnchantInvenIdx ) );
	local strSuccessRatio = "{ALIGN hor=\"center\" ver=\"bottom\"}{FONT name=\"fntScript\"}{COLOR r=180 g=180 b=180}" .. STR( "GEMEXTRACTSUCCESSRATE") .. "{CR}" ..
			"{FONT name=\"fntLargeStrong\"}" .. math.floor( fSuccessRatio) .. "{/FONT}%";
	local strMessage = "{BITMAP name=\"iconDefInformation\" w=16 h=16}{FONT name=\"fntScriptStrong\"}{COLOR r=100 g=160 b=100}" .. STR( "UI_GEMENCHANT_MSG6");

	tvwGemEnchantSuccessRatio:SetText( strSuccessRatio);
	tvwGemEnchantMessage:SetText( strMessage);	
end



-- OnClickPopupAgentItem
function luaGemEnchant:OnClickPopupAgentItem()

	btnSelAgentItem:TrackPopupMenu( "pmGemEnchantAgentItem");
end





-- OnClickSelectAgentItem
function luaGemEnchant:OnClickSelectAgentItem()

	local _owner = EventArgs:GetOwner();
	local _wnd = _G[ _owner:GetName()];
	
	local nID = _wnd:GetUserData();
	if ( nID <= 0)  then  return;
	end
	
	
	luaGemEnchant.m_nAgentItemID = nID;
	
	
	luaGemEnchant:RefreshControls();
end





-- OnClickDoGemEnchant
function luaGemEnchant:OnClickDoGemEnchant()

	if ( luaGemEnchant.m_bGemEnchant == false)  then  return;
	end
	

	-- Set Progress Text
	if(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMENCHANT) then
		labGemEnchantDoingProgress:SetText( STR( "UI_GEMENCHANT_DOINGITEM"));
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMREMOVE) then
		labGemEnchantDoingProgress:SetText( STR( "UI_GEMENCHANT_DOINGITEM_REMOVE"));
	elseif(luaGemEnchant.m_nGemItemType == ITEM_TYPE.GEMEXTRACT) then
		labGemEnchantDoingProgress:SetText( STR( "UI_GEMENCHANT_DOINGITEM_EXTRACT"));
	end
	

	-- Set variables
	luaGemEnchant.m_bPostCancelGemEnchant = false;


	-- Hide frame
	frmGemEnchant:Show( false);
	

	-- Reset progress bar
	luaGemEnchant.m_fProgressBarTimer = gamefunc:GetUpdateTime();
	pcGemEnchantProgress:SetPos( 0);
	
	
	-- Reposition frame
	local x, y = frmGemEnchantProgress:GetParent():GetPosition();
	local w, h = frmGemEnchantProgress:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmGemEnchantProgress:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
	frmGemEnchantProgress:DoModal();
	
	
	-- Do GemEnchant
	luaGemEnchant:DoGemEnchant();
end








-- OnShowGemEnchantProgress
function luaGemEnchant:OnShowGemEnchantProgress()

	-- Show
	if ( frmGemEnchantProgress:GetShow() == true)  then
	
		--gamefunc:PlaySound( "progress_up", "progress_up" );
		
	-- Hide
	else
		
		gamefunc:StopSound( "progress_up" );
		
		-- 중간에 취소
		if ( luaGemEnchant.m_fProgressBarTimer ~= nil)  then
		
			gamefunc:CancelGemEnchantItem();
		end
	end
end









-- OnUpdateGemEnchantProgressBar
function luaGemEnchant:OnUpdateGemEnchantProgressBar()

	if ( luaGemEnchant.m_fProgressBarTimer == nil)  then  return;
	end
	
	
	local fElapsed = gamefunc:GetUpdateTime() - luaGemEnchant.m_fProgressBarTimer + 100;
	local nPos = fElapsed / 30.0;
	pcGemEnchantProgress:SetPos( nPos);
	
	
	if ( nPos >= 100)  then  luaGemEnchant.m_fProgressBarTimer = nil;
	end
end





-- DoGemEnchant
function luaGemEnchant:DoGemEnchant()

	-- Find inventory index of agent
	local nAgentIndex = -1;
	for  i = 0, ( gamefunc:GetInvenItemMaxCount() - 1)  do
	
		local nID = gamefunc:GetInvenItemID( i);
		if ( nID == luaGemEnchant.m_nAgentItemID)  then
		
			nAgentIndex = i;
			break;
		end
	end
	

	if ( nAgentIndex < 0)  then  return;
	end
	
	
	gamefunc:DoingGemEnchantItem( luaGemEnchant.m_nTargetItemType, luaGemEnchant.m_nTargetItemIndex, nAgentIndex, luaGemEnchant.m_nSeleteGemSlotIndex, luaGemEnchant.m_nSeleteGemSlotItemID);
end



-- OnClickGemSlot
function luaGemEnchant:OnClickGemSlot(nIndex)

	if(luaGemEnchant.m_nGemItemType ~= ITEM_TYPE.GEMREMOVE) and
		(luaGemEnchant.m_nGemItemType ~= ITEM_TYPE.GEMEXTRACT) then
		return;
	end

	local nGemEnchantGemID = 0;
	if ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.INVENTORY)  then
		
		nGemEnchantGemID = gamefunc:GetInvenItemGemEnchantedStoneID( luaGemEnchant.m_nTargetItemIndex, nIndex);
			
	elseif ( luaGemEnchant.m_nTargetItemType == luaGemEnchant.TARGET_TYPE.EQUIPPED)  then
		
		nGemEnchantGemID = gamefunc:GetEquippedItemGemEnchantedStoneID( luaGemEnchant.m_nTargetItemIndex, nIndex);
	end

	if(nGemEnchantGemID <= 0) then
		return;
	end


	luaGemEnchant.m_nSeleteGemSlotIndex	= nIndex;
	luaGemEnchant.m_nSeleteGemSlotItemID= nGemEnchantGemID;

	picGemEnchantSeleteSlot:Show( true);
	
	local _wnd = _G[ "picGemEnchantGemSlot" .. nIndex];
	local x, y = _wnd:GetPosition();
	picGemEnchantSeleteSlot:SetPosition( x, y );

	btnDoingGemEnchant:Enable( true);
end