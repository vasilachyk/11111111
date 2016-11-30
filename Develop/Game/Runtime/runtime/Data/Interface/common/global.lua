--[[
	Global LUA script
--]]

-- Login Country type
LOGIN_COUNTRY_TYPE =
{
	KOR					= 0,
	USA					= 1,
	EU					= 2
};

-- Locale Lang type
LOCALE_LANG_TYPE =
{
	KO_KR					= 0,
	EN_US					= 1,
	EN_GB					= 2,
	DE_DE					= 3,
	JA_JP					= 4
};

-- Race type
RACE_TYPE =
{
	HUMAN				= 0,
	_reserved001		= 1,
	_reserved002		= 2,
	_reserved003		= 3
};


-- Sex type
SEX_TYPE =
{
	MALE				= 0,
	FEMALE				= 1
};


-- Item type
ITEM_TYPE =
{
	WEAPON				= 1,
	ARMOR				= 2,
	LOOK				= 3,
	HOUSING				= 4,
	USABLE				= 5,
	_reserved002		= 6,
	INVENTORY			= 7,
	GATHER				= 8,
	ENCHANT				= 9,
	GEMENCHANT			= 10,
	GEMREMOVE			= 11,
	GEMEXTRACT			= 12,
	DYE					= 13
};


-- Looting item type
LOOTINGITEM_TYPE =
{
	NORMAL				= 1,
	ROLLDICE			= 2,
	MASTERLOOTER		= 3
};


-- Item slot type
ITEM_SLOT = 
{
	NONE				= 255,
	HEAD				= 0,
	FACE				= 1,
	HANDS				= 2,
	FEET				= 3,
	BODY				= 4,
	LEG					= 5,
	LFINGER				= 6,
	RFINGER				= 7,
	NECK				= 8,
	CHARM				= 9,
	LWEAPON				= 10,
	RWEAPON				= 11,
	LWEAPON2			= 12,
	RWEAPON2			= 13,
	LOOK_HEAD			= 14,
	LOOK_HANDS			= 15,
	LOOK_FEET			= 16,
	LOOK_BODY			= 17,
	LOOK_LEG			= 18,
	LOOK_LWEAPON		= 19,
	LOOK_RWEAPON		= 20,
	LOOK_LWEAPON2		= 21,
	LOOK_RWEAPON2		= 22,
	LOOK_BACK			= 23,
	LOOK_ACCESSARY		= 24,
	LOOK_TITLE			= 25,
	LOOK_FACE_DECO		= 26,
	TALISMAN			= 27,
	BELT				= 28,
};


-- Talent type
TALENT_TYPE =
{
	NONE				= 0,
	DEFENDER			= 1,
	BERSERKER			= 2,
	ASSASSIN			= 3,
	RANGER				= 4,
	SORCERER			= 5,
	CLERIC				= 6,
	COMMON				= 7,
	LICENSE				= 8,
	GESTURE				= 9,
};

TALENT_GUARD_CRASH_LEVEL = 
{
	PARTIAL				= 0,
	PERFECT				= 1,
	ABSOLUTE			= 2,
	ALL					= 3
};

-- Item tier
ITEM_TIER =
{
	VERYCOMMON			= 0,
	COMMON				= 1,
	RARE				= 2,
	TREASURE			= 3,
	LEGENDARY			= 4,
	EPIC				= 5
};


-- Weapon item type
WEAPON_TYPE =
{
	SLASH				= 1,
	BLUNT				= 2,
	PIERCE				= 3,
	TWO_HANDED			= 4,
	STAFF				= 5,
	ARCHERY				= 6,
	TWO_BLUNT			= 7,
	_reserved001		= 8,
	DUAL_PIERCE			= 9
};


-- Armor item type
ARMOR_TYPE =
{
	NONE				= 0,
	CLOTH_ARMOR			= 1,
	LEATHER_ARMOR		= 2,
	CHAIN_MAIL			= 3,
	PLATE_ARMOR			= 4,
	SHIELD				= 5,
	ACCESSORY			= 6,
	_reserved001		= 7
};


-- Usable item type
USABLE_TYPE =
{
	NONE				= 0,
	TALENT_USE			= 1,
	TALENT_TRAIN		= 2,
	TALENT_UNTRAIN		= 3,
	INTERACTION			= 4,
	INTERACTION_DEAD	= 5,
	QUEST_ADD			= 6,
	RECIPE_ADD			= 7,
	RANDOM_BOX			= 8,
	CRAFT_COSTUME		= 9,
	RENAME				= 10
};


