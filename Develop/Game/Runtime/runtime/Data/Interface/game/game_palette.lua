--[[
	Game dock bar LUA script
--]]


-- Global instance
luaPalette = {};


-- Change motion
luaPalette.CHANGED = {};
luaPalette.CHANGED.run = false;
luaPalette.CHANGED.timer = 0;

-- BPartsPalette Mode
luaPalette.m_bBPartsPalette = false;

-- Palette Size
luaPalette.m_fSize = 0.0;





-- RefreshPaletteSlot
function luaPalette:RefreshPaletteSlot( bBpartsChanged, bIsBPartsPalette, bIsBPartsPaletteExtension)

	local bChanged = false;

	-- Update palette slot
	for i = 0, 29  do   -- i: 0~9, 30~49(Extend Palette)

		local nIndex	= i;

		local _wnd = _G[ "psPalette" .. tostring( nIndex )];

		if( nil ~= _wnd )	then
		
		local nType = _wnd:GetType();
		local nID = _wnd:GetID();
		
		_wnd:UpdateInfo();
		
		if ( nType ~= _wnd:GetType())  or  ( nID ~= _wnd:GetID())  then  bChanged = true;
		end
			
		end
	end
	

	-- Update palette set number
	local strSlotNum = tostring( gamefunc:GetPaletteSetNum() + 1);
	lbPaletteSetNum:SetText( strSlotNum);
	

	-- Update binded palette set indicator
	luaPalette:RefreshBindedWeaponPaletteSet();
	
	
	-- Update controls
	if ( bBpartsChanged == true)  then
		luaPalette.m_bBPartsPalette = bIsBPartsPalette;
	
		if ( bIsBPartsPalette == true)  then
		
			local width, height = pnlPaletteShaker:GetSize();
			local x, y, w, h = pnlPaletteSlots:GetRect();
			w = 240;
			
			if (bIsBPartsPaletteExtension == true) then 
				w = 465;
			end
			
			pnlPaletteSlots:SetRect( ( width - w) * 0.5, y, w, h);
			
			picPaletteSideDecoLeft:SetPosition( ( width - w) * 0.5 - 100, 90);
			picPaletteSideDecoLeft:SetImage( "bmpPaletteSideDeco2");
			picPaletteSideDecoRight:SetPosition( ( width + w) * 0.5 - 15, 90);
			picPaletteSideDecoRight:SetImage( "bmpPaletteSideDeco2");
			
			if (bIsBPartsPaletteExtension == true) then
				psPalette5:Show( true);
				psPalette6:Show( true);
				psPalette7:Show( true);
				psPalette8:Show( true);
				psPalette9:Show( true);
			else
			psPalette5:Show( false);
			psPalette6:Show( false);
			psPalette7:Show( false);
			psPalette8:Show( false);
			psPalette9:Show( false);
			end

			pnlPaletteNumber:Show( false);
			pnlPaletteWeaponBinder:Show( false);
			
		else
		
			local width, height = pnlPaletteShaker:GetSize();
			local x, y, w, h = pnlPaletteSlots:GetRect();
			w = 465;
			pnlPaletteSlots:SetRect( ( width - w) * 0.5, y, w, h);
			
			picPaletteSideDecoLeft:SetPosition( ( width - w) * 0.5 - 100, 90);
			picPaletteSideDecoLeft:SetImage( "bmpPaletteSideDeco");
			picPaletteSideDecoRight:SetPosition( ( width + w) * 0.5 - 15, 90);
			picPaletteSideDecoRight:SetImage( "bmpPaletteSideDeco");

			psPalette5:Show( true);
			psPalette6:Show( true);
			psPalette7:Show( true);
			psPalette8:Show( true);
			psPalette9:Show( true);

			pnlPaletteNumber:Show( true);
			pnlPaletteWeaponBinder:Show( true);
		end
	end
	
	
	-- Run change motion
	if ( bBpartsChanged == true)  and  ( bChanged == true)  then
	
		luaPalette.CHANGED.run = true;
		luaPalette.CHANGED.timer = gamefunc:GetUpdateTime();
		
		sdsPaletteEffectLeft:Show( true);
		sdsPaletteEffectLeft:SetCurScene( 0);
		sdsPaletteEffectLeft:SetSlideShow( true);
		sdsPaletteEffectRight:Show( true);
		sdsPaletteEffectRight:SetCurScene( 0);
		sdsPaletteEffectRight:SetSlideShow( true);
	end

	luaPalette:RefreshExtendPaletteSlot();
end





