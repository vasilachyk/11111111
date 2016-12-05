#ifndef _CCOMMAND_TABLE_GM_H
#define _CCOMMAND_TABLE_GM_H

#include "CSCommonLib.h"

enum CGMCommandTable
{
// 관리(GM) ------------------------------------------------------------------------------------------
/*
	MC_GM_REQUEST_SPAWN				= 9001,		///< (C->S) NPC 스폰 요청
	MC_GM_REQUEST_DESPAWN			= 9002,		///< (C->S) NPC 디스폰 요청
	MC_GM_MOVE_REQ					= 9003,		///< (C->S) GM 이동 요청
	MC_GM_MOVE_TO_PLAYER_REQ		= 9004,		///< (C->S) 특정 PC에게로 이동 요청
	MC_GM_MOVE_TO_MYSPOT_REQ		= 9005,		///< (C->S) 내 원 위치로 이동 요청(현재는 처음 스폰된 곳)
	MC_GM_REBIRTH_REQ				= 9006,		///< (C->S) GM 부활 요청
	MC_GM_GOD_REQ					= 9007,		///< (C->S) GM 무적 요청
	MC_GM_CHANGE_WEATHER_REQ		= 9008,		///< (C->S) 날씨 변경 요청
	MC_GM_CHANGE_TIME_REQ			= 9009,		///< (C->S) 시간 변경 요청
	MC_GM_QUEST_GIVE_REQ			= 9010,		///< (C->S) 퀘스트 제공을 요청
	MC_GM_ITEM_GIVE_REQ				= 9011,		///< (C->S) 아이템 제공 요청
	MC_GM_GOD						= 9012,		///< (S->C) GM 무적 응답
	MC_GM_AI_RUNNING_REQ			= 9013,		///< (C->S) AI 동작안하게 해주세요.
	MC_GM_AI_USE_TALENT_REQ			= 9014,		///< (C->S) 해당 NPC에게 특정 탤런트 사용하라고 명령
	MC_GM_AI_SET_MONITOR_TARGET		= 9015,		///< (C->S) 테스트 용도로 모니터링할 타겟 NPC 설정
	MC_GM_GET_PLAYERUID_REQ			= 9016,		///< (C->S) 플레이어 ID로 UID 요청
	MC_GM_GET_PLAYERUID				= 9017,		///< (S->C) 플레이어 ID로 UID 요청 응답
	MC_GM_REPORT_TARGET_ENTITY		= 9020,		///< (C->S) NPC Report
	MC_GM_KILL_ENTITY_REQ			= 9021,		///< (C->S) 엔터티 죽이기 요청
	MC_GM_RANGE_KILL_NPC_REQ		= 9022,		///< (C->S) 범위로 NPC 죽이기 요청
	MC_GM_SET_ME_REQ				= 9026,		///< (C->S) 내 정보 변경 요청
	MC_GM_QUEST_RESET_REQ			= 9027,		///< (C->S) 수행한 퀘스트 초기화 요청
	MC_GM_QUEST_RESET				= 9028,		///< (S->C) 수행한 퀘스트 초기화	
	MC_GM_SET_ITEM_REQ				= 9029,		///< (C->S) 아이템 정보 변경 요청
	MC_GM_NPC_AI_RUNNING_REQ		= 9030,		///< (C->S) 특정 NPC AI 토글 요청		
	MC_GM_INSERT_BUFF_REQ			= 9035,		///< (C->S)	버프 추가 요청
	MC_GM_DELETE_BUFF_REQ			= 9036,		///< (C->S)	버프 제거 요청
	MC_GM_RESET_COOLTIME_REQ		= 9037,		///< (C->S)	버프 제거 요청
	MC_GM_SHOW_ENEMY_UID_REQ		= 9038,		///< (C->S)	어그로를 가진 NPC UID 요청
	MC_GM_SHOW_ENEMY_UID			= 9039,		///< (S->C)	어그로를 가진 NPC UID
	MC_GM_MOVE_TO_NPC_REQ			= 9040,		///< (C->S) 특정 NPC에게로 이동 요청
	MC_GM_BREAK_PART_REQ			= 9041,		///< (C->S) 특정 NPC의 특정 bpart 부시기
	MC_GM_RANGE_BREAK_PART_REQ		= 9042,		///< (C->S) 주변 NPC의 모든 bpart 부시기
	MC_GM_QUEST_COMPLETE_REQ		= 9043,		///< (C->S) 퀘스트 완료
	MC_GM_QUEST_VAR_REQ				= 9044,		///< (C->S) quest_var 요청
	MC_GM_QUEST_VAR					= 9045,		///< (C->S) quest_var
	MC_GM_QUEST_FAIL_REQ			= 9046,		///< (C->S) 퀘스트 실패 요청
	MC_GM_CLEAR_INVENTORY_REQ		= 9047,		///< (C->S) 인벤토리 아이템 모두 제거
	MC_GM_QUEST_REWARD_REQ			= 9048,		///< (C->S) 퀘스트 보상받기

	MC_GM_LOG_CRT_INSERT_REQ		= 9050,		///< (C->S) FailCRT 로그 남기기 추가
	MC_GM_LOG_CRT_DELETE_REQ		= 9051,		///< (C->S) FailCRT 로그 남기기 제거
	MC_GM_LOG_CRT_LIST				= 9052,		///< (S->C) FailCRT 로그 남기는 목록
	MC_GM_QUERY_MULTILOGIN_REQ		= 9053,		///< (C->S) 멀티로그인 질의 요청
	MC_GM_QUERY_MULTILOGIN			= 9054,		///< (S->C) 멀티로그인 질의 응답


	MC_GM_FACTION_INCREASE_REQ		= 9060,		///< (C->S) 팩션 증가
	MC_GM_FACTION_DECREASE_REQ		= 9061,		///< (C->S) 팩션 감소
	MC_GM_SERVER_DUMP_REQ			= 9062,		///< (C->S) 서버 덤프 요청
	MC_GM_SERVER_DUMP_RESP			= 9063,		///< (C->S) 서버 덤프 응답
	MC_GM_GHOST_REQ					= 9064,		///< (C->S) GM 고스트 요청
	MC_GM_GHOST						= 9065,		///< (S->C) GM 고스트

	MC_GM_SPAWN						= 9066,		///< (S->C) GM NPC 스폰 처리 결과
	MC_GM_QUEST_RESET_ALL_REQ		= 9067,		///< (C->S) 수행한 퀘스트 및 가지고 있는 퀘스트 초기화 요청

	MC_GM_ENABLE_ICHECK_REQ			= 9068,		///< (C->S) 인터랙션 체크 켜기
	MC_GM_DISABLE_ICHECK_REQ		= 9069,		///< (C->S) 인터랙션 체크 끄기



	MC_GM_SET_NPC_REQ				= 9071,		///< (C->S) NPC의 상태값 변경 요청

	MC_GM_DYE_REQ					= 9072,		///< (C->S) 염색 요청

	MC_GM_SUMMON_REQ				= 9073,		///< (S->C) 특정 PC를 소환

	MC_GM_FACTION_RESET_REQ			= 9074,		///< (C->S) 팩션 초기화
	MC_GM_REGEN_REQ					= 9075,		///< (C->S) 생명력/정신력/기력[자동회복] 토글 요청
	MC_GM_DESPAWNBYID_REQ			= 9076,		///< (C->S) NPCID로 디스폰

	MC_GM_CHANGE_SERVER_MODE_REQ	= 9077,		///< (C->S) 서버 모드 변경 요청
	MC_GM_CHANGE_SERVER_MODE		= 9078,		///< (S->C) 서버 모드 변경

	MC_GM_RESET_EXPO_CHARACTERS_REQ	= 9079,		///< (C->S) Expo 용 캐릭터 Reset
	*/

