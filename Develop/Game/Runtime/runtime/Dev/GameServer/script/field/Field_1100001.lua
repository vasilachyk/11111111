
-- ////////////////////////// 트라이얼 진입 관련 ///////////////////////////
function Field_1100001:OnSensorEnter_1(actor)
	-- 첫번째 플레이어 필드 진입.
	local field = actor:GetField()
	local cenes = field:GetSpawnNPC(2)
	field:PlayBGM("bgm_Scenetalk_2")

	field:DisableSensor(1)
	
	cenes:Wait(2)
	cenes:Say("$$Field_1100001_12", 1.2)	-- 다들 모인 거 같군.
	cenes:Say("$$Field_1100001_13", 2.1)	-- 작전을 설명할 테니 이리 가까이 오세요.
end

function Field_1100001:OnSensorEnter_2(actor)
	-- 전투 개시
	local field = actor:GetField()
	local cenes = field:GetSpawnNPC(2)
	local soldierTable = {3, 4, 5, 6, 7, 8, 9, 10, 11}

	field:DisableSensor(2)	
	cenes:SetAlwaysRun(true)
	
	-- 목책 안의 경비병 생성.
	field:SpawnByID(31)
	field:SpawnByID(32)
	field:SpawnByID(33)
	field:SpawnByID(34)
	field:SpawnByID(35)

	-- 전투병 이동 예약
	local soldier = {}
	
	for i=1, 9 do
		soldier[i] = field:GetSpawnNPC(soldierTable[i])
		
		soldier[i]:SetAlwaysRun(true)
		soldier[i]:WaitFor(cenes)
	end -- for 

	soldier[1]:Patrol({2,3,4,5}, PT_ONCE)
	soldier[2]:Patrol({11,12,13,14}, PT_ONCE)
	soldier[3]:Patrol({21,22,23}, PT_ONCE)
	soldier[4]:Patrol({31,32,33,34}, PT_ONCE)	
	soldier[5]:Patrol({2,12,13,14,41}, PT_ONCE)
	soldier[6]:Patrol({11,22,42}, PT_ONCE)
	soldier[7]:Patrol({21,32,43,44}, PT_ONCE)
	soldier[8]:Patrol({31,12,13,45}, PT_ONCE)
	soldier[9]:Patrol({11,22,23,35}, PT_ONCE)				
	
	-- 순차적인 연출
	
	cenes:Say("$$Field_1100001_54",6.1)		-- 우리 임무는 정문을 돌파해 놈들은 이 땅에서 몰아내는 것이다. 이미 2소대가 적들을 기습하여 교전 중에 있다.
	cenes:Say("$$Field_1100001_55",3.8)		-- 시간이 생명인 작전이니 각자 전진해서 속전속결로 해치운다.
	cenes:Say("$$Field_1100001_56",3.5)		-- 선봉은 내가 맡을 것이다. 용병들은 내 뒤를 곧장 따라오도록.
	cenes:SayAndNarration("$$Field_1100001_57",0.4)	-- 가자!
	cenes:ScriptSelf("Field_1100001_MusicOn")	
	cenes:NextAction()
	cenes:Patrol({2,3,4,5,6--[[,7,8,9--]]}, PT_ONCE)
	cenes:ScriptSelf("Field_1100001_OnArea_3")	-- 진격 센서 1 활성화		
end

function Field_1100001_OnArea_3(cenes)
	local field = cenes:GetField()
	local soldierTable = {3, 4, 5, 6, 7, 8, 9, 10, 11}	

	-- 전투병 이동 예약
	local soldier = {}
	
	for i=1, 9 do
		soldier[i] = field:GetSpawnNPC(soldierTable[i])
		
		soldier[i]:WaitFor(cenes)
	end -- for

	soldier[1]:Patrol({5}, PT_ONCE)
	soldier[2]:Patrol({35}, PT_ONCE)
	soldier[3]:Roam(500, 0)
	soldier[3]:Say("$$Field_1100001_80")
	soldier[4]:Roam(500, 0)
	soldier[5]:Patrol({15}, PT_ONCE)
	soldier[6]:Patrol({24}, PT_ONCE)
	soldier[7]:Patrol({46}, PT_ONCE)
	soldier[8]:Patrol({7}, PT_ONCE)
	soldier[9]:Patrol({47}, PT_ONCE)
	
	-- 순차적인 연출
	PuppetBegin(cenes)
	
	cenes:GainBuff(100100)
	cenes:SayAndNarration("$$Field_1100001_92",3.3)		-- 터커! 네빈! 자리를 지켜라. 나머진 계속 나아간다.
	cenes:NextAction()
	cenes:ScriptSelf("PuppetFinish")
	
	cenes:Patrol({7}, PT_ONCE)
	cenes:ScriptSelf("Field_1100001_OnArea_4")
end

