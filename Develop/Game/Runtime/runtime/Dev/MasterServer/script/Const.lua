--============================================
-- filename: Const.lua
-- 설명: 스크립트나 C++에서 사용하는 상수
--
--============================================

--======================================================
-- C++에서 사용하는 상수
-- 상수 이름을 변경할 경우 C++에도 함께 변경해야 한다.
--======================================================

WORLD_PLAYER_LIMIT = 5000;	-- 서버군 최대 접속 인원 수
GAME_SERVER_PLAYER_COUNT_LIMIT = 1000;			-- 게임 서버에 접속할 수 있는 플레이어의 최대 개수
GAME_SERVER_DYNAMIC_FIELD_COUNT_LIMIT = 5000;	-- 게임 서버에 생성할 수 있는 동적필드의 최대 개수
GAME_SERVER_SERVABLE_CPU = 100;				-- 게임서버 서비스 가능 최대 CPU
GAME_SERVER_SERVABLE_FPS = 5;				-- 게임서버 서비스 가능 최소 FPS
GAME_SERVER_SERVABLE_MEM = 1700;				-- 게임서버 서비스 가능 최대 Memory MB

FITNESS_ADDITIONAL_VALUE_TO_ALLOC_FIELD = 10;	-- 필드를 할당할 서버를 고를 때 특정 서버에게 주는 가산점
-- 공유필드 할당 : Prime Channel 이 있는 서버에 가산점
-- 동적필드 할당 : 요청자가 있는 서버에 가산점

TIME_UPDATE_CHANNEL_BEHOLDER_SEC = 1.0;			-- 채널 비홀더의 업데이트 주기 (초)
TICK_EXPIRE_SILENT_CHANNEL = 300000;			-- ChannelBeholder 에서 사용하지 않는 채널을 제거하기까지 대기 시간 (ms)
RATIO_CHANNEL_CROWD_FOR_NEW_CHANNEL = 80;		-- 모든 채널이 몇% 이상 포화상태이면 새로운 채널을 만들지에 대한 비율

INCLUDE_DEV_FIELD_LIST 	= false;			-- 개발중인 필드 로딩 여부

INSERT_WORLD_INFO = false;					-- 서버 시작시마다 월드추가

TEST_ENABLE_TUTORIAL=false;
FIRST_ENTER_FIELD_ID=109;
FIRST_TUTORIAL_FIELD_ID=109;
MAX_CHANNEL_SIZE = 200;						-- 필드당 최대 채널



--======================================================
-- 디버그용 상수
--======================================================
SHOW_LUA_ERROR_LOG = true;
TEST_ALLOC_FIELD_ANOTHER_SERVER_ALWAYS = false;

DEBUG_CONSOLE_SHOW_GAMETICK = true;		-- 콘솔에 게임틱을 출력할 것인가
DEBUG_CONSOLE_GAMETICK_TICK = 60;		-- 몇초에 한번씩 출력할 것인가

MSMON_ENABLE = false; -- MasterServer Monitor 기능을 활성화 할 것인가