	MC_GM_GET_PLAYERUID_REQ					= 8001,		///< (C->S) 플레이어 ID로 UID 요청
	MC_GM_GET_PLAYERUID						= 8002,		///< (S->C) 플레이어 ID로 UID 요청 응답
	MC_GM_SHOW_ENEMY_UID_REQ				= 8003,		///< (C->S)	어그로를 가진 NPC UID 요청
	MC_GM_SHOW_ENEMY_UID					= 8004,		///< (S->C)	어그로를 가진 NPC UID
	MC_GM_SET_ME_REQ						= 8005,		///< (C->S) 내 정보 변경 요청
	MC_GM_FULL_REQ							= 8006,
	MC_GM_GOD_REQ							= 8007,		///< (C->S) GM 무적 요청
	MC_GM_GOD								= 8008,		///< (S->C) GM 무적 응답
	MC_GM_GHOST_REQ							= 8009,		///< (C->S) GM 고스트 요청
	MC_GM_GHOST								= 8010,		///< (S->C) GM 고스트
	MC_GM_REBIRTH_REQ						= 8011,		///< (C->S) GM 부활 요청
	MC_GM_REGEN_REQ							= 8012,		///< (C->S) 생명력/정신력/기력[자동회복] 토글 요청
	MC_GM_RESET_COOLTIME_REQ				= 8013,		///< (C->S)	버프 제거 요청
	MG_GM_CONDITIONCHECK					= 8014,
	MC_GM_KILL_ENTITY_REQ					= 8015,		///< (C->S) 엔터티 죽이기 요청
	MC_GM_KICK_PLAYER_REQ					= 8016,
	MC_GM_REQUEST_SPAWN						= 8017,		///< (C->S) NPC 스폰 요청
	MC_GM_REQUEST_DESPAWN					= 8018,		///< (C->S) NPC 디스폰 요청
	MC_GM_DESPAWNBYID_REQ					= 8019,		///< (C->S) NPCID로 디스폰
	MC_GM_RANGE_KILL_NPC_REQ				= 8020,		///< (C->S) 범위로 NPC 죽이기 요청
	MC_GM_RANGE_AGGRO_NPC_REQ				= 8021,
	MC_GM_RANGE_WEAKEN_NPC_REQ				= 8022,
	MC_GM_RANGE_DESPAWN_CORPSE_REQ			= 8023,
	MC_GM_RANGE_BREAK_PART_REQ				= 8024,		///< (C->S) 주변 NPC의 모든 bpart 부시기
	MC_GM_BREAK_PART_REQ					= 8025,		///< (C->S) 특정 NPC의 특정 bpart 부시기
	MC_GM_CHANGE_WEATHER_REQ				= 8026,		///< (C->S) 날씨 변경 요청
	MC_GM_CHANGE_TIME_REQ					= 8027,		///< (C->S) 시간 변경 요청
	MC_GM_QUESTPVPEVENT_BEGIN_REQ			= 8028,
	MC_GM_MOVE_REQ							= 8029,		///< (C->S) GM 이동 요청
	MC_GM_MOVE_TO_PLAYER_REQ				= 8030,		///< (C->S) 특정 PC에게로 이동 요청
	MC_GM_MOVE_TO_NPC_REQ					= 8031,		///< (C->S) 특정 NPC에게로 이동 요청
	MC_GM_SUMMON_REQ						= 8032,		///< (S->C) 특정 PC를 소환
	MC_GM_ITEM_GIVE_REQ						= 8033,		///< (C->S) 아이템 제공 요청
	MC_GM_ENCHANT_ITEM_GIVE_REQ				= 8034,
	MC_GM_ITEM_REPAIR_ALL					= 8035,
	MC_GM_CLEAR_INVENTORY_REQ				= 8036,		///< (C->S) 인벤토리 아이템 모두 제거
	MC_GM_DYE_REQ							= 8037,		///< (C->S) 염색 요청
	MC_GM_INSERT_BUFF_REQ					= 8038,		///< (C->S)	버프 추가 요청
	MC_GM_DELETE_BUFF_REQ					= 8039,		///< (C->S)	버프 제거 요청
	MC_GM_FACTION_INCREASE_REQ				= 8040,		///< (C->S) 팩션 증가
	MC_GM_FACTION_DECREASE_REQ				= 8041,		///< (C->S) 팩션 감소
	MC_GM_FACTION_RESET_REQ					= 8042,		///< (C->S) 팩션 초기화
	MC_GM_QUEST_GIVE_REQ					= 8043,		///< (C->S) 퀘스트 제공을 요청
	MC_GM_QUEST_RESET_REQ					= 8044,		///< (C->S) 수행한 퀘스트 초기화 요청
	MC_GM_QUEST_RESET						= 8045,		///< (S->C) 수행한 퀘스트 초기화
	MC_GM_QUEST_RESET_ALL_REQ				= 8046,		///< (C->S) 수행한 퀘스트 및 가지고 있는 퀘스트 초기화 요청
	MC_GM_QUEST_COMPLETE_REQ				= 8047,		///< (C->S) 퀘스트 완료
	MC_GM_QUEST_VAR_REQ						= 8048,		///< (C->S) quest_var 요청
	MC_GM_QUEST_VAR							= 8049,		///< (C->S) quest_var
	MC_GM_QUEST_FAIL_REQ					= 8050,		///< (C->S) 퀘스트 실패 요청
	MC_GM_QUEST_REWARD_REQ					= 8051,		///< (C->S) 퀘스트 보상받기
	MC_GM_VALIDATOR_REQ						= 8052,
	MC_GM_VALIDATOR							= 8053,
	MC_GM_CHANGE_SERVER_MODE_REQ			= 8054,		///< (C->S) 서버 모드 변경 요청
	MC_GM_CHANGE_SERVER_MODE				= 8055,		///< (S->C) 서버 모드 변경
	MC_GM_RESET_EXPO_CHARACTERS_REQ			= 8056,		///< (C->S) Expo 용 캐릭터 Reset
	MC_GM_PC_CAFE_SERVICE_ENABLE_REQ		= 8057,
	MC_GM_PC_CAFE_SERVICE_DISABLE_REQ		= 8058,
	MC_GM_GUIDEBOOK_RESET_REQ				= 8059,
	MC_GM_GUIDEBOOK_RESET					= 8060,
	MC_GM_TMARKET_ON						= 8061,
	MC_GM_TMARKET_OFF						= 8062,
	MC_GM_EVENT_RELOAD_REQ					= 8063,
	MC_GM_EVENT_RELOAD						= 8064,
	MC_GM_WHITELIST_ON						= 8065,
	MC_GM_WHITELIST_OFF						= 8066,
	MC_GM_SHUTDOWN_REQ						= 8067,
	MC_GM_PENALTY_INSERT_REQ				= 8068,
	MC_GM_PENALTY_DELETE_REQ				= 8069,
	MC_GM_BATTLE_ARENA_SERVICE_REQ			= 8070,
	MC_GM_BATTLE_ARENA_SERVICE_RES			= 8071,
	MC_DEBUG_BATTLE_ARENA_GUILD_MEMBER		= 8072,

// 테스트(TEST) -----------------------------------------------------------------------------------------
	MC_DEBUG_STRING							= 9001,		///< (S->C) 디버그 스트링을 클라이언트로 보내준다.
	MC_DEBUG_STRING_REQ						= 9002,		///< (C->S) 디버그 스트링을 서버로 보내준다.
	MC_AI_DEBUG_MESSAGE						= 9003,		///< (S->C) AI 디버그 정보를 클라이언트로 보내준다.
	MC_DEBUG_COMBATCALC						= 9004,		///< (S->C) 전투 공식 디버그 정보를 클라이언트로 보내준다.
	MC_GM_REPORT_TARGET_ENTITY				= 9005,		///< (C->S) NPC Report
	MC_GM_SERVER_DUMP_REQ					= 9006,		///< (C->S) 서버 덤프 요청
	MC_GM_SERVER_DUMP_RESP					= 9007,		///< (C->S) 서버 덤프 응답
	MC_DEBUG_START_COMMAND_PROFILE			= 9008,		///< (C->S) 커맨드 프로파일링 시작
	MC_DEBUG_DUMP_COMMAND_PROFILE			= 9009,		///< (C->S) 커맨드 프로파일 덤프
	MC_DEBUG_END_COMMAND_PROFILE			= 9010,		///< (C->S) 커맨드 프로파일링 끝
	MC_TEST_SPAWN							= 9011,
	MC_GM_AI_OFF_REQ						= 9012,
	MC_GM_AI_RUNNING_REQ					= 9013,		///< (C->S) AI 동작안하게 해주세요.
	MC_GM_NPC_AI_RUNNING_REQ				= 9014,		///< (C->S) 특정 NPC AI 토글 요청		
	MC_GM_AI_USE_TALENT_REQ					= 9015,		///< (C->S) 해당 NPC에게 특정 탤런트 사용하라고 명령
	MC_GM_AI_SET_MONITOR_TARGET				= 9016,		///< (C->S) 테스트 용도로 모니터링할 타겟 NPC 설정
	MC_GM_SET_NPC_REQ						= 9017,		///< (C->S) NPC의 상태값 변경 요청
	MC_TEST_DYNAMIC_FIELD_ENTER_REQ			= 9018,
	MC_GM_SET_ITEM_REQ						= 9019,		///< (C->S) 아이템 정보 변경 요청
	MC_DEBUG_TRADEMARKET_ADD_HOUR			= 9020,
	MC_DEBUG_TRADEMARKET_TIME_RESET			= 9021,
	MC_GG_AUTH_ENABLE						= 9022,		///< (C->S) 인증 켤지 끌지 여부
	MC_DEBUG_ECHO_REQ						= 9023,		///< (C->S) 에코 요청
	MC_DEBUG_ECHO							= 9024,		///< (S->C) 에코 응답
	MC_GM_ENABLE_ICHECK_REQ					= 9025,		///< (C->S) 인터랙션 체크 켜기
	MC_GM_DISABLE_ICHECK_REQ				= 9026,		///< (C->S) 인터랙션 체크 끄기
	MC_GM_QUERY_MULTILOGIN_REQ				= 9027,		///< (C->S) 멀티로그인 질의 요청
	MC_GM_QUERY_MULTILOGIN					= 9028,		///< (S->C) 멀티로그인 질의 응답

};

CSCOMMON_API void AddGMCommandTable();

#endif
