--[[
	Game character LUA script
--]]


-- Global instance
luaCharacter = {};


-- Faction
luaCharacter.FACTION =
{
	WORST		= 0;			--     0 ~ 15999
	BAD			= 16000;		-- 16000 ~ 27999
	NORMAL		= 28000;		-- 28000 ~ 35999
	GOOD		= 36000;		-- 36000 ~ 47999
	EXCELLENT	= 48000;		-- 48000 ~ 64000
	TRUSTY		= 64000;		-- 64000 ~ 65000
	MAX			= 65000;
};





-- OnShowCharacterFrame
function luaCharacter:OnShowCharacterFrame()

	-- Show
	if ( frmCharacter:GetShow() == true)  then

		luaCharacter:RefreshCharacter();
		
		
	-- Hide
	else
	end
	

	luaGame:ShowWindow( frmCharacter);
end





-- RefreshCharacter();
function luaCharacter:RefreshCharacter()

	luaCharacter:RefreshCharacterInfo();
	luaCharacter:RefreshEquippedItemSlot();
	luaCharacter:RefreshFactionInfo();
	luaCharacter:RefreshCharacterLearnedTalent();
end





-- RefreshCharacterInfo
function luaCharacter:RefreshCharacterInfo()

	if (frmCharacter:GetShow() == false)  or  (tbcCharacterTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	-- Class info
	local nRace = gamefunc:GetRace();
	local strRace = "";
	if ( nRace == RACE_TYPE.HUMAN)  then		strRace = STR( "HUMAN");
	end
	
	local nSex = gamefunc:GetSex();
	local strSex = "";
	if ( nSex == SEX_TYPE.MALE)  then			strSex = STR( "MALE");
	elseif ( nSex == SEX_TYPE.FEMALE)  then		strSex = STR( "FEMALE");
	end
	
	labName:SetText( gamefunc:GetName());
	
	
	
	-- Background image
	if ( nSex == SEX_TYPE.MALE)  then			picCharacter:SetImage( "bmpCharacterMale");
	elseif ( nSex == SEX_TYPE.FEMALE)  then		picCharacter:SetImage( "bmpCharacterFemale");
	end
	

	
	-- Basic info
	local nExp = gamefunc:GetExp();
	local fExpRatio = gamefunc:GetExpRatio();
	
	local strBasicInfo = "{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}" .. strRace .. " " .. strSex .. "{CR h=0}{INDENT dent=160}" ..
						"{ALIGN hor=\"left\"}" .. STR( "LEVEL") .. "{CR h=0}{ALIGN hor=\"right\"}" .. gamefunc:GetLevel() .. "{CR}" ..
						"{ALIGN hor=\"left\"}" .. STR( "EXP") .. "{CR h=0}{ALIGN hor=\"right\"}" .. nExp .. " {FONT name=\"fntSubScript\"}(" .. math.floor( fExpRatio * 100) .. "%)";
	tvwBasicInfo:SetText( strBasicInfo);
	

	-- Status info
	local strStatusInfo = "{CR h=3}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}";
	local strColor;
	
	strColor = self:GetNumericalColor( gamefunc:GetModHPMax());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"hp\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "HP") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetMaxHP() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModENMax());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"en\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "EN") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetMaxEN() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModSTAMax());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"sta\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "STA") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetMaxSTA() .. "{SPACE w=5}{/COLOR}{CR h=20}";
	
	strStatusInfo = strStatusInfo .. "{CR h=7}";
	
	strColor = self:GetNumericalColor( gamefunc:GetModAP());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"armor\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "AP") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetArmorPoint() + gamefunc:GetModAP() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strStatusInfo = strStatusInfo .. "{CR h=7}";
	
	strColor = self:GetNumericalColor( gamefunc:GetModSTR());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"str\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "STR") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetSTR() + gamefunc:GetModSTR() .. "{SPACE w=5}{/COLOR}{CR h=20}";
	
	strColor = self:GetNumericalColor( gamefunc:GetModDEX());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"dex\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "DEX") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetDEX() + gamefunc:GetModDEX() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModINT());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"int\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "INT") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetINT() + gamefunc:GetModINT() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModCON());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"con\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "CON") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetCON() + gamefunc:GetModCON() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModCHA());
	strStatusInfo = strStatusInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"cha\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "CHA") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetCHA() + gamefunc:GetModCHA() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	tvwStatusInfo:SetText( strStatusInfo);
	

	-- Resistance info
	local strResistanceInfo = "{CR h=3}{FONT name=\"fntScript\"}{ALIGN ver=\"bottom\"}";
	
	strColor = self:GetNumericalColor( gamefunc:GetModFR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"fr\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_FIRE") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetFR() + gamefunc:GetModFR() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModCR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"cr\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_ICE") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetCR() + gamefunc:GetModCR() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModLR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"lr\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_LIGHTNING") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetLR() + gamefunc:GetModLR() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModPR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"pr\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_POISON") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetPR() + gamefunc:GetModPR() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	strColor = self:GetNumericalColor( gamefunc:GetModHR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"hr\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_HOLY") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetHR() + gamefunc:GetModHR() .. "{SPACE w=5}{/COLOR}{CR h=20}";
	
	strColor = self:GetNumericalColor( gamefunc:GetModUR());
	strResistanceInfo = strResistanceInfo .. "{ALIGN hor=\"left\"}{SPACE w=3}{REF text=\"ur\"}{SPACE w=124 h=20}{/REF}{CR h=0}{SPACE w=5}" .. STR( "UI_CHAR_RESISTANCE_UNHOLY") .. "{CR h=0}" ..
		"{ALIGN hor=\"right\"}" .. strColor .. gamefunc:GetUR() + gamefunc:GetModUR() .. "{SPACE w=5}{/COLOR}{CR h=20}";

	tvwResistanceInfo:SetText( strResistanceInfo);
