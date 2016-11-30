--[[
	Game LUA defines
--]]


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
	HOUSING				= 3,
	USABLE				= 4,
	_reserved001		= 5,
	INVENTORY			= 6,
	GATHER				= 7,
	ENCHANT				= 8,
	DYE					= 9
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
	EARRING				= 9,
	LWEAPON				= 10,
	RWEAPON				= 11,
	LWEAPON2			= 12,
	RWEAPON2			= 13
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
	GESTURE				= 9
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
	SPAWN				= 7
};


-- License type
LICENSE_TYPE =
{
	NONE				= 0,
	MEDUIMARMOR			= 23,
	HEAVYARMOR			= 24
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
};


-- Journal indicator object type
JOURNALOBJ_TYPE =
{
	NONE				= 0,
	QUEST				= 1,
	RECIPE				= 2
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
	DYE					= 4
};


-- Client hit test
HITTEST =
{
	NOWHERE				= 0,
	CLIENT				= 1,
	CAPTION				= 2
};


-- Type of enchant
ENCHANT_TYPE =
{
	NONE				= 0,
	STONE				= 1,
	SPECIALSTONE		= 2,
	AGENT				= 3
};


-- Type of enchant hole
ENCHANTHOLE_TYPE =
{
	NONE				= 0,
	GENERAL				= 1,
	SPECIAL				= 2
};




--[[ 정리가 필요한 것들... ]]--

-- Channel state
CHANNEL_STATE =
{
	GOOD				= 0,
	BUSY				= 1,
	FULL				= 2
};


-- Type of mission
MISSION_TYPE =
{
	NONE				= 0,
	TIMELIMIT			= 1,
	QUESTPVP			= 2
};


CHALLENGERQUESTUNABLETYPE =
{
	CQUT_OK						= 0,	-- 받을 수 있음
	CQUT_FAIL_QUEST_CONDITION	= 1,	-- 퀘스트 컨디션 조건 불총족
	CQUT_FAIL_QUEST_NOT_TODAY	= 2		-- 오늘의 퀘스트가 아님
};

-- Guide Msg , XGuideMsgEnum과 값이 같아야 합니다. - birdkr
GUIDEMSG_TYPE = 
{
	NA 						= 0,
	LEVEL_UP				= 1,	-- 레벨업 했을 때
	CAN_LOOT				= 2,	-- 루팅 가능할 때
	CAN_INTERACT_TO_NPC		= 3,	-- NPC 앞에서 인터랙션 가능할 때
	
	LUA_RECV_INVITE_PARTY		= 101,	-- 파티초대 팝업 메세지 받았을 때
	LUA_RECV_INVITE_GUILD		= 102,	-- 길드초대 팝업 메세지 받았을 때
	LUA_RECV_TRADE_REQUESTED	= 103,	-- 거래요청 팝업 메세지 받았을 때
	LUA_RECV_DUEL_CHALLENGED	= 104,	-- 결투신청 팝업 메세지 받았을 때
};


DEFENDER_STYLE = 
{
	FOCUS_TALENT			= 12000;
	FOCUS_STR				= "역습";
	FOCUS_BUFF				= 1552;
};

BERSERKER_STYLE =
{
	FOCUS_TALENT			= 22000;
	FOCUS_STR				= "격분";
	FOCUS_BUFF				= 1551;
};

CLERIC_STYLE =
{
	FOCUS_TALENT			= 60501;
	FOCUS_STR				= "강신";
	FOCUS_BUFF				= 1550;
};

ENCHANT_COLOR =
{
	ENCHANT_NONE			= 0,
	ENCHANT_RED				= 1,
	ENCHANT_ORANGE			= 2,
	ENCHANT_BLUE			= 3,
	ENCHANT_GREEN			= 4,
	ENCHANT_WHITE			= 5,
	ENCHANT_YELLOW			= 6,
};

PERCENTAGE_TYPE =
{
	PER_NONE				= 0,
	PER_PERCENTAGE			= 1,			-- 백분율
	PER_MULTI_PERCENTAGE	= 2,			-- 백분율(100을 곱함)
	PER_PERMILLAGE			= 3,			-- 천분율
};

AUTOPARTY_STATE =
{
	AS_INVALID				=-1,	-- 무효한 상태
	AS_OFF					=0,		-- 사용 안함
	AS_PAUSE				=1,		-- 중지
	AS_STANDBY				=2,		-- 검색 대기
	AS_LOOKUP				=3,		-- 검색중
};















--[[

	Game strings

--]]


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

	if ( gamefunc:IsItemQuestRelated( nItemID) == true)  then  return 174, 144, 94;
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


-- GetLicenseName
function GetLicenseName( nLicense)

	if ( nLicense == LICENSE_TYPE.MEDUIMARMOR)  then		return STR( "LICENSE_MEDIUMARMOR");
	elseif ( nLicense == LICENSE_TYPE.HEAVYARMOR)  then		return STR( "LICENSE_HEAVYARMOR");
	end
	
	return "";
end