function Field_1100001_OnArea_4(cenes)
	local field = cenes:GetField()
	local soldierTable = {3, 4, 5, 6, 7, 8, 9, 10, 11}

	-- 전투병 이동 예약
	local soldier = {}
	
	for i=1, 9 do
		soldier[i] = field:GetSpawnNPC(soldierTable[i])
		
		soldier[i]:WaitFor(cenes)
	end -- for
	
	soldier[1]:Roam(500, 0)
	soldier[2]:Roam(500, 0)
	soldier[7]:Roam(500, 0)
	soldier[5]:Patrol({16}, PT_ONCE)
	soldier[6]:Patrol({25}, PT_ONCE)
	soldier[8]:Patrol({49}, PT_ONCE)
	soldier[9]:Patrol({48}, PT_ONCE)	

	-- 순차적인 연출
	PuppetBegin(cenes)
	
	cenes:GainBuff(100100)
	cenes:SayAndNarration("$$Field_1100001_125",1.5)		-- 놈들을 살려두지 마라!
	cenes:NextAction()
	cenes:ScriptSelf("PuppetFinish")
	
	cenes:Patrol({8}, PT_ONCE)
	cenes:ScriptSelf("Field_1100001_OnArea_5")
end

function Field_1100001_OnArea_5(cenes)
	local field = cenes:GetField()
	local ogre = field:SpawnByID(1000)
	local soldierTable = {3, 4, 5, 6, 7, 8, 9, 10, 11}

	field:DisableSensor(7)

	-- 전투병 이동 예약
	local soldier = {}
	
	for i=1, 9 do 
		soldier[i] = field:GetSpawnNPC(soldierTable[i])
		
		soldier[i]:WaitFor(cenes)		
	end -- for

	soldier[1]:Roam(500, 0)
	soldier[2]:Patrol({46}, PT_ONCE)
	soldier[3]:Patrol({53}, PT_ONCE)
	soldier[4]:Roam(500, 0)
	soldier[5]:Patrol({54}, PT_ONCE)
	soldier[6]:Patrol({55}, PT_ONCE)
	soldier[7]:Roam(500, 0)	
	soldier[8]:Patrol({51}, PT_ONCE)
	soldier[9]:Patrol({48}, PT_ONCE)
	
	-- 순차적인 연출
	PuppetBegin(cenes)	
	
	cenes:Patrol({52}, PT_ONCE)
	cenes:GainBuff(100100)
	cenes:SayAndNarration("$$Field_1100001_164",1.8)		-- 오우거다! 진열을 정비하라!
	cenes:FaceTo(ogre)
	cenes:NextAction()
--	cenes:Patrol({50}, PT_ONCE)
	cenes:ScriptSelf("PuppetFinish")
	
	--cenes:WaitFor(ogre)

	ogre:SetAlwaysRun(true)
	
	PuppetBegin(ogre)
	ogre:Patrol({9,56}, PT_ONCE)
	--GLog_Job(ogre)
	
	--GLog_Job(ogre)
	ogre:ScriptSelf("PuppetFinish")
	ogre:Attack(cenes)
	ogre:EnableEternalAuthority()
	--GLog("Field_1100001_OnArea_5")
	--GLog_Job(ogre)
	
	--ogre:NextAction()
	

	cenes:Attack(ogre)		
end

function Field_1100001:OnDie(DespawnInfo) -- 오우거 사망시
	if not (DespawnInfo.SpawnID == 1000) then return end
	
	local field = DespawnInfo.Field
	local cenes = field:GetSpawnNPC(2)
	local soldierTable = {3, 4, 5, 6, 7, 8, 9, 10, 11}

	-- 전투병 이동 예약
	local soldier = {}
	
	for i=1, 9 do 
		soldier[i] = field:GetSpawnNPC(soldierTable[i])
		
		soldier[i]:WaitFor(cenes)		
	end -- for
	
	soldier[1]:Patrol({5}, PT_ONCE)
	soldier[2]:Patrol({14}, PT_ONCE)
	soldier[3]:Patrol({23}, PT_ONCE)	
	soldier[4]:Patrol({34}, PT_ONCE)	
	soldier[5]:Patrol({41}, PT_ONCE)
	soldier[6]:Patrol({44}, PT_ONCE)
	soldier[7]:Patrol({50}, PT_ONCE)	
	soldier[8]:Patrol({53}, PT_ONCE)
	soldier[9]:Patrol({48}, PT_ONCE)
	
	-- 순차적인 연출
	PuppetBegin(cenes)
	
	cenes:Wait(10)
	--cenes:GainBuff(100100)
	cenes:Say("$$Field_1100001_217",2.9)		-- 이 주변은 대충 정리된 거 같군...	
	--cenes:ScriptSelf("PuppetFinish")
	
	cenes:Patrol({9}, PT_ONCE)
	cenes:ScriptSelf("Field_1100001_OnArea_6")
end

function Field_1100001_OnArea_6(cenes)
	local field = cenes:GetField()
	field:EnableSensor(3)
	cenes:GainBuff(100100)
	cenes:Narration("$$Field_1100001_228")
end

function Field_1100001:OnSensorEnter_3(actor) -- 퀘스트 완료
	AsPlayer(actor):UpdateQuestVar(110000, 2)	
end

function Field_1100001_MusicOn(self) -- 전투 음악 시작
	local field = self:GetField()
	field:PlayBGM("bgm_war_9")
end