end





-- GetStringColor
function luaCharacter:GetNumericalColor( _val)

	local strColor;
	if ( _val < 0 ) then		strColor = "{COLOR r=180 g=50 b=3}";
	elseif ( _val > 0 ) then	strColor = "{COLOR r=64 g=128 b=200}";
	else						strColor = "{COLOR r=128 g=128 b=128}";
	end
	
	return strColor;
end





-- GetToolTipModStr
function luaCharacter:GetToolTipModStr( _val_str, _val, _mod)

	local str;
	if ( _mod == 0)  then		str =  _val_str .. " = " .. _val;
	elseif ( _mod < 0)  then	str = _val_str .. " : " .. _val .. " - " .. ( _mod * -1) .. " = " .. ( _val + _mod);
	else						str = _val_str .. " : " .. _val .. " + " .. _mod .. " = " .. ( _val + _mod);
	end
	
	return str;
end





-- OnToolTipCharStatusInfo
function luaCharacter:OnToolTipCharStatusInfo()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwStatusInfo:GetRefText( nItemIndex);
		if ( strRefText == "hp")  then
		
			strToolTip = STR( "UI_CHAR_DESC_HP") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "HP"), gamefunc:GetMaxHP() - gamefunc:GetModHPMax(), gamefunc:GetModHPMax());
			
		elseif ( strRefText == "en")  then
		
			strToolTip = STR( "UI_CHAR_DESC_EN") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "EN"), gamefunc:GetMaxEN() - gamefunc:GetModENMax(), gamefunc:GetModENMax());
			
		elseif ( strRefText == "sta")  then
		
			strToolTip = STR( "UI_CHAR_DESC_STA") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "STA"),  gamefunc:GetMaxSTA() - gamefunc:GetModSTAMax(), gamefunc:GetModSTAMax());
			
		elseif ( strRefText == "armor")  then
		
			strToolTip = STR( "UI_CHAR_DESC_ARMOR") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "AP"), gamefunc:GetArmorPoint(), gamefunc:GetModAP());
			
		elseif ( strRefText == "str")  then
		
			strToolTip = STR( "UI_CHAR_DESC_STR") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "STR"), gamefunc:GetSTR(), gamefunc:GetModSTR());
			
		elseif ( strRefText == "dex")  then
		
			strToolTip = STR( "UI_CHAR_DESC_DEX") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "DEX"), gamefunc:GetDEX(), gamefunc:GetModDEX());
			
		elseif ( strRefText == "int")  then
		
			strToolTip = STR( "UI_CHAR_DESC_INT") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "INT"), gamefunc:GetINT(), gamefunc:GetModINT());
			
		elseif ( strRefText == "con")  then
		
			strToolTip = STR( "UI_CHAR_DESC_CON") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "CON"), gamefunc:GetCON(), gamefunc:GetModCON());
			
		elseif ( strRefText == "cha")  then
			
			strToolTip = STR( "UI_CHAR_DESC_CHA") .. "\n";
			strToolTip = strToolTip .. luaCharacter:GetToolTipModStr( STR( "CHA"), gamefunc:GetCHA(), gamefunc:GetModCHA());
		end
	end
	
	tvwStatusInfo:SetToolTip( strToolTip);
