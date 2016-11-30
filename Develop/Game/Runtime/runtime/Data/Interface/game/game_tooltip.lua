--[[
	Game tooltip LUA script
--]]


-- Global instance
luaToolTip = {};


-- Maximum level
luaToolTip.MAX_LEVEL = 90;





--[[ Item ToolTip ]]--


-- Table of effects
g_EffectTable =
{
	-- AttributeName				strOutputName				isIntegerType		percentage
	{"ModHPRegen",					STR( "REGENHP"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModENRegen",					STR( "REGENEN"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModSTARegen",					STR( "REGENSTA"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModHPMax",					STR( "MAXHP"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModENMax",					STR( "MAXEN"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModSTAMax",					STR( "MAXSTA"),				true,				PERCENTAGE_TYPE.PER_NONE},		
	{"ModSTR",						STR( "STR"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModDEX",						STR( "DEX"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModINT",						STR( "INT"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModCHA",						STR( "CHA"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModCON",						STR( "CON"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModMoveSpeed",				STR( "MOVINGSPEED"),		false,				PERCENTAGE_TYPE.PER_NONE},
	{"ModAP",						STR( "AP"),					true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModABS",						STR( "ABS"),				true,				PERCENTAGE_TYPE.PER_NONE},		
	{"ModDodgeAmp",					STR( "DODGEAMP"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModCriticalAmp",				STR( "CRITICALAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModCriticalMeleeAmp",			STR( "CRITICALMELLEAMP"),	true,				PERCENTAGE_TYPE.PER_MULTI_PERCENTAGE},
	{"ModCriticalRangeAmp",			STR( "CRITICALRANGEAMP"),	true,				PERCENTAGE_TYPE.PER_MULTI_PERCENTAGE},
	{"ModCriticalMagicAmp",			STR( "CRITICALMAGICAMP"),	true,				PERCENTAGE_TYPE.PER_MULTI_PERCENTAGE},
	{"ModCriticalMeleeDmgAmp",		STR( "CRITICALMELLEDMGAMP"),false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModCriticalRangeDmgAmp",		STR( "CRITICALRANGEDMGAMP"),false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModCriticalMagicDmgAmp",		STR( "CRITICALMAGICDMGAMP"),false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModMeleeAtkAmp",				STR( "MELLEATKAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModRangeAtkAmp",				STR( "RANGEATKAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModMagicAtkAmp",				STR( "MAGICATKAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModHitRateAmp",				STR( "HITRATEAMP"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModGuardRate",				STR( "GUARDRATE"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},	
	{"ModDefSlashAmp",				STR( "SLASHDMGAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefBluntAmp",				STR( "BLUNTDMGAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefPierceAmp",				STR( "PIERCEDMGAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefHolyAmp",				STR( "HOLYDMGAMP"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefUnholyAmp",				STR( "UNHOLYDMGAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefFireAmp",				STR( "FIREDMGAMP"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefColdAmp",				STR( "COLDDMGAMP"),			false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefLightningAmp",			STR( "LIGHTNINGDMGAMP"),	false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModDefPoisonAmp",				STR( "POISONDMGAMP"),		false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModFR",						STR( "RESISTANCEFIRE"),		true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModCR",						STR( "RESISTANCEICE"),		true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModLR",						STR( "RESISTANCELIGHTNING"),true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModPR",						STR( "RESISTANCEPOISON"),	true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModHR",						STR( "RESISTANCEHOLY"),		true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModUR",						STR( "RESISTANCEUNHOLY"),	true,				PERCENTAGE_TYPE.PER_NONE},
	{"ModFRAmp",					STR( "RESISTANCEFIREAMP"),	false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModCRAmp",					STR( "RESISTANCEICEAMP"),	false,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModLRAmp",					STR( "RESISTANCELIGHTNINGAMP"),	false,			PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModPRAmp",					STR( "RESISTANCEPOISONAMP"),	false,			PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModHRAmp",					STR( "RESISTANCEHOLYAMP"),		false,			PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"ModURAmp",					STR( "RESISTANCEUNHOLYAMP"),	false,			PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"BeatenModValue",				STR( "BEATEN"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"KnockbackModValue",			STR( "KNOCKBACK"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"StunModValue",				STR( "STUN"),				true,				PERCENTAGE_TYPE.PER_NONE},
	{"DeflectModValue",				STR( "DEFLECT"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"ThrowupModValue",				STR( "THROWUP"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"KnockdownModValue",			STR( "KNOCKDOWN"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"UpperedModValue",				STR( "UPPERED"),			true,				PERCENTAGE_TYPE.PER_NONE},
	{"BeatenModWeight",				STR( "BEATENWEIGHT"),		true,				PERCENTAGE_TYPE.PER_PERMILLAGE},
	{"KnockbackModWeight",			STR( "KNOCKBACKWEIGHT"),	true,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"StunModWeight",				STR( "STUNWEIGHT"),			true,				PERCENTAGE_TYPE.PER_PERMILLAGE},
	{"DeflectModWeight",			STR( "DEFLECTWEIGHT"),		true,				PERCENTAGE_TYPE.PER_PERMILLAGE},
	{"ThrowupModWeight",			STR( "THROWUPWEIGHT"),		true,				PERCENTAGE_TYPE.PER_PERCENTAGE},
	{"KnockdownModWeight",			STR( "KNOCKDOWNWEIGHT"),	true,				PERCENTAGE_TYPE.PER_PERMILLAGE},
	{"UpperedModWeight",			STR( "UPPEREDWEIGHT"),		true,				PERCENTAGE_TYPE.PER_PERCENTAGE},
};





-- GetItemToolTip
function luaToolTip:GetItemToolTip( nID, nInvenIndex, nEquippedSlot)

	local strHeader = luaToolTip:GetItemHeader( nID, nInvenIndex, nEquippedSlot);
	local strDetail = luaToolTip:GetItemDetail( nID, nInvenIndex, nEquippedSlot);
	
	local strToolTip = "{PRGSPC spacing=5}{LINESPC spacing=2}{ALIGN ver=\"bottom\"}" .. strHeader;
	
	if ( strDetail ~= "")  then  strToolTip = strToolTip .. "{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" .. strDetail;
	end
	

	-- Remove null strings
	if ( string.sub( strToolTip, -8) == "{/COLOR}")  then  strToolTip = string.sub( strToolTip, 1, string.len( strToolTip) - 8);
	end
	
	if ( string.sub( strToolTip, -4) == "{CR}")  then  strToolTip = string.sub( strToolTip, 1, string.len( strToolTip) - 4);
	end


	return strToolTip;
end





-- GetItemHeader
function luaToolTip:GetItemHeader( nID, nInvenIndex, nEquippedSlot)

	if ( nInvenIndex == nil)  then  nInvenIndex = -1;
	end
	

	local strImage = gamefunc:GetItemImage( nID);
	local strName = gamefunc:GetItemName( nID);
	if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
	end


	-- Basic info
	local nType = gamefunc:GetItemType( nID);
	local strType = "";
	if ( nType == ITEM_TYPE.WEAPON)  then
	
		local nWeaponType = gamefunc:GetItemWeaponType( nID);
		strType = STR( "ITEM_WEAPON") .. "/" .. GetWeaponTypeName( nWeaponType);
		
	elseif ( nType == ITEM_TYPE.ARMOR)  then

		local nArmorType = gamefunc:GetItemArmorType( nID);
		strType = STR( "ITEM_ARMOR") .. "/" .. GetArmorTypeName( nArmorType);

	elseif ( nType == ITEM_TYPE.HOUSING)  then						strType = STR( "ITEM_HOUSING");
	elseif ( nType == ITEM_TYPE.INVENTORY)  then
	
		if ( gamefunc:IsItemRecipeMaterial( nID) == true)  then		strType = STR( "ITEM_INVENTORY") .. "/" .. STR( "MATERIAL");
		else														strType = STR( "ITEM_INVENTORY");
		end
		
	elseif ( nType == ITEM_TYPE.USABLE)  then

		local nUsableType = gamefunc:GetItemUsableType( nID);
		if ( gamefunc:IsItemReusable( nID) == true)  then			strType = STR( "ITEM") .. "/" .. STR( "REUSABLE");
		elseif ( nUsableType == USABLE_TYPE.QUEST_ADD)  then		strType = STR( "ITEM") .. "/" .. STR( "ADDQUEST");
		else														strType = STR( "ITEM");
		end

	elseif ( nType == ITEM_TYPE.ENCHANT)  then
	
		local nEnchantType = gamefunc:GetItemEnchantType( nID);	
		if ( nEnchantType == ENCHANT_TYPE.STONE)  then				strType = STR( "ENCHANTSTONE");
		elseif ( nEnchantType == ENCHANT_TYPE.SPECIALSTONE)  then	strType = STR( "SPECIALENCHANTSTONE");
		elseif ( nEnchantType == ENCHANT_TYPE.AGENT)  then			strType = STR( "ENCHANTAGENT");
		end
		
	elseif ( nType == ITEM_TYPE.DYE)  then							strType = STR( "DYESOLUTION");
	end
	
	
	
	local strTier = GetItemTierString( nID);
	local r, g, b = GetItemColor( nID);

	local strFlags = "";
	if ( gamefunc:IsItemUnique( nID))  then						strFlags = strFlags .. STR( "UNIQUE") .. ", ";			end
	if ( gamefunc:IsItemRepairable( nID) == false)  then		strFlags = strFlags .. STR( "NOTREPAIRABLE") .. ", ";	end
	if ( gamefunc:IsItemTradable( nID) == false)  then			strFlags = strFlags .. STR( "NOTTRADABLE") .. ", ";
	else
		-- 귀속
		if ( gamefunc:IsItemRequiredClaim( nID) == true)  then
		
			if ( ( nInvenIndex >= 0)  and  ( gamefunc:IsInvenItemClaimed( nInvenIndex) == true))  or
			   ( ( nEquippedSlot ~= nil)  and  ( gamefunc:IsEquippedItemClaimed( nEquippedSlot) == true))  then
																strFlags = strFlags .. STR( "NOTTRADABLE") .. ", ";
			end
		end
	end
	if ( gamefunc:IsItemDiscardable( nID) == false)  then		strFlags = strFlags .. STR( "NOTDISCARDABLE") .. ", ";	end
	if ( gamefunc:IsItemSellable( nID) == false)  then			strFlags = strFlags .. STR( "NOTSELLABLE") .. ", ";		end
	if ( nType == ITEM_TYPE.ARMOR)  then
		if ( gamefunc:IsItemDyeable( nID) == true)  then		strFlags = strFlags .. STR( "DYEABLE") .. ", ";			end
	end
	
	if ( strFlags ~= "")  then  strFlags = string.sub( strFlags, 1, string.len( strFlags) - 2) .. "{CR}";
	end

	local XP = -1;
	local nextLevelXP = -1;

	if (nEquippedSlot ~= nil) then
	XP = gamefunc:GetItemExp( nEquippedSlot, 1 );
	elseif (nInvenIndex >= 0) then
	XP = gamefunc:GetItemExp( nInvenIndex, 0);
	end
	
	if (nEquippedSlot ~= nil) then
	nextLevelXP = gamefunc:GetNextAttuneLevelXP( nEquippedSlot, 1 );
	elseif (nInvenIndex >= 0) then
	nextLevelXP = gamefunc:GetNextAttuneLevelXP( nInvenIndex, 0 );
	end

	local strXP = "";

	if(XP ~= -1) and (nextLevelXP ~= -1) then
	strXP = strXP .. "SP: " .. XP .. "/" .. nextLevelXP;
	else
	strXP = strXP .. "No XP";
	end
	

	local strHeader = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
				"{SPACE w=1 h=1}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=0}" ..
				"{INDENT dent=45}{FONT name=\"fntBold\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. strName .. "{/COLOR}{/FONT}\n" ..
				"{FONT name=\"fntScript\"}{ALIGN hor=\"justify\"}" .. strType .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=" .. r .. " g=" .. g .. " b=" .. b .. "}" .. strTier .. "{/COLOR}{CR}" .. strXP .. "{CR}" ..
				"{COLOR r=100 g=160 b=160}" .. strFlags .. "{/COLOR}{/INDENT}{ALIGN hor=\"justify\"}";
				

	local strDesc = gamefunc:GetItemDesc( nID);
	if ( strDesc ~= "")  then  strHeader = strHeader .. "{CR h=10}{ALIGN hor=\"justify\"}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" ..  strDesc .. "{CR}";
	end
	
	return strHeader;
end





-- GetItemDetail
function luaToolTip:GetItemDetail( nID, nInvenIndex, nEquippedSlot)

	local strDetail = "";

	if ( nInvenIndex == nil)  then  nInvenIndex = -1;
	end
	
	local nLevel = gamefunc:GetLevel();
	local nType = gamefunc:GetItemType( nID);
	local nWeaponType = gamefunc:GetItemWeaponType( nID);
	local nArmorType = gamefunc:GetItemArmorType( nID);
	local nEnchantType = gamefunc:GetItemEnchantType( nID);
	

	-- Requirements
	local strRequest = "";

	-- Level
	local bInvalidLevel = false;
	local nRequiredLevel = 0;
	local nRequiredMaxLevel = 0;
	if ( nType == ITEM_TYPE.ENCHANT)  and  ( nEnchantType > ENCHANT_TYPE.NONE)  then
		nRequiredLevel = gamefunc:GetItemEnchantLevel( nID);
	else
		nRequiredLevel = gamefunc:GetItemEquipReqLevel( nID);
		nRequiredMaxLevel = gamefunc:GetItemEquipReqMaxLevel( nID);
	end

	if ( nRequiredLevel > 0)  then
	
		if ( nRequiredMaxLevel > 0)  and  ( nRequiredMaxLevel <= luaToolTip.MAX_LEVEL)  then
		
			local _color = "{COLOR r=100 g=160 b=160}";
			if ( nLevel < nRequiredLevel)  or  ( nLevel > nRequiredMaxLevel)  then
				bInvalidLevel = true;
				_color = "{COLOR r=160 g=32 b=32}";
			end
			
			strRequest = strRequest .. _color .. FORMAT( "REQUIREDLEVELRANGE", nRequiredLevel, nRequiredMaxLevel) .. "{/COLOR}{CR}";

		else

			local _color = "{COLOR r=100 g=160 b=160}";
			if ( nLevel < nRequiredLevel)  then
				bInvalidLevel = true;
				_color = "{COLOR r=160 g=32 b=32}";
			end
			strRequest = strRequest .. _color .. FORMAT( "REQUIREDLEVEL", nRequiredLevel) .. "{/COLOR}{CR}";
		end
	end
	
	-- License
	--local nLicense = gamefunc:GetItemReqLicense( nID);
	--local bHasLicense = true;
	--if ( nLicense ~= LICENSE_TYPE.NONE)  then
	--
	--	local strLicense = GetLicenseName( nLicense);
	--	bHasLicense = gamefunc:HasItemReqLicense( nID, nLicense);
	--
	--	local _color = "{COLOR r=100 g=160 b=160}";
	--	if ( bHasLicense == false)  then  _color = "{COLOR r=160 g=32 b=32}";
	--	end
	--	strRequest = strRequest .. _color .. FORMAT( "UI_TOOLTIP_REQUIRELICENSE", strLicense) .. "{/COLOR}{CR}";
	--end
	

	if ( strRequest ~= "")  then	strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "REQUIREMENTS") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}" .. strRequest;
	end



	-- Item slot
	local nSlot = gamefunc:GetItemSlot( nID);
	local strSlot = GetItemSlotName( nSlot);
	if ( strSlot ~= nil)  then  strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "ITEMSLOT") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. strSlot .. "{/COLOR}{CR}";
	end
	
	
	-- Item Type
	if ( nType == ITEM_TYPE.WEAPON)  or
	   ( nType == ITEM_TYPE.ARMOR  and  (nArmorType == ARMOR_TYPE.CLOTH_ARMOR  or  nArmorType == ARMOR_TYPE.LEATHER_ARMOR  or  nArmorType == ARMOR_TYPE.CHAIN_MAIL  or  nArmorType == ARMOR_TYPE.PLATE_ARMOR  or  nArmorType == ARMOR_TYPE.SHIELD))  then
	
		local nDurability = 0;
		if ( nInvenIndex >= 0)  then			nDurability = gamefunc:GetInvenItemDurability( nInvenIndex);
		elseif ( nEquippedSlot ~= nil)  then	nDurability = gamefunc:GetEquippedItemDurability( nEquippedSlot);
		end
		
		strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "DURABILITY") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. nDurability .. "/" .. gamefunc:GetItemMaxDurability( nID) .. "{/COLOR}{CR}";
	end
	
	
	if ( nType == ITEM_TYPE.WEAPON)  then
	
		local nMinDamage = gamefunc:GetItemMinDamage( nID);
		local nMaxDamage = gamefunc:GetItemMaxDamage( nID);
		strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "PHYSICALDAMAGE") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. nMinDamage .. "~" .. nMaxDamage .. "{/COLOR}{CR}";
		
		local fSpellPower = gamefunc:GetItemSpellPower( nID);
		local strSpellpower = string.format("%.2f", fSpellPower)
		if ( fSpellPower ~= 1.0)  then  strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "MAGICDAMAGEBONUS") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. ((strSpellpower - 1.0) * 100) .. "%" .. "{/COLOR}{CR}";
		end

	elseif ( nType == ITEM_TYPE.ARMOR)  then

		local nArmorPoint = gamefunc:GetItemArmorPoint(nID)
		if ( nArmorPoint > 0)  then  strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "AP") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. nArmorPoint .. "{/COLOR}{CR}";
		end		
	
	elseif ( nType == ITEM_TYPE.USABLE)  then
	
		local nReuseTime = gamefunc:GetItemReuseTime( nID);
		if( nReuseTime > 0 ) then
			local strReuseTime = luaGame:ConvertTimeToStr( nReuseTime, "fntSmall");
			strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "COOLTIME") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. strReuseTime .. "{/COLOR}{CR}";
		end

	elseif ( nType == ITEM_TYPE.INVENTORY)  then
	
	elseif ( nType == ITEM_TYPE.HOUSING)  then
	
	end	
	


	-- Effects
	local strEffects = "";
	local ItemEffectsTable = gamefunc:GetItemEffects( nID);
	if ( next( ItemEffectsTable) ~= nil)  then
	
		for  i, v in ipairs( g_EffectTable)  do
	
			local key = v[1];
			local strName = v[2];
			local isInteget = v[3];
			
			if ( ItemEffectsTable[ key]  and  ItemEffectsTable[ key] ~= 0)  then
						
				local value = ItemEffectsTable[ key];
				local modifier = 0;
				
				-- 보정치 타입에 따라 정수형 결정
				if ( isInteget)  then	modifier = math.floor( value + 0.5);
				else					modifier = math.floor( ( value + 0.00001) * 100.0 + 0.5) .. "%";
				end			
				
				-- 보너스/패널티 표시
				if ( value >= 0)  then  modifier = "+" .. modifier;
				end

				strEffects = strEffects .. strName .. " " .. modifier .. "{CR}";	
			end	
		end
	end
	
	if ( nType == ITEM_TYPE.ARMOR)  then

		if ( nArmorType == ARMOR_TYPE.CLOTH_ARMOR)  then
		elseif ( nArmorType == ARMOR_TYPE.LEATHER_ARMOR)  then		strEffects = strEffects .. FORMAT( "NUTRALMAGICDMG", 20) .. "{CR}";
		elseif ( nArmorType == ARMOR_TYPE.CHAIN_MAIL)  then			strEffects = strEffects .. FORMAT( "NUTRALMAGICDMG", 40) .. "{CR}";
		elseif ( nArmorType == ARMOR_TYPE.PLATE_ARMOR)  then		strEffects = strEffects .. FORMAT( "NUTRALMAGICDMG", 60) .. "{CR}";
		elseif ( nArmorType == ARMOR_TYPE.SHIELD)  then
		elseif ( nArmorType == ARMOR_TYPE.ACCESSORY)  then
		end
	end
	
	if ( strEffects ~= "")  then  strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "EFFECT") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. strEffects .. "{/COLOR}";
	end
	
	
	
	-- Enchant
	if ( nType == ITEM_TYPE.ENCHANT)  then

		if ( nEnchantType == ENCHANT_TYPE.STONE)  or  ( nEnchantType == ENCHANT_TYPE.SPECIALSTONE)  then

			-- Unchantable weapon type
			local strUnchant = "";
			for i = 0, ( gamefunc:GetItemUnchantableWeaponTypeCount( nID) - 1)  do
			
				local _type = gamefunc:GetItemUnchantableWeaponType( nID, i);
				local _str = GetWeaponTypeName( _type);
				if ( _str ~= nil)  then  strUnchant = strUnchant .. _str .. ", ";
				end
			end

			-- Unchantable armor type
			for i = 0, ( gamefunc:GetItemUnchantableArmorSlotCount( nID) - 1)  do
			
				local _slot = gamefunc:GetItemUnchantableArmorSlot( nID, i);
				local _str = GetItemSlotName( _slot);
				if ( _str ~= nil)  then  strUnchant = strUnchant .. _str .. ", ";
				end
			end
			
			if ( strUnchant ~= "")  then
			
				strUnchant = string.sub( strUnchant, 1, string.len( strUnchant) - 2);
				strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "NOTENCHATABLE") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{SPACE w=100}{COLOR r=100 g=160 b=160}" .. strUnchant .. "{/COLOR}{CR}";
			end
			
			
			-- Success ratio
			strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "ENCHANTINGSUCCESSRATE") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. gamefunc:GetEnchantSuccessPercent( nID) .. "%{/COLOR}{CR}";

			-- Agents
			strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "ENCHANTAGENT") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}";
			local nAgentIDBegin, nAgentIDEnd = gamefunc:GetItemEnchantAgentIDRange( nID);
			for  i = nAgentIDBegin, nAgentIDEnd  do  strDetail = strDetail .. "{SPACE w=3}{BITMAP name=\"" .. gamefunc:GetItemImage( i) .. "\" w=16 h=16}";
			end
			strDetail = strDetail .. "{CR}";

		elseif ( nEnchantType == ENCHANT_TYPE.AGENT)  then

		end
	end

	

	-- Enchanted stones
	local strEnchantIcon = "";
	local tEnchantedStones = {};
	tEnchantedStones.index = {};
	for i = 0, ( gamefunc:GetItemEnchantHoleCount( nID) - 1)  do
	
		local nEnchantHoleType = gamefunc:GetItemEnchantHoleType( nID, i);
		local nEnchantStoneID = 0;
		if ( nInvenIndex >= 0)  then			nEnchantStoneID = gamefunc:GetInvenItemEnchantedStoneID( nInvenIndex, i);
		elseif ( nEquippedSlot ~= nil)  then	nEnchantStoneID = gamefunc:GetEquippedItemEnchantedStoneID( nEquippedSlot, i);
		end

		if ( nEnchantHoleType > ENCHANTHOLE_TYPE.NONE)  then
	
			if ( nEnchantStoneID < 0)  then
			
				if ( nEnchantHoleType == ENCHANTHOLE_TYPE.GENERAL)  then			strEnchantIcon = strEnchantIcon .. "{SPACE w=3}{BITMAP name=\"iconEnchantHoleBroken\" w=20 h=20}";
				elseif ( nEnchantHoleType == ENCHANTHOLE_TYPE.SPECIAL)  then		strEnchantIcon = strEnchantIcon .. "{SPACE w=3}{BITMAP name=\"iconEnchantHoleBrokenS\" w=20 h=20}";
				end

			else

				if ( nEnchantStoneID == 0)  then
				
					if ( nEnchantHoleType == ENCHANTHOLE_TYPE.GENERAL)  then		strEnchantIcon = strEnchantIcon .. "{SPACE w=3}{BITMAP name=\"iconEnchantHole\" w=20 h=20}";
					elseif ( nEnchantHoleType == ENCHANTHOLE_TYPE.SPECIAL)  then	strEnchantIcon = strEnchantIcon .. "{SPACE w=3}{BITMAP name=\"iconEnchantHoleS\" w=20 h=20}";
					end

				else
					
					strEnchantIcon = strEnchantIcon .. "{SPACE w=3}{BITMAP name=\"" .. gamefunc:GetItemImage( nEnchantStoneID) .. "\" w=20 h=20}";
					
					if ( tEnchantedStones[ nEnchantStoneID] == nil)  then
					
						tEnchantedStones[ nEnchantStoneID] = {};
						tEnchantedStones[ nEnchantStoneID].id = nEnchantStoneID;
						tEnchantedStones[ nEnchantStoneID].name = gamefunc:GetItemName( nEnchantStoneID);
						tEnchantedStones[ nEnchantStoneID].count = 1;
						
						table.insert( tEnchantedStones.index, nEnchantStoneID);
						
					else
					
						tEnchantedStones[ nEnchantStoneID].count = tEnchantedStones[ nEnchantStoneID].count + 1;
					end
				end
			end
		end
	end
	
	local strEnchantName = "";
	for _n, _id  in pairs ( tEnchantedStones.index)  do
	
		local _data = tEnchantedStones[ _id];
	
		strEnchantName = strEnchantName .. _data.name;
		if ( _data.count > 1)  then		strEnchantName = strEnchantName .. " x" .. _data.count;
		end
		
		local strEffect = "";
		local tEffectTable = gamefunc:GetItemEffects( _data.id);
		if ( next( tEffectTable) ~= nil)  then
		
			for  __index, __data in ipairs( g_EffectTable)  do
		
				local _key = __data[ 1];
				local _name = __data[ 2];
				local _integet = __data[ 3];
				
				if ( tEffectTable[ _key])  and  ( tEffectTable[ _key] ~= 0)  then
							
					local _value = tEffectTable[ _key];
					local _modifier = 0;
					
					if ( _integet)  then		_modifier = _value * _data.count;
					else						_modifier = math.floor( _value * 100 * _data.count + 0.5) .. "%";
					end
					
					if ( _value >= 0)  then		_modifier = "+" .. _modifier;
					end

					strEffect = _name .. " " .. _modifier .. "{CR}";
				end	
			end
		end
		
		if ( strEffect ~= "")  then		strEnchantName = strEnchantName .. " : " .. strEffect;
		else							strEnchantName = strEnchantName .. "{CR}"
		end
	end

	
	if ( strEnchantIcon ~= "")  then
	
		 strDetail = strDetail .. "{ALIGN hor=\"justify\"}" .. STR( "ENCHANTING") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}" .. strEnchantIcon .. "{CR}";
		 
		 if ( strEnchantName ~= "")  then  strDetail = strDetail .. "{COLOR r=100 g=160 b=160}" .. strEnchantName .. "{/COLOR}";
		 end
	end

	
	
	-- Product info
	local strProduct = "";
	if ( gamefunc:IsItemRecipeMaterial( nID) == true)  then
	
		local nTier = gamefunc:GetItemTier( nID);
		if ( nTier >= ITEM_TIER.RARE)  then

			local nCount = gamefunc:GetItemProductCount( nID);
			if ( nCount > 0)  then
			
				for  i = 0, ( nCount - 1)  do
				
					local nProductID = gamefunc:GetItemProductID( nID, i);
					local nProductName = gamefunc:GetItemName( nProductID);
					local nProductLevel = gamefunc:GetItemEquipReqLevel( nProductID);
					
					strProduct = strProduct .. nProductName;
					
					if ( nProductLevel > 1)  then  strProduct = strProduct .. " {FONT name=\"fntSmall\"}(" .. nProductLevel .. STR( "LEVEL") .. "){/FONT}";
					end
					
					strProduct = strProduct .. "{CR}";
				end
				
				strProduct = string.sub( strProduct, 1, string.len( strProduct) - 4);
			end

		else
		
			local nMinLevel, nMaxLevel = nil, nil;
			local tProductTypes = {};
			local nCount = gamefunc:GetItemProductCount( nID);
			if ( nCount > 0)  then
			
				for  i = 0, ( nCount - 1)  do
				
					local nProductID = gamefunc:GetItemProductID( nID, i);
					local nProductLevel = math.max( 1, gamefunc:GetItemEquipReqLevel( nProductID));
					if ( nMinLevel == nil)  then		nMinLevel = nProductLevel;
					else								nMinLevel = math.min( nMinLevel, nProductLevel);
					end

					if ( nMaxLevel == nil)  then		nMaxLevel = nProductLevel;
					else								nMaxLevel = math.max( nMaxLevel, nProductLevel);
					end
					
					local nProductType = gamefunc:GetItemType( nProductID);
					if ( tProductTypes[ nProductType] == nil)  then
					
						if ( nProductType == ITEM_TYPE.WEAPON)  then				tProductTypes[ nProductType] = STR( "ITEM_WEAPON");
						elseif ( nProductType == ITEM_TYPE.ARMOR)  then				tProductTypes[ nProductType] = STR( "ITEM_ARMOR");
						elseif ( nProductType == ITEM_TYPE.USABLE)  then			tProductTypes[ nProductType] = STR( "ITEM_USABLE");
						end
					end
				end
				
				
				for _type, _typestr  in pairs( tProductTypes)  do
				
					strProduct = strProduct .. _typestr .. ",";
				end

				strProduct = string.sub( strProduct, 1, string.len( strProduct) - 1);
				
				if ( nMinLevel ~= nil)  and  ( nMaxLevel ~= nil)  and  ( nMaxLevel > nMinLevel)  then  strProduct = strProduct .. " {FONT name=\"fntSmall\"}(" .. nMinLevel .. "~" .. nMaxLevel .. STR( "LEVEL") .. "){/FONT}";
				end

			end
		end
	end	

	if ( strProduct ~= "")  then  strDetail = strDetail .. "{CRAFTING}{ALIGN hor=\"justify\"}" .. STR( "CRAFTING") .. " :" .. "{CR h=0}{ALIGN hor=\"right\"}{COLOR r=100 g=160 b=160}" .. strProduct .. "{/COLOR}{CR}{/CRAFTING}{CR}";
	end

	

	-- Notice
	local strNotice = "";
	if ( bInvalidLevel == true)  then
	
		if ( nType == ITEM_TYPE.WEAPON  or  nType == ITEM_TYPE.ARMOR)  then
			strNotice = strNotice .. "{BITMAP name=\"iconDefStop\" w=16 h=16}{COLOR r=160 g=32 b=32}" .. STR( "UI_TOOLTIP_INVALIDLEVELEQUIP") .. "{CR}";
		else
			strNotice = strNotice .. "{BITMAP name=\"iconDefStop\" w=16 h=16}{COLOR r=160 g=32 b=32}" .. STR( "UI_TOOLTIP_INVALIDLEVELUSABLE") .. "{CR}";
		end
	end
	
	if ( bHasLicense == false)  then		strNotice = strNotice .. "{BITMAP name=\"iconDefStop\" w=16 h=16}{COLOR r=160 g=32 b=32}" .. STR( "UI_TOOLTIP_INVALIDLICENSE") .. "{CR}";
	end

	if ( gamefunc:IsItemRequiredClaim( nID) == true)  then
	
		if ( ( nInvenIndex >= 0)  and  ( gamefunc:IsInvenItemClaimed( nInvenIndex) == true))  or
		   ( ( nEquippedSlot ~= nil)  and  ( gamefunc:IsEquippedItemClaimed( nEquippedSlot) == true))  then
											strNotice = strNotice .. "{BITMAP name=\"iconDefInformation\" w=16 h=16}{COLOR r=100 g=160 b=100}" .. STR( "UI_TOOLTIP_CLAIMED") .. "{CR}";
		else								strNotice = strNotice .. "{BITMAP name=\"iconDefExclamation\" w=16 h=16}{COLOR r=192 g=154 b=63}" .. STR( "UI_TOOLTIP_WILLCLAIM") .. "{CR}";
		end
	end

	if ( nType == ITEM_TYPE.ENCHANT)  then	strNotice = strNotice .. "{BITMAP name=\"iconDefInformation\" w=16 h=16}{COLOR r=100 g=160 b=100}" .. STR( "UI_TOOLTIP_ENCHANTABLE") .. "{CR}";
	elseif ( nType == ITEM_TYPE.DYE)  then	strNotice = strNotice .. "{BITMAP name=\"iconDefInformation\" w=16 h=16}{COLOR r=100 g=160 b=100}" .. STR( "UI_TOOLTIP_DYEABLE") .. "{CR}";
	end
	

	if ( strNotice ~= "")  then
	
		if ( strDetail ~= "")  then  strDetail = strDetail .. "{CR h=10}{ALIGN hor=\"justify\"}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}";
		end
		
		strDetail = strDetail .. "{ALIGN ver=\"center\"}" .. strNotice;
	end
			

	
	return strDetail;
end


















--[[ Talent ToolTip ]]--


-- GetItemToolTip
function luaToolTip:GetTalentToolTip( nID, bFocus, bShowNextRank)

	-- Get current rank talent tooltip
	local strHeader = luaToolTip:GetTalentHeader( nID, bFocus);
	local strDetail = luaToolTip:GetTalentDetail( nID, bFocus);
	local strToolTip = "{PRGSPC spacing=5}{LINESPC spacing=2}" .. strHeader;
	if ( strDetail ~= "")  then  strToolTip = strToolTip .. "{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" .. strDetail;
	end
	

	-- Get next rank talent tooltip
	local nNextRankID = nID + 1;
	if ( bShowNextRank == true)  and  ( gamefunc:IsLearnedTalent( nID) == true)  and  ( gamefunc:GetTalentRank( nNextRankID) > 0)  then
	
		local strHeader = luaToolTip:GetTalentHeader( nNextRankID, bFocus);
		local strDetail = luaToolTip:GetTalentDetail( nNextRankID, bFocus);
		local strToolTipNext = "{PRGSPC spacing=5}{LINESPC spacing=2}" .. strHeader;
		if ( strDetail ~= "")  then
			strToolTipNext = strToolTipNext .. "{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" .. strDetail;
		end
		
		strToolTip = "{COLOR r=100 g=160 b=100}< " .. STR( "UI_CURRENTRANK") .. " >{/COLOR}\n" .. strToolTip .. "{divide}" ..
			"{COLOR r=100 g=160 b=100}< " .. STR( "UI_NEXTRANK") .. " >{/COLOR}\n" .. strToolTipNext;
	end

	
	return strToolTip;
end





-- GetTalentHeader
function luaToolTip:GetTalentHeader( nID, bFocus)

	if ( nID <= 0)  then  return "";
	end
	

	local strImage = gamefunc:GetTalentImage( nID);
	if ( strImage == nil)  or  ( strImage == "")  then  strImage = "iconUnknown"
	end


	local strName = gamefunc:GetTalentName( nID);
	local nRank = gamefunc:GetTalentRank( nID);
	if ( nRank > 1)  then  strName = strName .. " " .. nRank;
	end	
	

	local strHeader = "{BITMAP name=\"bmpItemSlot\" w=42 h=42}{CR h=1}" ..
		"{SPACE w=1 h=1}{BITMAP name=\"" .. strImage .. "\" w=40 h=40}{CR h=0}" ..
		"{INDENT dent=45}{FONT name=\"fntBold\"}{COLOR r=230 g=230 b=230}" .. strName .. "{/COLOR}{/FONT}\n" ..
		"{FONT name=\"fntScript\"}";


	local nStyle = gamefunc:GetTalentStyle( nID);
	local strStyle = "";
	if ( nStyle == TALENT_TYPE.DEFENDER)  then			strStyle = STR( "FOCUS_DEFENDER");
	elseif ( nStyle == TALENT_TYPE.BERSERKER)  then		strStyle = STR( "FOCUS_BERSERKER");
	elseif ( nStyle == TALENT_TYPE.ASSASSIN)  then		strStyle = STR( "FOCUS_ASSASSIN");
	elseif ( nStyle == TALENT_TYPE.RANGER)  then		strStyle = STR( "FOCUS_RANGER");
	elseif ( nStyle == TALENT_TYPE.SORCERER)  then		strStyle = STR( "FOCUS_SORCERER");
	elseif ( nStyle == TALENT_TYPE.CLERIC)  then		strStyle = STR( "FOCUS_CLERIC");
	end
	strHeader = strHeader .. "{COLOR r=230 g=230 b=230}" .. strStyle .. "{/COLOR}{CR h=0}";

	
	local strCategory = gamefunc:GetTalentCategory( nID);
	if ( strCategory == "Melee" ) then					strCategory = STR( "TALENT_MELEE");
	elseif ( strCategory == "Range" ) then				strCategory = STR( "TALENT_RANGE");
	elseif ( strCategory == "Magic" ) then				strCategory = STR( "TALENT_MAGIC");
	elseif ( strCategory == "Common" ) then				strCategory = STR( "TALENT_COMMON");
	end
	strHeader = strHeader .. "{ALIGN hor=\"right\"}{COLOR r=230 g=230 b=230}" .. strCategory .. "{/COLOR}{CR}{ALIGN hor=\"justify\"}";
	
	
	local bRequireFocus = gamefunc:DoTalentRequireFocus( nID);
	if ( bRequireFocus == true)  then  strHeader = strHeader .. "{BITMAP name=\"iconDefExclamation\" w=16 h=16}{COLOR r=192 g=154 b=63}" .. FORMAT( "UI_TOOLTIP_REQUIREDFOCUS", strStyle) .. "{/COLOR}{CR}";
	end
	
	
	local bPassive = gamefunc:IsTalentPassiveType( nID);
	if ( bPassive == true)  then		strHeader = strHeader .. "{BITMAP name=\"iconDefInformation\" w=16 h=16}{COLOR r=100 g=160 b=100}" .. STR( "TALENT_PASSIVE") .. "{/COLOR}{CR}";
	end
	


	-- Description	
	strHeader = strHeader .. "{CR}{/INDENT}{ALIGN hor=\"justify\"}" .. gamefunc:GetTalentDesc( nID) .. "{CR}";


	return strHeader;
end





-- GetTalentDetail
function luaToolTip:GetTalentDetail( nID, bFocus)

	local strDetail = "";
	
	local bLearned = gamefunc:IsLearnedTalent( nID);
	
	
	-- Required weapon
	local bReqWeapon_1HS = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.SLASH);
	local bReqWeapon_1HB = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.BLUNT);
	local bReqWeapon_2WD = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.TWO_HANDED);
	local bReqWeapon_STF = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.STAFF);
	local bReqWeapon_ARC = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.ARCHERY);
	local bReqWeapon_2HB = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.TWO_BLUNT);
	local bReqWeapon_DWP = gamefunc:DoTalentRequireWeaponType( nID, WEAPON_TYPE.DUAL_PIERCE);
	
	local strWeapon = "";
	if ( bReqWeapon_1HS == true  and  bReqWeapon_1HB == true  and  bReqWeapon_2WD == true  and
		 bReqWeapon_STF == true  and  bReqWeapon_ARC == true  and  bReqWeapon_DWP == true  and
		 bReqWeapon_2HB) then 

		strWeapon = STR( "UI_TOOLTIP_ALLWEAPONS");
		
	else
	
		if ( bReqWeapon_1HS == true)  then		strWeapon = strWeapon .. STR( "WEAPON_SLASH") .. " / ";		end
		if ( bReqWeapon_1HB == true)  then		strWeapon = strWeapon .. STR( "WEAPON_BLUNT") .. " / ";		end
		if ( bReqWeapon_2WD == true)  then		strWeapon = strWeapon .. STR( "WEAPON_2HANDED") .. " / ";	end
		if ( bReqWeapon_STF == true)  then		strWeapon = strWeapon .. STR( "WEAPON_STAFF") .. " / ";		end
		if ( bReqWeapon_ARC == true)  then		strWeapon = strWeapon .. STR( "WEAPON_ARCHERY") .. " / ";	end
		if ( bReqWeapon_2HB == true)  then		strWeapon = strWeapon .. STR( "WEAPON_2BLUNT") .. " / ";	end
		if ( bReqWeapon_DWP == true)  then		strWeapon = strWeapon .. STR( "WEAPON_2PIERCE") .. " / ";	end
		
		if ( strWeapon ~= "")  then  strWeapon = string.sub( strWeapon, 1, string.len( strWeapon) - 3);
		end
	end
	strDetail = strDetail .. "{COLOR r=100 g=160 b=160}" .. strWeapon;
	

	-- Cost	
	local nCostHP = gamefunc:GetTalentCostHP( nID);
	local nCostEN = gamefunc:GetTalentCostEN( nID);
	local nCostSP = gamefunc:GetTalentCostSP( nID);

	local strCost = "";
	if ( nCostHP > 0)  then		strCost = strCost .. STR( "HP") .. " " .. nCostHP .. ", ";	end
	if ( nCostEN > 0)  then		strCost = strCost .. STR( "EN") .. " " .. nCostEN .. ", ";	end
	if ( nCostSP > 0)  then		strCost = strCost .. STR( "STA") .. " " .. nCostSP .. ", ";		end
	
	if ( strCost ~= "")  then
	
		strCost = string.sub( strCost, 1, string.len( strCost) - 2);
		strDetail = strDetail .. "{CR}" .. FORMAT( "UI_TOOLTIP_TALENTCONSUMES", strCost);
	end
	
	
	-- Casting time
	local nCastingTime = math.floor( gamefunc:GetTalentCastingTime( nID));
	if ( nCastingTime > 0)  then  strDetail = strDetail .. "{CR}" .. FORMAT( "UI_TOOLTIP_TALENTPRECASTINGTIME", luaGame:ConvertTimeToStr( nCastingTime));
	end
	
	
	-- Reusable time
	local nCoolTime = math.floor( gamefunc:GetTalentCoolTime( nID));
	if ( nCoolTime > 0)  then  strDetail = strDetail .. "{CR}" .. FORMAT( "UI_TOOLTIP_TALENTCASTINGTIME", luaGame:ConvertTimeToStr( nCoolTime));
	end
	
	strDetail = strDetail .. "{/COLOR}";




	-- Status
	local strStatus = "";	
	local nModHPMax = gamefunc:GetTalentModHPMax( nID);
	local nModENMax = gamefunc:GetTalentModENMax( nID);
	local nModSTAMax = gamefunc:GetTalentModSTAMax( nID);
	local nModSTR = gamefunc:GetTalentModSTR( nID);
	local nModDEX = gamefunc:GetTalentModDEX( nID);
	local nModCON = gamefunc:GetTalentModCON( nID);
	local nModINT = gamefunc:GetTalentModINT( nID);
	local nModCHA = gamefunc:GetTalentModCHA( nID);

	if ( nModHPMax > 0 )  then		strStatus = strStatus .. STR( "MAXHP") .. " +" .. nModHPMax .. "{CR}";		end
	if ( nModENMax > 0 )  then		strStatus = strStatus .. STR( "MAXEN") .. " +" .. nModENMax .. "{CR}";		end
	if ( nModSTAMax > 0 ) then		strStatus = strStatus .. STR( "MAXSTA") .. " +" .. nModSTAMax .. "{CR}";	end
	if ( nModSTR > 0 )  then		strStatus = strStatus .. STR( "STR") .. " +" .. nModSTR .. "{CR}";			end
	if ( nModDEX > 0 )  then		strStatus = strStatus .. STR( "DEX") .. " +" .. nModDEX .. "{CR}";			end
	if ( nModINT > 0 )  then		strStatus = strStatus .. STR( "INT") .. " +" .. nModINT .. "{CR}";			end
	if ( nModCON > 0 )  then		strStatus = strStatus .. STR( "CON") .. " +" .. nModCON .. "{CR}";			end
	if ( nModCHA > 0 )  then		strStatus = strStatus .. STR( "CHA") .. " +" .. nModCHA .. "{CR}";			end

	if ( strStatus ~= "" )  then
		strStatus = string.sub( strStatus, 1, string.len( strStatus) - 4);
		strDetail = strDetail .. "{CR}{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" ..
			STR( "UI_TOOLTIP_CHANGESTATS") .. "{CR}{INDENT dent=10}{COLOR r=100 g=160 b=160}" .. strStatus .. "{/COLOR}";
	end


		

	-- Required condition to learnning
	local nStyle = gamefunc:GetTalentStyle( nID);
	local nReqLevel = gamefunc:GetTalentLearnReqLevel( nID);
	local nReqTP = gamefunc:GetTalentLearnReqStyleTP( nID);

	if ( nReqLevel > 0)  or  ( nReqTP > 0)  then
	
		local strReqCon = "";

		if ( nReqLevel > 0)  then
			local _color = "{COLOR r=160 g=32 b=32}";
			if ( gamefunc:GetLevel() >= nReqLevel)  then  _color = "{COLOR r=100 g=160 b=160}";
			end
			strReqCon = strReqCon .. "{ALIGN hor=\"justify\"}" .. _color .. STR( "LEVEL") .. "{CR h=0}{ALIGN hor=\"right\"}" .. FORMAT( "REQUIREDLEVEL", nReqLevel) .. "{/COLOR}{CR}"
		end

		if ( nReqTP > 0)  then
			local _color = "{COLOR r=160 g=32 b=32}";
			if ( gamefunc:GetSpentTalentPoint( nStyle) >= nReqTP)  then  _color = "{COLOR r=100 g=160 b=160}";
			end
			strReqCon = strReqCon .. "{ALIGN hor=\"justify\"}" .. _color .. STR( "UI_TOOLTIP_REQUIREDTP") .. "{CR h=0}{ALIGN hor=\"right\"}" .. FORMAT( "REQUIREDTALENTPOINT", nReqTP) .. "{/COLOR}{CR}";
		end

		strReqCon = string.sub( strReqCon, 1, string.len( strReqCon) - 4);
 		strDetail = strDetail .. "{CR}{/INDENT}{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}{/INDENT}" ..
			STR( "REQUIREMENTS") .. "{CR}{INDENT dent=10}" .. strReqCon;
	end



		
	-- Focus description
	if ( bFocus == true)  and  ( bLearned == false)  then
	
		strDetail = strDetail .. "{CR}{/INDENT}{ALIGN hor=\"justify\"}{CR h=10}{BITMAP name=\"bmpDefSeperateBarHor2\" w=250 h=2}{CR h=10}" .. 
			"{ALIGN hor=\"justify\"}{COLOR r=160 g=32 b=32}" .. STR( "UI_TOOLTIP_LEARNTALENTFROMTRAINERS") .. "{/COLOR}";
	end
	
	
	return strDetail;