-- License type
LICENSE_TYPE =
{
	NONE				= 0,
	MEDUIMARMOR			= 22,
	HEAVYARMOR			= 23
}


-- Paltte item type
PALETTEITEM_TYPE =
{
	NONE				= 0,
	TALENT				= 1,
	ITEM				= 2
};


-- Quest objective type
QUESTOBJECT_TYPE =
{
	DESTROY				= 1,
	COLLECT				= 2,
	ACT					= 3,
	SCOUT				= 4,
	INTERACT			= 5,
	ESCORT				= 6
};


-- Quest reward type
QUESTREWARD_TYPE =
{
	MONEY				= 1,
	EXPERIENCE			= 2,
	_reserved001		= 3,
	ITEM				= 4,
	FACTION				= 5
};


-- Day time
DAYTIME_TYPE =
{
	DAWN				= 0,
	DAYTIME				= 1,
	SUNSET				= 2,
	NIGHT				= 3,
};


-- Weather
WEATHER_TYPE =
{
	SUNNY				= 0,
	CLOUDY				= 1,
	RAINY				= 2,
	HEAVY_RAINY			= 3,
	SNOWY				= 4,
	HEAVY_SNOWY			= 5,
};


-- Fatigure
FATIGUE_TYPE =
{
	TOOBAD				= 1,
	BAD					= 2,
	NORMAL				= 3,
	GOOD				= 4,
	VERYGOOD			= 5
};


-- Chatting message filtering type
CHATFILTER_TYPE =
{
	GENERAL				= 1,
	SYSTEM				= 2,
	WHISPER				= 3,
	FIELD				= 4,
	SHOUTING			= 5,
	PARTY				= 6,
	GUILD				= 7,
	AUCTION				= 8,
	CHANNEL				= 9,
	ANNOUNCE			= 10,
	GM					= 11,
	SOCIAL				= 12,
	BATTLE				= 13,
	NEWBIE				= 14,			
	PARTYMATCHING		= 15,	
	BROADCAST			= 16		
};


-- Journal indicator object type
JOURNALOBJ_TYPE =
{
	NONE				= 0,
	QUEST				= 1,
	RECIPE				= 2,
	GUIDEBOOK			= 3
};


-- Presentation bar type
PRESENTATION_TYPE =
{
	UPPER				= 0,
	LOWER				= 1
};


-- Action progress type
ACTIONPROGRESS_TYPE =
{
	LOOTING_ITEM		= 0,
	INTERACTION			= 1,
	CASTING_SPELL		= 2,
	USE_ITEM			= 3,
	DYE					= 4,
	MAKE_ITEM			= 5
};


-- Client hit test
HITTEST =
{
	NOWHERE				= 0,
	CLIENT				= 1,
	CAPTION				= 2
};


-- Enchant_Category
ENCHANT_CATEGORY = 
{
	EC_NONE			= 0,	

	EC_GEM			= 1,	-- 보석 제련제
	EC_SPECIAL		= 2,	-- 특수 보석
	EC_NORMAL		= 3,	-- 일반 보석

	EC_ENCHANT		= 4,	-- 강화제
	EC_RARE			= 5,	-- 성공률 강화보조제
	EC_DESTORY		= 6,	-- 파괴율감소 강화보조제
	EC_DECREASE		= 7,	-- 하락방지제
	
	EC_ELEMENT_GEM	= 8,	-- 원소석
};

-- ItemToolTipInfo_Category
ITEMTOOLTIPINFO_CATEGORY = 
{
	ITTI_GENERAL		= 0,	-- 일반적인 아이템 정보
	ITTI_INVEN			= 1,	-- 인벤토리 아이템 정보
	ITTI_EQUIP			= 2,	-- 착용 아이템 정보
	ITTI_MAX			= 3,	-- 최대
};

-- Arena_Stage
ARENA_STAGE = 
{
	AS_NONE				= 0,	-- 기본 상태(매칭 안됨)
	AS_NORMAL			= 1,	-- 기본 매칭하기 전 상태
	AS_MATCHING			= 2,	-- 매칭 진행중
	AS_MATCHING_INVITED = 3,	-- 매칭 초대중
	AS_PLAY				= 4,	-- 플레이중
	AS_RESULT_CLOSE		= 5,	-- 결과 창을 닫은 상태 
};

-- 속성
ATTRIBUTE_TYPE =
{
	AT_NONE				= 0,
	AT_HOLY				= 1,
	AT_UNHOLY			= 2,
	AT_FIRE				= 3,
	AT_COLD				= 4,
	AT_LIGHTNING		= 5,
	AT_POISON			= 6,
	AT_MAX				= 7,
};