end





-- OnToolTipCharResistanceInfo
function luaCharacter:OnToolTipCharResistanceInfo()

	local strToolTip = "";

	-- Get reference text
	local nItemIndex = EventArgs:GetItemIndex();
	if ( nItemIndex >= 0)  then

		local strRefText = tvwResistanceInfo:GetRefText( nItemIndex);
		if ( strRefText == "fr")  then				strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCEFIRE"), gamefunc:GetFR(), gamefunc:GetModFR());
		elseif ( strRefText == "cr")  then			strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCEICE"), gamefunc:GetCR(), gamefunc:GetModCR());
		elseif ( strRefText == "lr")  then			strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCELIGHTNING"), gamefunc:GetLR(), gamefunc:GetModLR());
		elseif ( strRefText == "pr")  then			strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCEPOISON"), gamefunc:GetPR(), gamefunc:GetModPR());
		elseif ( strRefText == "hr")  then			strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCEHOLY"), gamefunc:GetHR(), gamefunc:GetModHR());
		elseif ( strRefText == "ur")  then			strToolTip = luaCharacter:GetToolTipModStr( STR( "RESISTANCEUNHOLY"), gamefunc:GetUR(), gamefunc:GetModUR());
		end
	end
	
	tvwResistanceInfo:SetToolTip( strToolTip);
end





-- RefreshEquippedItemSlot
function luaCharacter:RefreshEquippedItemSlot()

	if (frmCharacter:GetShow() == false)  or  (tbcCharacterTabCtrl:GetSelIndex() ~= 0)  then  return;
	end
	
	
	isFace:UpdateInfo();
	isHead:UpdateInfo();
	isBody:UpdateInfo();
	isHands:UpdateInfo();
	isFeet:UpdateInfo();
	isLeg:UpdateInfo();
	
	isEarring:UpdateInfo();
	isNecklace:UpdateInfo();
	isRingR:UpdateInfo();
	isRingL:UpdateInfo();

	isWeapon1:UpdateInfo();
	isWeapon1Sub:UpdateInfo();
	isWeapon2:UpdateInfo();
	isWeapon2Sub:UpdateInfo();
end





-- OnDragBeginEquippedItemSlot
function luaCharacter:OnDragBeginEquippedItemSlot()
	
	if ( DragEventArgs:GetItemCount( 0) == 0)  then  return false;
	end
	
	
	-- Play sound
	local nSlotType = DragEventArgs:GetItemData( 0);
	local nItemID = gamefunc:GetEquippedItemID( nSlotType);
	if ( nItemID > 0)  then
	
		local strSound = gamefunc:GetItemPutUpSound( nItemID);
		gamefunc:PlaySound( strSound);
	end
	
	return true;
end






