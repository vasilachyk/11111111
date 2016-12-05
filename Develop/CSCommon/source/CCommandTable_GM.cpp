#include "stdafx.h"
#include "CCommandTable_GM.h"
#include "MCommandDesc.h"
#include "MCommand.h"

using namespace minet;

void AddGMCommandTable()
{
	BEGIN_CMD_DESC();

	// GM ---------------
	C(MC_GM_GET_PLAYERUID_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Get PlayerUID")
											P(MPT_WSTR,		"strPlayerName")
	C(MC_GM_GET_PLAYERUID,					MCDT_MACHINE2MACHINE, MCF_S2C, "Response GM Get PlayerUID")
											P(MPT_UID,		"uidPlayerUID")
	C(MC_GM_SHOW_ENEMY_UID_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Show Enemy UID Req")
	C(MC_GM_SHOW_ENEMY_UID,					MCDT_MACHINE2MACHINE, MCF_S2C, "Show Enemy UID")
											P(MPT_BLOB,		"uid")

	C(MC_GM_SET_ME_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request Set MyInfo")
											P(MPT_WSTR,		"Type")
											P(MPT_WSTR,		"Value")
	C(MC_GM_FULL_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Full HP/EP/SP")

	C(MC_GM_GOD_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM God Mode")
	C(MC_GM_GOD,							MCDT_MACHINE2MACHINE, MCF_S2C, "GM God Mode")
											P(MPT_BOOL,		"GOD")
	C(MC_GM_GHOST_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Ghost Mode")
	C(MC_GM_GHOST,							MCDT_MACHINE2MACHINE, MCF_S2C, "GM Ghost Mode")
											P(MPT_BOOL,		"Enable")

	C(MC_GM_REBIRTH_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Rebirth")
											P(MPT_VEC,		"Position")
	C(MC_GM_REGEN_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request Regen")
	C(MC_GM_RESET_COOLTIME_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Reset CoolTime")

	// MG_GM_CONDITIONCHECK

	C(MC_GM_KILL_ENTITY_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Kill Entity")
											P(MPT_USHORT,	"nUIID")
	// MC_GM_KICK_PLAYER_REQ

	C(MC_GM_REQUEST_SPAWN,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request Spawn NPC")
											P(MPT_INT,		"nNPCID")
											P(MPT_INT,		"nCount")
											P(MPT_VEC,		"vSpawnPos")
	C(MC_GM_REQUEST_DESPAWN,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Despawn NPC")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_DESPAWNBYID_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request DespawnByID NPC")
											P(MPT_INT,		"nNPCID")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_RANGE_KILL_NPC_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Range Kill NPC")
											P(MPT_FLOAT,	"fRange")		
	C(MC_GM_RANGE_AGGRO_NPC_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Range Aggro NPC")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_RANGE_WEAKEN_NPC_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Range Weaken NPC")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_RANGE_DESPAWN_CORPSE_REQ,		MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Range Despawn Corpse")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_RANGE_BREAK_PART_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Range Break Part Req")
											P(MPT_FLOAT,	"fRange")
	C(MC_GM_BREAK_PART_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Break Part Req")
											P(MPT_UID,		"uidNPC")
											P(MPT_UCHAR,	"nBPartID")

	C(MC_GM_CHANGE_WEATHER_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Change Weather")
											P(MPT_INT,		"nWeather")
	C(MC_GM_CHANGE_TIME_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Change Time")
											P(MPT_INT,		"nTime")

	// MC_GM_QUESTPVPEVENT_BEGIN_REQ

	C(MC_GM_MOVE_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Move")
											P(MPT_INT,		"nFieldID")
											P(MPT_VEC,		"vPosition")
											P(MPT_SVEC,		"vDirection")
	C(MC_GM_MOVE_TO_PLAYER_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Move To Player")
											P(MPT_WSTR,		"PlayerID")
	C(MC_GM_MOVE_TO_NPC_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Move To NPC Req")
											P(MPT_INT,		"nNPCID")
											P(MPT_INT,		"nFieldID")
	C(MC_GM_SUMMON_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request Summon")
											P(MPT_WSTR,		"PlayerID")

	C(MC_GM_ITEM_GIVE_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Give Item")
											P(MPT_INT,		"nItemID")
											P(MPT_INT,		"nQuantity")
	// MC_GM_ENCHANT_ITEM_GIVE_REQ
	C(MC_GM_ITEM_REPAIR_ALL,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Repair All Item")
	C(MC_GM_CLEAR_INVENTORY_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Clear Inventory")
	C(MC_GM_DYE_REQ,						MCDT_MACHINE2MACHINE, MCF_C2S, "Request Dye")
											P(MPT_INT,		"nSlotType")
											P(MPT_INT,		"nSlotID")
											P(MPT_INT,		"nColor")

	C(MC_GM_INSERT_BUFF_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Insert Buff Req")
											P(MPT_INT,		"nBuffID")
											P(MPT_FLOAT,	"fDurationTime")
											P(MPT_FLOAT,	"fPeriodTime")
	C(MC_GM_DELETE_BUFF_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Delete Buff Req")										
											P(MPT_INT,		"nBuffID")

	C(MC_GM_FACTION_INCREASE_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Faction Increase")
											P(MPT_UCHAR,	"nFactionID")
											P(MPT_USHORT,	"nQuantity")
	C(MC_GM_FACTION_DECREASE_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Faction Decrease")
											P(MPT_UCHAR,	"nFactionID")
											P(MPT_USHORT,	"nQuantity")
	C(MC_GM_FACTION_RESET_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Faction Reset")											

	C(MC_GM_QUEST_GIVE_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Give Quest")
											P(MPT_INT,		"nQue stID")
	C(MC_GM_QUEST_RESET_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Reset DoneQuest")
	C(MC_GM_QUEST_RESET,					MCDT_MACHINE2MACHINE, MCF_S2C, "Reset DoneQuest")
	C(MC_GM_QUEST_RESET_ALL_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request Reset AllQuest")
	C(MC_GM_QUEST_COMPLETE_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Quest Complete Req")
											P(MPT_INT,		"nQuestID")
	C(MC_GM_QUEST_VAR_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Quest Var Req")
											P(MPT_INT,		"nQuestID")
	C(MC_GM_QUEST_VAR,						MCDT_MACHINE2MACHINE, MCF_S2C, "Quest Var")
											P(MPT_INT,		"nVar")
	C(MC_GM_QUEST_FAIL_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Fail Quest")
											P(MPT_INT,		"nQuestID")
	C(MC_GM_QUEST_REWARD_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Quest Reward")
											P(MPT_INT,		"nQuestID")

	// MC_GM_VALIDATOR_REQ
	// MC_GM_VALIDATOR

	C(MC_GM_CHANGE_SERVER_MODE_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request Change Server Mode")
											P(MPT_INT,		"nServerMode")
	C(MC_GM_CHANGE_SERVER_MODE,				MCDT_MACHINE2MACHINE, MCF_S2C, "Change Server Mode")
											P(MPT_INT,		"nServerMode")
	C(MC_GM_RESET_EXPO_CHARACTERS_REQ,		MCDT_MACHINE2MACHINE, MCF_C2S, "Request Reset Expo Characters")
	// MC_GM_PC_CAFE_SERVICE_ENABLE_REQ
	// MC_GM_PC_CAFE_SERVICE_DISABLE_REQ

	// MC_GM_GUIDEBOOK_RESET_REQ
	// MC_GM_GUIDEBOOK_RESET

	// MC_GM_TMARKET_ON
	// MC_GM_TMARKET_OFF

	// MC_GM_EVENT_RELOAD_REQ
	// MC_GM_EVENT_RELOAD

	// MC_GM_WHITELIST_ON
	// MC_GM_WHITELIST_OFF

	// MC_GM_SHUTDOWN_REQ

	// MC_GM_PENALTY_INSERT_REQ
	// MC_GM_PENALTY_DELETE_REQ

	// MC_GM_BATTLE_ARENA_SERVICE_REQ
	// MC_GM_BATTLE_ARENA_SERVICE_RES

	// MC_DEBUG_BATTLE_ARENA_GUILD_MEMBER

	// TEST -------------
	C(MC_DEBUG_STRING,						MCDT_MACHINE2MACHINE, MCF_S2C, "DebugString")
											P(MPT_WSTR,		"Key")
											P(MPT_INT,		"Param1")
											P(MPT_WSTR,		"Text")
											P(MPT_BLOB,		"AdditionData")
	C(MC_DEBUG_STRING_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "RequestDebugString")
											P(MPT_WSTR,		"Key")
											P(MPT_INT,		"Param1")
											P(MPT_WSTR,		"Text")
											P(MPT_BLOB,		"AdditionData")

	C(MC_AI_DEBUG_MESSAGE,					MCDT_MACHINE2MACHINE, MCF_S2C, "AI Debug Message")
											P(MPT_UID,		"uidNPC")
											P(MPT_WSTR,		"Message")
	C(MC_DEBUG_COMBATCALC,					MCDT_MACHINE2MACHINE, MCF_S2C, "Debug CombatCalc")
											P(MPT_WSTR,		"Type")
											P(MPT_WSTR,		"Message")
	C(MC_GM_REPORT_TARGET_ENTITY,			MCDT_MACHINE2MACHINE, MCF_C2S, "Report Target Entity")
											P(MPT_UID,		"uidTarget")

	C(MC_GM_SERVER_DUMP_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Server Dump")
											P(MPT_WSTR,		"Identifier")
	C(MC_GM_SERVER_DUMP_RESP,				MCDT_MACHINE2MACHINE, MCF_S2C, "Response Server Dump")

	C(MC_DEBUG_START_COMMAND_PROFILE,		MCDT_MACHINE2MACHINE, MCF_C2S, "StartCommandProfile")
	C(MC_DEBUG_END_COMMAND_PROFILE,			MCDT_MACHINE2MACHINE, MCF_C2S, "EndCommandProfile")
	C(MC_DEBUG_DUMP_COMMAND_PROFILE,		MCDT_MACHINE2MACHINE, MCF_C2S, "DumpCommandProfile")

	// MC_TEST_SPAWN

	// MC_GM_AI_OFF_REQ
	C(MC_GM_AI_RUNNING_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request AI Running")
	C(MC_GM_NPC_AI_RUNNING_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request GM Toggle NPC AI")
											P(MPT_UID,		"uidNPC")
	C(MC_GM_AI_USE_TALENT_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Command AI")
											P(MPT_UID,		"uidNPC")
											P(MPT_WSTR,		"Command")
											P(MPT_WSTR,		"Param")
	C(MC_GM_AI_SET_MONITOR_TARGET,			MCDT_MACHINE2MACHINE, MCF_C2S, "Request Set Monitor NPC")
											P(MPT_USHORT,		"nNPCUIID")

	C(MC_GM_SET_NPC_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request Set NPCInfo")
											P(MPT_WSTR,		"Type")
											P(MPT_WSTR,		"Value")
	// MC_TEST_DYNAMIC_FIELD_ENTER_REQ
	C(MC_GM_SET_ITEM_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Request Set ItemInfo")
											P(MPT_WSTR,		"Type")
											P(MPT_INT,		"nInvenSlotID")											
											P(MPT_INT,		"Value")

	// MC_DEBUG_TRADEMARKET_ADD_HOUR
	// MC_DEBUG_TRADEMARKET_TIME_RESET

	// º¸¾È(GameGuard) ------------------------------------------------------------------------------------------
	C(MC_GG_AUTH_ENABLE,					MCDT_MACHINE2MACHINE, MCF_C2S, "GameGuard Auth Enable")
											P(MPT_BOOL,		"bEnable")


	C(MC_DEBUG_ECHO_REQ,					MCDT_MACHINE2MACHINE, MCF_C2S, "Debug Echo Req")
											P(MPT_INT,		"nRouteType")
											P(MPT_INT,		"nDataSize")
											P(MPT_BLOB,		"Data")
	C(MC_DEBUG_ECHO,						MCDT_MACHINE2MACHINE, MCF_S2C, "Debug Echo")
											P(MPT_UID,		"uidRequester")
											P(MPT_BLOB,		"Data")

	C(MC_GM_ENABLE_ICHECK_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Interaction Check On")
	C(MC_GM_DISABLE_ICHECK_REQ,				MCDT_MACHINE2MACHINE, MCF_C2S, "Request Interaction Check Off")

	C(MC_GM_QUERY_MULTILOGIN_REQ,			MCDT_MACHINE2MACHINE, MCF_C2S, "QueryMultiLogin Req")
	C(MC_GM_QUERY_MULTILOGIN,				MCDT_MACHINE2MACHINE, MCF_S2C, "QueryMultiLogin")
											P(MPT_BOOL,		"bMultiLogin")

	// MC_GM_QPVP_TEAM_LIST_REQ
	// MC_GM_QPVP_TEAM_LIST

	END_CMD_DESC();
}