-- Minimap_CashShop_stage
MINIMAP_CASHSHOP_STAGE = 
{
	MCS_NORMAL			= 0,	-- 기본 상태
	MCS_GIFT			= 1,	-- 선물 받은 상태
};

-- Ranking 
RANKING_TYPE =
{
	RT_PERSON			= 0,
	RT_GUILD			= 1,
};




















--[[

	Global functions

--]]


-- STR
function STR( _key)

	return gamefunc:GetString( _key);
end


-- FORMAT
function FORMAT( _key, _arg1, _arg2, _arg3, _arg4, _arg5)

	return gamefunc:GetFormatStr( _key, _arg1, _arg2, _arg3, _arg4, _arg5);
end


-- GetStyleTypeName
function GetStyleTypeName( nType)

	if ( nType == TALENT_TYPE.DEFENDER)  then			return STR( "STYLE_DEFENDER");
	elseif ( nType == TALENT_TYPE.BERSERKER)  then		return STR( "STYLE_BERSERKER");
	elseif ( nType == TALENT_TYPE.ASSASSIN)  then		return STR( "STYLE_ASSASSIN");
	elseif ( nType == TALENT_TYPE.RANGER)  then			return STR( "STYLE_RANGER");
	elseif ( nType == TALENT_TYPE.SORCERER)  then		return STR( "STYLE_SORCERER");
	elseif ( nType == TALENT_TYPE.CLERIC)  then			return STR( "STYLE_CLERIC");
	end
	return nil;
end

-- GetGuardCrashLevelName
function GetGuardCrashLevelName( nGuardCrashLevel)

	if ( nGuardCrashLevel == TALENT_GUARD_CRASH_LEVEL.PARTIAL)  then return STR( "GUARD_CRASH_LEVEL_PARTIAL");
	elseif ( nGuardCrashLevel == TALENT_GUARD_CRASH_LEVEL.PERFECT)  then			return STR( "GUARD_CRASH_LEVEL_PERFECT");
	elseif ( nGuardCrashLevel == TALENT_GUARD_CRASH_LEVEL.ABSOLUTE)  then			return STR( "GUARD_CRASH_LEVEL_ABSOLUTE");
	elseif ( nGuardCrashLevel == TALENT_GUARD_CRASH_LEVEL.ALL)  then			return STR( "GUARD_CRASH_LEVEL_ALL");
	end
	return nil;
end

-- GetWeaponTypeName
function GetWeaponTypeName( nType)

	if ( nType == WEAPON_TYPE.SLASH)  then				return STR( "WEAPON_SLASH");
	elseif ( nType == WEAPON_TYPE.BLUNT)  then			return STR( "WEAPON_BLUNT");
	elseif ( nType == WEAPON_TYPE.PIERCE)  then			return STR( "WEAPON_PIERCE");
	elseif ( nType == WEAPON_TYPE.TWO_HANDED)  then		return STR( "WEAPON_2HANDED");
	elseif ( nType == WEAPON_TYPE.STAFF)  then			return STR( "WEAPON_STAFF");
	elseif ( nType == WEAPON_TYPE.ARCHERY)  then		return STR( "WEAPON_ARCHERY");
	elseif ( nType == WEAPON_TYPE.TWO_BLUNT) then		return STR( "WEAPON_2BLUNT");
	elseif ( nType == WEAPON_TYPE.DUAL_PIERCE)  then	return STR( "WEAPON_2PIERCE");
	end
	return nil;
end


-- GetArmorTypeName
function GetArmorTypeName( nType)

	if ( nType == ARMOR_TYPE.CLOTH_ARMOR)  then			return STR( "ARMOR_CLOTH");
	elseif ( nType == ARMOR_TYPE.LEATHER_ARMOR)  then	return STR( "ARMOR_LEATHER");
	elseif ( nType == ARMOR_TYPE.CHAIN_MAIL)  then		return STR( "ARMOR_CHAINMAIL");
	elseif ( nType == ARMOR_TYPE.PLATE_ARMOR)  then		return STR( "ARMOR_PLATE");
	elseif ( nType == ARMOR_TYPE.SHIELD)  then			return STR( "ARMOR_SHIELD");
	elseif ( nType == ARMOR_TYPE.ACCESSORY)  then		return STR( "ARMOR_ACCESSORY");
	end
	return nil;
end