-- OnDropEquippedItemSlot
function luaCharacter:OnDropEquippedItemSlot()

	local _wnd = _G[ EventArgs:GetOwner():GetName()];
	local _sender = _G[ DragEventArgs:GetSender():GetName()];
	

	-- Self drop
	local bRetVal = false;
	if ( _sender == _wnd)  then
	
		bRetVal = true;
	
	
	-- From the inventory list
	elseif ( _sender == lcInventory)  then
	
		local nIndex = DragEventArgs:GetItemData( 0);
		if ( nIndex >= 0)  then
		
			local nID = gamefunc:GetInvenItemID( nIndex);
			if ( nID > 0)  then
			
				-- Dyeing
				if ( luaDyeing.m_bDyeing == true)  and  ( gamefunc:GetItemType( nID) == ITEM_TYPE.DYE)  then
				
					bRetVal = luaDyeing:OpenDyeingFrame( luaDyeing.DYE_TYPE.EQUIPPED, _wnd:GetSlotType());
				
				-- Enchanting
				elseif ( luaEnchant.m_bEnchanting == true)  and  ( gamefunc:GetItemType( nID) == ITEM_TYPE.ENCHANT)  then
				
					bRetVal = luaEnchant:OpenEnchantFrame( luaEnchant.ENCHANT_TYPE.EQUIPPED, _wnd:GetSlotType());

				-- Equip inventory item
				else
		
					gamefunc:EquipInvenItem( _wnd:GetSlotType(), nIndex);
			
			
					-- Play sound
					local strSound = gamefunc:GetItemPutDownSound( nID);
					gamefunc:PlaySound( strSound);
					
					bRetVal = true;
				end
			end
		end
		
	
	-- From the other equipped item slot
	elseif (( _wnd == isWeapon1)  and  ( _sender == isWeapon2))  or  (( _wnd == isWeapon2)  and  ( _sender == isWeapon1))  or
		   (( _wnd == isWeapon1Sub)  and  ( _sender == isWeapon2Sub))  or  (( _wnd == isWeapon2Sub)  and  ( _sender == isWeapon1Sub))  then
	
		local nSlotType = DragEventArgs:GetItemData( 0);
		local nItemID = gamefunc:GetEquippedItemID( nSlotType);
		if ( nItemID > 0)  then
		
			-- Exchange two items	
			gamefunc:ExchangeEquippedItem( _sender:GetSlotType(), _wnd:GetSlotType());
			
			
			-- Play sound
			local strSound = gamefunc:GetItemPutDownSound( nItemID);
			gamefunc:PlaySound( strSound);
			
			bRetVal = true;
		end
	end

	
	return bRetVal;
end





-- OnDragOutEquippedItemSlot
function luaCharacter:OnDragOutEquippedItemSlot()

	-- Play sound
	local nSlotType = DragEventArgs:GetItemData( 0);
	local nItemID = gamefunc:GetEquippedItemID( nSlotType);
	if ( nItemID > 0)  then
	
		local strSound = gamefunc:GetItemPutDownSound( nItemID);
		gamefunc:PlaySound( strSound);
	end
	
	
	-- Drop slot item
	if ( DragEventArgs:IsDropped() == false)  then
	
		if ( nItemID > 0)  then  gamefunc:UnequipItem( nSlotType);
		end
	end
end





-- OnToolTipEquippedItemSlot
function luaCharacter:OnToolTipEquippedItemSlot()

	local strToolTip = "";
	
	local _wnd = _G[ EventArgs:GetOwner():GetName()];
	local nSlotType = _wnd:GetSlotType();
	local nItemID = gamefunc:GetEquippedItemID( nSlotType);
	
	if ( nItemID <= 0)  then
	
		if ( nSlotType == ITEM_SLOT.HEAD)  then				strToolTip = STR( "ITEMSLOT_HEAD");
		elseif ( nSlotType == ITEM_SLOT.FACE)  then			strToolTip = STR( "ITEMSLOT_FACE");
		elseif ( nSlotType == ITEM_SLOT.HANDS)  then		strToolTip = STR( "ITEMSLOT_HANDS");
		elseif ( nSlotType == ITEM_SLOT.FEET)  then			strToolTip = STR( "ITEMSLOT_FEET");
		elseif ( nSlotType == ITEM_SLOT.BODY)  then			strToolTip = STR( "ITEMSLOT_BODY");
		elseif ( nSlotType == ITEM_SLOT.LEG)  then			strToolTip = STR( "ITEMSLOT_LEGS");
		elseif ( nSlotType == ITEM_SLOT.LFINGER)  then		strToolTip = STR( "ITEMSLOT_RING");
		elseif ( nSlotType == ITEM_SLOT.RFINGER)  then		strToolTip = STR( "ITEMSLOT_RING");
		elseif ( nSlotType == ITEM_SLOT.NECK)  then			strToolTip = STR( "ITEMSLOT_NECKLACE");
		elseif ( nSlotType == ITEM_SLOT.EARRING)  then		strToolTip = STR( "ITEMSLOT_EARRING");
		elseif ( nSlotType == ITEM_SLOT.LWEAPON)  then		strToolTip = STR( "ITEMSLOT_SUBWEAPON1");
		elseif ( nSlotType == ITEM_SLOT.RWEAPON)  then		strToolTip = STR( "ITEMSLOT_WEAPON1");
		elseif ( nSlotType == ITEM_SLOT.LWEAPON2)  then		strToolTip = STR( "ITEMSLOT_SUBWEAPON2");
		elseif ( nSlotType == ITEM_SLOT.RWEAPON2)  then		strToolTip = STR( "ITEMSLOT_WEAPON2");
		end
	
	else
	
		if ( nItemID > 0)  then  strToolTip = luaToolTip:GetItemToolTip( nItemID, nil, nSlotType);
		end
	end

	_wnd:SetToolTip( strToolTip);