-- RefreshBindedWeaponPaletteSet
function luaPalette:RefreshBindedWeaponPaletteSet()

	local nID = nil;
	local strWeaponImg = nil;

	local nBindSet = gamefunc:GetWeaponBindedPaletteSet();
	if ( nBindSet == 1)  then
	
		nID = gamefunc:GetEquippedItemID( ITEM_SLOT.RWEAPON);
		strWeaponImg = "bmpWeaponEmpty";
		lbBindWeaponNum:SetText( nBindSet);
		
	elseif ( nBindSet == 2)  then
	
		nID = gamefunc:GetEquippedItemID( ITEM_SLOT.RWEAPON2);
		strWeaponImg = "bmpWeaponEmpty";
		lbBindWeaponNum:SetText( nBindSet);
		
	else

		strWeaponImg = "bmpWeaponBind";
		lbBindWeaponNum:SetText( "");
	end


	if ( nID ~= nil)  and  ( nID > 0)  then
	
		local nWeaponType = gamefunc:GetItemWeaponType( nID);
		if ( nWeaponType == WEAPON_TYPE.SLASH)  then			strWeaponImg = "bmpWeaponSword";
		elseif ( nWeaponType == WEAPON_TYPE.TWO_HANDED)  then	strWeaponImg = "bmpWeapon2HSword";
		elseif ( nWeaponType == WEAPON_TYPE.BLUNT)  then		strWeaponImg = "bmpWeaponBlunt";
		elseif ( nWeaponType == WEAPON_TYPE.TWO_BLUNT)  then	strWeaponImg = "bmpWeapon2HBlunt";
		elseif ( nWeaponType == WEAPON_TYPE.STAFF)  then		strWeaponImg = "bmpWeaponStaff";
		elseif ( nWeaponType == WEAPON_TYPE.DUAL_PIERCE)  then		strWeaponImg = "bmpWeaponDwp";
		end
	end

	picBindWeapon:SetImage( strWeaponImg);
end





-- OnPositionPaletteSlot
function luaPalette:OnPositionPaletteSlot()

	local width, height = pnlPaletteSet:GetParent():GetSize();
	local x, y, w, h = pnlPaletteSet:GetRect();
    pnlPaletteSet:SetPosition( ( width - w) * 0.5, y);
end





-- OnUpdatePaletteShaker
function luaPalette:OnUpdatePaletteShaker()

	if ( luaPalette.CHANGED.run == true)  then
	
		local fCurr = gamefunc:GetUpdateTime();
		local fElapsed = fCurr - luaPalette.CHANGED.timer;
		local fRatio = math.pow( 1.0 - math.min( 1.0,  fElapsed / 500.0), 3);
		
		local _x = 0;
		local _y = -( 15.0 * fRatio) * math.cos( fCurr * 0.037);
		pnlPaletteShaker:SetPosition( _x, _y);
		
		if ( fElapsed > 500)  then  luaPalette.CHANGED.run = false;
		end
	end
end





-- OnDragBeginPaletteSlot
function luaPalette:OnDragBeginPaletteSlot()

	if ( DragEventArgs:GetItemCount( 0) == 0)  then  return false;
	end
	

	-- Play sound
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex >= 0)  then
	
		local nType = gamefunc:GetPalleteItemType( nIndex);

		if ( nType == PALETTEITEM_TYPE.TALENT)  then

			local nTalentID = gamefunc:GetPalleteItemID( nIndex);
			local strSound = gamefunc:GetTalentPutUpSound( nTalentID);
			gamefunc:PlaySound( strSound);
			
		
		elseif ( nType == PALETTEITEM_TYPE.ITEM)  then
		
			local nItemID = gamefunc:GetPalleteItemID( nIndex);
			local strSound = gamefunc:GetItemPutUpSound( nItemID);
			gamefunc:PlaySound( strSound);
		end
	end
	
	return true;
end





