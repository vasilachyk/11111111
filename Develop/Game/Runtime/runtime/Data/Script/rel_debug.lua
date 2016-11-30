--
-- 이 스크립트는 디버그용 스크립트입니다.
-- 이 파일을 debug.lua로 복사해서 각자 사용하세요. - birdkr
--

-- 변수 세팅
CONST_DEBUG_EXECUTE_UNITTEST	= false;
CONST_SEX_MALE					= false;		-- 기본 플레이어 성별

-- 로그 필터 등록
-- gamedebug:AddLogFilter("birdkr");
-- gamedebug:AddLogFilter("luna1x");

-- 게임 시작할 때 자동으로 불리는 함수
function Debug_OnGameStarted()

-- 디버깅에 필요한 콘솔 명령어를 미리 입력해 놓으면 편합니다.
--	gamedebug:ConsoleCmd("ai");
--	gamedebug:ConsoleCmd("god");


-- 더미 테스트 샘플
-- shDebug:SetDummyData("localhost", "BirdTest")	-- 서버 IP, ID
-- shDebug:AddDummyAgent("Login", 100);				-- 더미 이름, 개수
-- shDebug:AddDummyAgentHandler("Login", "LoginFlood");

end