end





-- OnDblClickEquippedItemSlot
function luaCharacter:OnDblClickEquippedItemSlot()

	local _wnd = _G[ EventArgs:GetOwner():GetName()];
	local nSlotType = _wnd:GetSlotType();
	local nItemID = gamefunc:GetEquippedItemID( nSlotType);
	if ( nItemID > 0)  then
	
		local strSound = gamefunc:GetItemPutDownSound( nItemID);
		gamefunc:PlaySound( strSound);
	end
end





-- RefreshFactionInfo
function luaCharacter:RefreshFactionInfo()

	if (frmCharacter:GetShow() == false)  or  (tbcCharacterTabCtrl:GetSelIndex() ~= 1)  then  return;
	end
	
	
	local nCurSel = lcFactions:GetCurSel();
	
	
	lcFactions:DeleteAllItems();
	tvwFactionClanInfo:Clear();
	
	
	for  i = 0, (gamefunc:GetFactionCount() - 1)  do
	
		local nFactionID = gamefunc:GetFactionID(i);
		local strName = gamefunc:GetFactionName( nFactionID);
		local nFaction = gamefunc:GetFactionValue( i);

		local nIndex = lcFactions:AddItem( strName, "");
		lcFactions:SetItemText( nIndex, 1, nFaction);
		lcFactions:SetItemData( nIndex, i);
	end
	
	
	nCurSel = lcFactions:SetCurSel( nCurSel);
	
	if ( nCurSel >= 0)  then  luaCharacter:RefreshFactionClanInfo();
	end
end





-- RefreshFactionClanInfo
function luaCharacter:RefreshFactionClanInfo()

	local nSel = lcFactions:GetCurSel();

	if ( nSel < 0)  then  return;
	end

	local nIndex = lcFactions:GetItemData( nSel);
	local strDesc = "{FONT name=\"fntScript\"}" .. gamefunc:GetFactionDesc( nIndex);
	tvwFactionClanInfo:SetText( strDesc);
end





-- OnSelChangeFaction
function luaCharacter:OnSelChangeFaction()

	local nSel = lcFactions:GetCurSel();

	if ( nSel < 0)  then

		tvwFactionClanInfo:Clear();
		btnChangeAtWar:Enable( false);
		return;
	end
	
	
	local nIndex = lcFactions:GetItemData( nSel);
	local nFaction = gamefunc:GetFactionValue( nIndex);
	
--	if ( nFaction < luaCharacter.FACTION.NORMAL)  then	btnChangeAtWar:Enable( false);
--	else												btnChangeAtWar:Enable( true);
--	end
	

	luaCharacter:RefreshFactionClanInfo();
end