end








-- 착용 아이템 툴팁
-- OnToolTipEquipItem
function luaToolTip:OnToolTipEquipItem(nID)
				
	local strToolTip = "";
	local nToolTipItemID = 0;

	local nWeaponSet = gamefunc:GetWeaponSet();
	local nSlotType = gamefunc:GetItemSlot(nID);
	local nSlotItemID = gamefunc:GetEquippedItemID(nSlotType);
	local nWeaponType = gamefunc:GetItemWeaponType(nID);

	nToolTipItemID = nSlotItemID;

	-- 무기타입이면
	if ( nSlotType == ITEM_SLOT.LWEAPON) then

		local nLSlotItemID = gamefunc:GetEquippedItemID(ITEM_SLOT.LWEAPON);
		local nLWeaponType = gamefunc:GetItemWeaponType(nLSlotItemID);

		local nL2SlotItemID = gamefunc:GetEquippedItemID(ITEM_SLOT.LWEAPON2);
		local nL2WeaponType = gamefunc:GetItemWeaponType(nL2SlotItemID);

		if ( nWeaponType == nLWeaponType) and ( nWeaponType ~= nL2WeaponType) then
			nToolTipItemID = nLSlotItemID;
		elseif ( nWeaponType ~= nLWeaponType) and ( nWeaponType == nL2WeaponType) then
			nToolTipItemID = nL2SlotItemID;
		elseif ( nWeaponType == 0) then
			local nArmorType = gamefunc:GetItemArmorType(nID);
			if ( nArmorType == ARMOR_TYPE.SHIELD ) then
				if ( nWeaponSet == 0) and (nLSlotItemID ~= 0)  then
					nToolTipItemID = nLSlotItemID;
				elseif (nL2SlotItemID ~= 0)  then
					nToolTipItemID = nL2SlotItemID;
				end
			end
		else
			if ( nWeaponSet == 0) then
				nToolTipItemID = nLSlotItemID;
			else
				nToolTipItemID = nL2SlotItemID;
			end
		end
	elseif ( nSlotType == ITEM_SLOT.RWEAPON) then

		local nRSlotItemID = gamefunc:GetEquippedItemID(ITEM_SLOT.RWEAPON);
		local nRWeaponType = gamefunc:GetItemWeaponType(nRSlotItemID);

		local nR2SlotItemID = gamefunc:GetEquippedItemID(ITEM_SLOT.RWEAPON2);
		local nR2WeaponType = gamefunc:GetItemWeaponType(nR2SlotItemID);

		if ( nWeaponType == nRWeaponType) and ( nWeaponType ~= nR2WeaponType) then
			nToolTipItemID = nRSlotItemID;
		elseif ( nWeaponType ~= nRWeaponType) and ( nWeaponType == nR2WeaponType) then
			nToolTipItemID = nR2SlotItemID;
		else
			if ( nWeaponSet == 0) then
				nToolTipItemID = nRSlotItemID;
			else
				nToolTipItemID = nR2SlotItemID;
			end
		end
	end
		
	if ( nToolTipItemID ~= 0 ) then
		local strItemToolTip = luaToolTip:GetItemToolTip( nToolTipItemID, nil, nSlotType);
		strToolTip = strItemToolTip;
	end
	
	return strToolTip;
end


function luaToolTip:GetItemDropNPC( nID)

	local strDropper = "";
	local tDropper = {};
	for  i = 0, (gamefunc:GetItemDropperCount( nID) - 1)  do
	
		local bFind = false;
		local strDropperName = gamefunc:GetItemDropperName( nID, i);
		
		for  _index, _data in pairs( tDropper)  do
		
			if ( _data == strDropperName)  then
			
				bFind = true;
				break;
			end
		end	
		
		if ( bFind == false)  then  table.insert( tDropper, strDropperName);
		end
	end
	
	
	if ( table.getn( tDropper) > 0)  then
	
		strDropper = "{ALIGN hor=\"left\"}" .. STR( "UI_TOOLTIP_DROPNPC") .. " :{CR h=0}{ALIGN hor=\"right\"}";
		
		for  _index, _data in pairs( tDropper)  do  strDropper = strDropper .. _data .. "{CR}";
		end
	end
	
	return strDropper;
end