-- GetItemSlotName
function GetItemSlotName( nSlot)

	if ( nSlot == ITEM_SLOT.HEAD)  then					return STR( "ITEMSLOT_HEAD");
	elseif ( nSlot == ITEM_SLOT.FACE)  then				return STR( "ITEMSLOT_FACE");
	elseif ( nSlot == ITEM_SLOT.HANDS)  then			return STR( "ITEMSLOT_HANDS");
	elseif ( nSlot == ITEM_SLOT.FEET)  then				return STR( "ITEMSLOT_FEET");
	elseif ( nSlot == ITEM_SLOT.BODY)  then				return STR( "ITEMSLOT_BODY");
	elseif ( nSlot == ITEM_SLOT.LEG)  then				return STR( "ITEMSLOT_LEGS");
	elseif ( nSlot == ITEM_SLOT.NECK) then				return STR( "ITEMSLOT_NECKLACE");
	elseif ( nSlot == ITEM_SLOT.LFINGER)  or  ( nSlot == ITEM_SLOT.RFINGER)  then		return STR( "ITEMSLOT_RING");
	elseif ( nSlot == ITEM_SLOT.LWEAPON)  or  ( nSlot == ITEM_SLOT.LWEAPON2)   then		return STR( "ITEMSLOT_SUBWEAPONSET");
	elseif ( nSlot == ITEM_SLOT.RWEAPON)  or  ( nSlot == ITEM_SLOT.RWEAPON2)  then		return STR( "ITEMSLOT_WEAPONSET");
	elseif ( nSlot == ITEM_SLOT.LOOK_HEAD)  then		return STR( "ITEMSLOT_LOOK_HEAD");
	elseif ( nSlot == ITEM_SLOT.LOOK_HANDS) then		return STR( "ITEMSLOT_LOOK_HANDS");
	elseif ( nSlot == ITEM_SLOT.LOOK_FEET)  then		return STR( "ITEMSLOT_LOOK_FEET");
	elseif ( nSlot == ITEM_SLOT.LOOK_BODY)  then		return STR( "ITEMSLOT_LOOK_BODY");
	elseif ( nSlot == ITEM_SLOT.LOOK_LEG)  then			return STR( "ITEMSLOT_LOOK_LEG");
	elseif ( nSlot == ITEM_SLOT.LOOK_LWEAPON)  then		return STR( "ITEMSLOT_LOOK_LWEAPON");
	elseif ( nSlot == ITEM_SLOT.LOOK_RWEAPON)  then		return STR( "ITEMSLOT_LOOK_RWEAPON");
	
	end
	return nil;
end


-- GetItemTierString
function GetItemTierString( nItemID)

	if ( gamefunc:IsItemQuestRelated( nItemID) == true)  then  return STR( "TIER_RELATEDQUEST");
	end

	local nTier = gamefunc:GetItemTier( nItemID);
	if ( nTier == ITEM_TIER.VERYCOMMON)  then			return STR( "TIER_VERYCOMMON");
	elseif ( nTier == ITEM_TIER.COMMON)  then			return STR( "TIER_COMMON");
	elseif ( nTier == ITEM_TIER.RARE)  then				return STR( "TIER_RARE");
	elseif ( nTier == ITEM_TIER.TREASURE)  then			return STR( "TIER_TREASURE");
	elseif ( nTier == ITEM_TIER.LEGENDARY)  then		return STR( "TIER_LEGENDARY");
	elseif ( nTier == ITEM_TIER.EPIC)  then				return STR( "TIER_EPIC");
	end
	return nil;
end


-- GetItemColor
function GetItemColor( nItemID)

	if ( gamefunc:IsItemQuestRelated( nItemID) == true)  then  
		return 174, 144, 94;
	end	
	
	local nTier = gamefunc:GetItemTier( nItemID);
	if ( nTier == ITEM_TIER.VERYCOMMON)  then			return 128, 128, 128;
	elseif ( nTier == ITEM_TIER.COMMON)  then			return 230, 230, 230;
	elseif ( nTier == ITEM_TIER.RARE)  then				return 75,  175, 75;
	elseif ( nTier == ITEM_TIER.TREASURE)  then			return 90,  210, 255;
	elseif ( nTier == ITEM_TIER.LEGENDARY)  then		return 193, 45,  255;
	elseif ( nTier == ITEM_TIER.EPIC)  then				return 255, 215, 0;
	end

	return 255, 255, 255;
end