-- OnDrawItemBkgrndFaction
function luaCharacter:OnDrawItemBkgrndFaction()

	local nSubItem = EventArgs:GetItemSubItem();

	if ( nSubItem == 1)  then

		local x, y, w, h = EventArgs:GetItemRect();
		x = x + 4;
		y = y + 4;
		w = w - 8;
		h = h - 8;


		local nFaction = gamefunc:GetFactionValue( EventArgs:GetItemIndex());
		local nGauge = 0;
		local fRatio = 0;
		local strFaction = "";
		
		if ( nFaction > luaCharacter.FACTION.TRUSTY)  then
		
			nGauge = 4;
			strFaction = STR( "FACTION_TRUSTY");
			fRatio = (nFaction - luaCharacter.FACTION.TRUSTY) / (luaCharacter.FACTION.MAX - luaCharacter.FACTION.TRUSTY);

		elseif ( nFaction > luaCharacter.FACTION.EXCELLENT)  then
		
			nGauge = 4;
			strFaction = STR( "FACTION_EXCELLENT");
			fRatio = (nFaction - luaCharacter.FACTION.EXCELLENT) / (luaCharacter.FACTION.TRUSTY - luaCharacter.FACTION.EXCELLENT);
		
		elseif ( nFaction > luaCharacter.FACTION.GOOD)  then
		
			nGauge = 3;
			strFaction = STR( "FACTION_GOOD");
			fRatio = (nFaction - luaCharacter.FACTION.GOOD) / (luaCharacter.FACTION.EXCELLENT - luaCharacter.FACTION.GOOD);

		elseif ( nFaction > luaCharacter.FACTION.NORMAL)  then
		
			nGauge = 2;
			strFaction = STR( "FACTION_NORMAL");
			fRatio = (nFaction - luaCharacter.FACTION.NORMAL) / (luaCharacter.FACTION.GOOD - luaCharacter.FACTION.NORMAL);

		elseif ( nFaction > luaCharacter.FACTION.BAD)  then
		
			nGauge = 1;
			strFaction = STR( "FACTION_BAD");
			fRatio = (nFaction - luaCharacter.FACTION.BAD) / (luaCharacter.FACTION.NORMAL - luaCharacter.FACTION.BAD);

		elseif ( nFaction >= luaCharacter.FACTION.WORST)  then
		
			nGauge = 0;
			strFaction = STR( "FACTION_WORST");
			fRatio = (nFaction - luaCharacter.FACTION.WORST) / (luaCharacter.FACTION.BAD - luaCharacter.FACTION.WORST);
		end


		gamedraw:SetBitmap( "bmpGauges");
		local _opacity = gamedraw:SetOpacity( 0.25);
		gamedraw:DrawEx( x, y, w, h, 0, nGauge * 20, 32, 20);
		gamedraw:SetOpacity( _opacity);
		gamedraw:DrawEx( x, y, w * fRatio, h, 0, nGauge * 20, 32, 20);

		gamedraw:SetFont( "fntScriptStrong");
		gamedraw:SetColor( 160, 160, 160);
		gamedraw:SetTextAlign( "center", "center");
		gamedraw:TextEx( x, y, w, h, strFaction);
	end
end





-- OnPreDrawItemFaction
function luaCharacter:OnPreDrawItemFaction()

	local nSubItem = EventArgs:GetItemSubItem();
	if ( nSubItem == 1)  then  return true;
	end
	
	return false;
end