-- OnDropPaletteSlot
function luaPalette:OnDropPaletteSlot()

	local _wnd = _G[ EventArgs:GetOwner():GetName()];

	local strSenderName = DragEventArgs:GetSender():GetName();
	local _sender = _G[ strSenderName];
	

	-- Self drop
	if ( _sender == _wnd)  then
	
		return true;
	
	
	-- Other palette slot
	elseif ( _sender == psPalette0)  or  ( _sender == psPalette1)  or  ( _sender == psPalette2)  or  ( _sender == psPalette3)  or  ( _sender == psPalette4)  or
		   ( _sender == psPalette5)  or  ( _sender == psPalette6)  or  ( _sender == psPalette7)  or  ( _sender == psPalette8)  or  ( _sender == psPalette9)  or
		   ( _sender == psPalette10)  or  ( _sender == psPalette11)  or  ( _sender == psPalette12)  or  ( _sender == psPalette13)  or  ( _sender == psPalette14)  or
		   ( _sender == psPalette15)  or  ( _sender == psPalette16)  or  ( _sender == psPalette17)  or  ( _sender == psPalette18)  or  ( _sender == psPalette19)  or
		   ( _sender == psPalette20)  or  ( _sender == psPalette21)  or  ( _sender == psPalette22)  or  ( _sender == psPalette23)  or  ( _sender == psPalette24)  or
		   ( _sender == psPalette25)  or  ( _sender == psPalette26)  or  ( _sender == psPalette27)  or  ( _sender == psPalette28)  or  ( _sender == psPalette29)	then
		   
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then

			-- Sender
			local nSlotType = gamefunc:GetPalleteItemType( nIndex);
			local nSlotID = gamefunc:GetPalleteItemID( nIndex);
			gamefunc:SetPaletteItem( nIndex, PALETTEITEM_TYPE.NONE);
			
			
			-- Reciever
			local nPaletteIndex = _wnd:GetSlotIndex();
			local nSlotType, nSlotID = gamefunc:SetPaletteItem( nPaletteIndex, nSlotType, nSlotID);
			

			-- Exchanged
			if ( nSlotType > 0)  and  ( nSlotID > 0)  then  gamefunc:SetPaletteItem( nIndex, nSlotType, nSlotID);
			end
			
			return true;
		end
	
	
	-- Talent slot	
	elseif ( string.find( strSenderName, "tsTalent_") ~= nil)  then
	
		local nTalentID = DragEventArgs:GetItemData( 0);
		if ( nTalentID >= 0)  then
		
			local nPaletteIndex = _wnd:GetSlotIndex();
			
			gamefunc:SetPaletteItem( nPaletteIndex, PALETTEITEM_TYPE.TALENT, nTalentID);
			return true;
		end
		
	
	-- From the inventory list
	elseif ( _sender == lcInventory)  then
	
		-- Skip when dyeing or enchanting
		if ( luaDyeing.m_bDyeing == true)  or  ( luaEnchant.m_bEnchanting == true)  then  return;
		end
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nItemID = gamefunc:GetInvenItemID( nIndex);
			if ( nItemID > 0)  then
			
				local nPaletteIndex = 0;
				
				gamefunc:SetPaletteItem( nPaletteIndex, PALETTEITEM_TYPE.ITEM, nItemID);
				return true;
			end
		end

	
	-- From the learned talent list
	elseif ( _sender == ctcLearnedTalent)  then
	
		local nTalentID = DragEventArgs:GetItemData( 0);
		if ( nTalentID > 0)  then

			local nPaletteIndex = _wnd:GetSlotIndex();
			
			gamefunc:SetPaletteItem( nPaletteIndex, PALETTEITEM_TYPE.TALENT, nTalentID);
			return true;
		end
	end
	
	return false;
end





-- OnDragOutPaletteSlot
function luaPalette:OnDragOutPaletteSlot()

	-- Play sound
	local nIndex = DragEventArgs:GetItemData( 0);
	if ( nIndex >= 0)  then
	
		local nType = gamefunc:GetPalleteItemType( nIndex);

		if ( nType == PALETTEITEM_TYPE.TALENT)  then
		
			local nTalentID = gamefunc:GetPalleteItemID( nIndex);
			local strSound = gamefunc:GetTalentPutDownSound( nTalentID);
			gamefunc:PlaySound( strSound);

		
		elseif ( nType == PALETTEITEM_TYPE.ITEM)  then
		
			local nItemID = gamefunc:GetPalleteItemID( nIndex);
			local strSound = gamefunc:GetItemPutDownSound( nItemID);
			gamefunc:PlaySound( strSound);
		end
	end
	
	
	-- Drop slot item
	if ( DragEventArgs:IsDropped() == false)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then  gamefunc:SetPaletteItem( nIndex, PALETTEITEM_TYPE.NONE);
		end
	end
end





-- OnToolTipPaletteSlot
function luaPalette:OnToolTipPaletteSlot()

	local _wnd = _G[ EventArgs:GetOwner():GetName()];
	local strToolTip = "";
	
	local nPaletteIndex = _wnd:GetSlotIndex();
	
	local nSlotType = gamefunc:GetPalleteItemType( nPaletteIndex);
	
	if ( nSlotType == PALETTEITEM_TYPE.TALENT)   then
		local nTalentID = gamefunc:GetPalleteItemID( nPaletteIndex);
		strToolTip = luaToolTip:GetTalentToolTip( nTalentID, false, false);

	elseif ( nSlotType == PALETTEITEM_TYPE.ITEM)  then
		local nItemID = gamefunc:GetPalleteItemID( nPaletteIndex);
		strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nil);
	end
	
	_wnd:SetToolTip( strToolTip);
end





-- OnClickBindWeaponSet
function luaPalette:OnClickBindWeaponSet( _index)

	gamefunc:SetWeaponBindedPaletteSet( _index);
	
	luaPalette:RefreshBindedWeaponPaletteSet();
end

-- RefreshExtendPaletteSlot
function luaPalette:RefreshExtendPaletteSlot()

	luaPalette.m_fSize = 0.0;
	pnlExtendPaletteSlots1:Show(true);
	pnlExtendPaletteSlots2:Show(true);
	if (btnAddExtendPalette2 ~= nil) then
		btnAddExtendPalette2:Enable(true);
	end

	if((luaPalette.m_bBPartsPalette == true)) then
		pnlExtendPaletteSlots1:Show(false);
		pnlExtendPaletteSlots2:Show(false);
		luaPalette.m_fSize = 90.0;
	end
end