function GetItemColorStr( nItemID )
	if ( gamefunc:IsItemQuestRelated( nItemID) == true)  then  
		return BrownColor();
	end	
	
	local nTier = gamefunc:GetItemTier( nItemID);
	
	if ( nTier == ITEM_TIER.VERYCOMMON)  then			return GrayColor();
	elseif ( nTier == ITEM_TIER.COMMON)  then			return WhiteColor();
	elseif ( nTier == ITEM_TIER.RARE)  then				return GreenColor();
	elseif ( nTier == ITEM_TIER.TREASURE)  then			return SkyColor();
	elseif ( nTier == ITEM_TIER.LEGENDARY)  then		return PurpleColor();
	elseif ( nTier == ITEM_TIER.EPIC)  then				return YellowColor();
	end
	
	return VividWriteColor();
end

-- GetLicenseName
function GetLicenseName( nLicense)

	if ( nLicense == LICENSE_TYPE.MEDUIMARMOR)  then		return STR( "LICENSE_MEDIUMARMOR");
	elseif ( nLicense == LICENSE_TYPE.HEAVYARMOR)  then		return STR( "LICENSE_HEAVYARMOR");
	end
	
	return "";
end



function Color( colorR, colorG, colorB )
	return "{COLOR r=" .. colorR.. " g=" .. colorG .. " b=" .. colorB  .." }";
end

function SkyColor()
	return "{COLOR r=90 g=210 b=255}";
end

function RedColor()
	return "{COLOR r=160 g=32 b=32}";
end

function GreenColor()
	return "{COLOR r=111 g=220 b=89}";
end

function SkyBlueColor()
	return "{COLOR r=100 g=160 b=160}";
end

function BrownColor()
	return "{COLOR r=174 g=144 b=94}";
end

function SandyBrownColor()
	return "{COLOR r=210 g=166 b=129}";
end

function VividWriteColor()
	return "{COLOR r=255 g=255 b=255}";
end

function WhiteColor()
	return "{COLOR r=230 g=230 b=230}";
end

function GrayColor()
	return  "{COLOR r=128 g=128 b=128}";
end

function YellowColor()
	return "{COLOR r=230 g=190 b=0}";
end

function PurpleColor()
	return "{COLOR r=193 g=45 b=255}";
end

function OrangeColor()
	return "{COLOR r=254 g=165 b=0}"
end

function SteelBlue()
	return "{COLOR r=33 g=102 b=166}";
end

function ToolTipDivideColor()
	return "{COLOR r=111 g=220 b=89}"
end

function PinkColor()
	return "{COLOR r=255 g=128 b=128}"
end

function EndColor()
	return "{/COLOR}";
end


function LineFree( Line )

	if(Line == nil) or ( Line < 1) then
		return "{CR}";
	end
	
	local reStr = "";
	for  i = 0, ( Line - 1)  do
		reStr = reStr .. "{CR}";
	end
	
	return reStr;
end

function LineFreeH( Height )
	if(Height == nil) or ( Height < 0 ) then
		Height = 0;
	end
	
	return "{CR h=" .. Height .. "}"
end

function FontMainName()
	return Font("fntTTMainName");
end

function FontImportant()
	return Font("fntTTImportant");
end

function FontHighlight()
	return Font("fntTTHighlight");
end

function FontNormal()
	return Font("fntTTNormal");
end

function FontMild()
	return Font("fntTTMild");
end

function FontSmall()
	return Font("fntTTSmall");
end

function Font( fntName )

	if(fntName == nil) then
		fntName = ""
	end
	
	return "{FONT name=\"" .. fntName .. "\"}";
end

function EndFont()
	return "{/FONT}";
end

function BitMap( BitMapName, width, height )

	if(BitMapName == nil) or (width == 0) or (height == 0) then
		return "";
	end
	
	return "{BITMAP name=\"" .. BitMapName .. "\"" .. "w=" ..width .. " h=" .. height .. "}";

end

function Space( width, height )
	return "{SPACE w=" .. width .. "h=".. height .. "}";
end

function Align( align )
	if(align == nil) then
		fntName = ""
	end
	
	return "{ALIGN hor=\"" .. align .. "\"}";
end

function Indent( value )
	return "{INDENT dent=" .. value .. "}" ;
end

function EndIndent()
	return "{/INDENT}";
end

function HorBar2()

	return "{CR h=8}{ALIGN hor=\"justify\"}{BITMAP name=\"bmpDefSeperateBarHor2\" w=375 h=2}{CR h=8}";

end

function FontRecipeItemName()
	return Font("fntRecipeItemName");
end


function FontRecipeNormal()
	return Font("fntRecipeNormal");
end