-- RefreshCharacterLearnedTalent
function luaCharacter:RefreshCharacterLearnedTalent()

	if (frmCharacter:GetShow() == false)  or  (tbcCharacterTabCtrl:GetSelIndex() ~= 2)  then  return;
	end
	
	
	-- Update talent list
	local nCurSelCategory, nCurSelItem = ctcLearnedTalent:GetCurSel();
	ctcLearnedTalent:DeleteAllItems();

	local tCategory = {};
	local nCount = 0;
	local nTotal = 0;
	local bExpand = true;
	
	for  i = 0, ( gamefunc:GetLearnedTalentCount() - 1)  do
	
		local nTalentID = gamefunc:GetLearnedTalentID( i);
		local nLastLearnedRankedID = gamefunc:GetLastLearnedRankedTalentID( nTalentID);
		
		if ( nTalentID == nLastLearnedRankedID)  then
		
			local nStyle = gamefunc:GetTalentStyle( nTalentID);

			-- Filtering
			local nFilter = 0;
			local nCurSel = cmbLearnedTalentFilter:GetCurSel();
			if ( nCurSel >= 0)  then  nFilter = cmbLearnedTalentFilter:GetItemData( nCurSel);
			end
			
			if ( nFilter == TALENT_TYPE.NONE)  or  ( nFilter == nStyle)  then
			
				local strName = gamefunc:GetTalentName( nTalentID);

				local strIcon = gamefunc:GetTalentImage( nTalentID);
				if (strIcon == nil)  or  (strIcon == "")  then  strIcon = "iconUnknown";
				end

				local nRank = gamefunc:GetTalentRank( nTalentID);
				local strRank = STR( "RANK") .. " " .. tostring( nRank);

				local strStyle = "";
				if ( nStyle == TALENT_TYPE.DEFENDER)  then			strStyle = STR( "STYLE_DEFENDER");
				elseif ( nStyle == TALENT_TYPE.BERSERKER)  then		strStyle = STR( "STYLE_BERSERKER");
				elseif ( nStyle == TALENT_TYPE.ASSASSIN)  then		strStyle = STR( "STYLE_ASSASSIN");
				elseif ( nStyle == TALENT_TYPE.RANGER)  then		strStyle = STR( "STYLE_RANGER");
				elseif ( nStyle == TALENT_TYPE.SORCERER)  then		strStyle = STR( "STYLE_SORCERER");
				elseif ( nStyle == TALENT_TYPE.CLERIC)  then		strStyle = STR( "STYLE_CLERIC");
				elseif ( nStyle == TALENT_TYPE.COMMON)  then		strStyle = STR( "TALENT_COMMON");
				elseif ( nStyle == TALENT_TYPE.LICENSE)  then		strStyle = STR( "TALENT_LICENSE");
				end
				
				local bPassive = gamefunc:IsTalentPassiveType( nTalentID);
				local strPassive = "";
				if ( bPassive == true)  then						strPassive = STR( "TALENT_PASSIVE");
				else												strPassive = STR( "TALENT_ACTIVE");
				end
				

				-- Get category
				local nCategory = nil;
				for _style, _category  in pairs( tCategory)  do
				
					if ( nStyle == _style)  then
					
						nCategory = _category;
						break;
					end
				end
				
				
				if ( nCategory == nil)  then
				
					nCategory = ctcLearnedTalent:AddCategory( strStyle);
					ctcLearnedTalent:SetCategoryExpand( nCategory, bExpand);
					
					tCategory[ nStyle] = nCategory;
					bExpand = false;
				end
				
				
				local nIndex = ctcLearnedTalent:AddItem( nCategory, strName, strIcon);
				ctcLearnedTalent:SetItemText( nCategory, nIndex, 1, strRank);
				ctcLearnedTalent:SetItemColor( nCategory, nIndex, 1, 80, 150, 150);
				ctcLearnedTalent:SetItemText( nCategory, nIndex, 2, strStyle);
				ctcLearnedTalent:SetItemColor( nCategory, nIndex, 2, 80, 150, 150);
				ctcLearnedTalent:SetItemText( nCategory, nIndex, 3, strPassive);
				ctcLearnedTalent:SetItemColor( nCategory, nIndex, 3, 80, 150, 150);
				ctcLearnedTalent:SetItemData( nCategory, nIndex, nTalentID);
				
				
				nCount = nCount + 1;
			end

			nTotal = nTotal + 1;
		end
	end
	

	-- Update emotional talent list
	local nFilter = 0;
	local nCurSel = cmbLearnedTalentFilter:GetCurSel();
	if ( nCurSel >= 0)  then  nFilter = cmbLearnedTalentFilter:GetItemData( nCurSel);
	end

	if ( nFilter == TALENT_TYPE.NONE)  or  ( nFilter == TALENT_TYPE.GESTURE)  then
	
		local nCategory = ctcLearnedTalent:AddCategory( STR( "TALENT_GESTURE"));
		ctcLearnedTalent:SetCategoryExpand( nCategory, bExpand);
		
		
		for  i = 0, ( gamefunc:GetEmotionalTalentCount() - 1)  do
		
			local nTalentID = gamefunc:GetEmotionalTalentID( i);
			local strName = gamefunc:GetTalentName( nTalentID);

			local strIcon = gamefunc:GetTalentImage( nTalentID);
			if (strIcon == nil)  or  (strIcon == "")  then  strIcon = "iconUnknown";
			end

			local nRank = gamefunc:GetTalentRank( nTalentID);
			local strRank = STR( "RANK") .. " " .. tostring( nRank);

			local strStyle = STR( "TALENT_GESTURE");

			local bPassive = gamefunc:IsTalentPassiveType( nTalentID);
			local strPassive = "";
			if ( bPassive == true)  then						strPassive = STR( "TALENT_PASSIVE");
			else												strPassive = STR( "TALENT_ACTIVE");
			end	

			local nIndex = ctcLearnedTalent:AddItem( nCategory, strName, strIcon);
			ctcLearnedTalent:SetItemText( nCategory, nIndex, 1, strRank);
			ctcLearnedTalent:SetItemColor( nCategory, nIndex, 1, 80, 150, 150);
			ctcLearnedTalent:SetItemText( nCategory, nIndex, 2, strStyle);
			ctcLearnedTalent:SetItemColor( nCategory, nIndex, 2, 80, 150, 150);
			ctcLearnedTalent:SetItemText( nCategory, nIndex, 3, strPassive);
			ctcLearnedTalent:SetItemColor( nCategory, nIndex, 3, 80, 150, 150);
			ctcLearnedTalent:SetItemData( nCategory, nIndex, nTalentID);
			
			
			nCount = nCount + 1;
			nTotal = nTotal + 1;
		end
	end
	
	
	ctcLearnedTalent:SetCurSel( nCurSelCategory, nCurSelItem);


	-- Update count
	local strText = "{ALIGN hor=\"right\"ver=\"center\"}{COLUMN h=30}" .. STR( "COUNT") .. " : " .. nCount .. " / " .. nTotal .. "{SPACE w=10}";
	tvwLearnedTalentCount:SetText( strText);
end





-- OnSelChangeLearnedTalentListCtrl
function luaCharacter:OnSelChangeLearnedTalentListCtrl()

	luaCharacter:RefreshCharacterLearnedTalent();	
end





-- OnDragBeginLearnedTalentListCtrl
function luaCharacter:OnDragBeginLearnedTalentListCtrl()

	local nItemCount = DragEventArgs:GetItemCount();
	if ( nItemCount <= 0)  then  return false;
	end
	
	local nID = DragEventArgs:GetItemData( 0);
	if ( nID < 0)  then  return false;
	end
	
	if ( gamefunc:IsTalentPassiveType( nID) == true)  then  return false;
	end

	return true;
end





-- OnDropLearnedTalentListCtrl
function luaCharacter:OnDropLearnedTalentListCtrl()

	local _sender = _G[ DragEventArgs:GetSender():GetName()];

	if ( _sender == psPalette0)  or  ( _sender == psPalette1)  or  ( _sender == psPalette2)  or  ( _sender == psPalette3)  or  ( _sender == psPalette4)  or
	   ( _sender == psPalette5)  or  ( _sender == psPalette6)  or  ( _sender == psPalette7)  or  ( _sender == psPalette8)  or  ( _sender == psPalette9)  then

		luaPalette:OnDragOutPaletteSlot();
		return true;
	end
	
	return false;
end





-- OnToolTipLearnedTalentListCtrl
function luaCharacter:OnToolTipLearnedTalentListCtrl()

	local strToolTip = "";
	
	local nCurSelCategory, nCurSelItem = ctcLearnedTalent:GetMouseOver();
	if ( nCurSelCategory >= 0)  and  ( nCurSelItem >= 0)  then
		
		local nTalentID = ctcLearnedTalent:GetItemData( nCurSelCategory, nCurSelItem);
		if ( nTalentID > 0)  then  strToolTip = luaToolTip:GetTalentToolTip( nTalentID, false, false);
		end
	end
	
	ctcLearnedTalent:SetToolTip( strToolTip);
end


















-- OpenConfirmChangeAtWar
function luaCharacter:OpenConfirmChangeAtWar()

	local nSel = lcFactions:GetCurSel();

	if ( nSel < 0)  then  return;
	end
	

	-- Reposition frame
	local x, y = frmConfirmChangeAtWar:GetParent():GetPosition();
	local w, h = frmConfirmChangeAtWar:GetSize();
    local width, height = gamefunc:GetWindowSize();
    frmConfirmChangeAtWar:SetPosition( (width - w) * 0.5 - x, (height - h) * 0.5 - y);
    
    btnChangeAtWar:Enable( false);
	frmConfirmChangeAtWar:DoModal();
end





-- CloseConfirmChangeAtWar
function luaCharacter:CloseConfirmChangeAtWar()

	btnChangeAtWar:Enable( false);
	frmConfirmChangeAtWar:Show( false);
end
