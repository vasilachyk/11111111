
-- ////////////////////////// 트라이얼 진입 관련 ///////////////////////////
-- // 호출 순서
-- OnSensorEnter_2 -> OnSensorEnter_1 -> Field_8894_OnArea1 -> Field_8894_OnArea2 -> Field_8894_OnArea3
--		-> OnDie (spawn_id: 1000) -> OnDie (spawn_id: 1010)

function Field_8894:GetSoldier()
--	GLog("Field_8894:GetSoldier()\n")
	local Army = {}
	local spawnid = {3, 4, 5, 6, 7, 8, 9, 10, 11}
	for i in ipairs(spawnid) do
		local Soldier = self:GetSpawnNPC(spawnid[i])
		Army[i] = Soldier
	end -- for
	
	return Army
end


function Field_8894:OnCreate()
	Field_8894.NPC_Cenes = 2
	Field_8894.NPC_Door = 1002
	Field_8894.NPC_TransparentWall = 1003
	Field_8894.NPC_Golem = 1000
	Field_8894.NPC_Borgo = 1001
	Field_8894.NPC_Sorena = 1010
	
	Field_8894.BUFF_LookAtMe = 100100
	
	Field_8894.TIMER_Area1 = 201
	Field_8894.TIMER_Area2 = 202
	Field_8894.TIMER_Area3 = 203
	Field_8894.TIMER_Area1_LIMIT = 240;
	Field_8894.TIMER_Area2_LIMIT = 60;
	Field_8894.TIMER_Area3_LIMIT = 120;
	Field_8894.TIMER_GolemHit1 = 30
	Field_8894.TIMER_GolemHit2 = 60
	Field_8894.TIMER_GolemHit3 = 70
	Field_8894.TIMER_Sorena1 = 1014
	Field_8894.TIMER_Sorena2 = 1016
	
	Field_8894.TALENT_OpenTheDoor 	= 889402001
	Field_8894.TALENT_Jump  		= 211001105
end

function Field_8894:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:SetAlwaysRun(true)
end

function Field_8894:OnTimer(timer_id)
	--GLog("OnTimer"..timer_id.."\n");
	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	local Session = this:FindSession("GSTAR")
	
	-- 클리어 시간 제한. 세네스를 강제 이동 시킨다.
	if timer_id == Field_8894.TIMER_Area1 then
		Session:ChangeScene("Area1")		
	elseif timer_id == Field_8894.TIMER_Area2 then
		Session:ChangeScene("Area1")
	elseif timer_id == Field_8894.TIMER_Area3 then
		Session:ChangeScene("AppearGolem")

	-- 고블린골렘 공략 힌트 알리미 ( 전투 시작 후 30, 60, 70초 후 )
	elseif timer_id == Field_8894.TIMER_GolemHit1 then
		Cenes:SayAndNarrationNow("$$Field_8894_84")
	elseif timer_id == Field_8894.TIMER_GolemHit2 then
		Cenes:SayAndNarrationNow("$$Field_8894_87")
	elseif timer_id ==Field_8894.TIMER_GolemHit3 then
		Cenes:SayAndNarrationNow("$$Field_8894_90")

	-- 소레나 등장시 세네스 이동 중 대사
	elseif timer_id == Field_8894.TIMER_Sorena1 then
		Cenes:SayAndNarrationNow("$$Field_8894_94")
	elseif timer_id == Field_8894.TIMER_Sorena2 then
		Cenes:SayAndNarrationNow("$$Field_8894_97")
	end
end

function Field_8894:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == Field_8894.NPC_Borgo) then
		local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
--		this:PlayBGM("bgm_gstar_borgodie")
		
	elseif (DespawnInfo.SpawnID == Field_8894.NPC_Sorena) then

	end
end



-- ///////////////////////////////////////////////////////////////////////////////

function Field_8894:OnSensorEnter_1(Actor) -- 시작 이벤트
	GLog("Field_8894:OnSensorEnter_1\n")
	
	this:DisableSensor(1)

	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	local Session = this:MakeSession("GSTAR", {Cenes})
	Cenes:Wait(2)
	Cenes:Say("$$Field_8894_112")
	Cenes:Say("$$Field_8894_113")
	Cenes:Say("$$Field_8894_114")
	Cenes:GainBuff(500010)
end

function Field_8894:OnSensorEnter_2(Actor) -- 전투 개시
	--GLog("Field_8894:OnSensorEnter_2\n")

	this:DisableSensor(2)
	local Session = this:FindSession("GSTAR")
	Session:ChangeScene("Ready")
end


function Field_8894:OnSessionScene_GSTAR_Ready(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_Begin\n")
	
	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	Session:AddBookmark("NPC_Cenes", Cenes)

	Cenes:GainBuff( Field_8894.BUFF_LookAtMe )
	--this:PlayBGM("bgm_gstar_start")
	Cenes:Say("$$Field_8894_134")		
	Cenes:SayAndNarration("$$Field_8894_135")
	
	Session:ChangeScene("Start")
end

function Field_8894:OnSessionScene_GSTAR_Start(Session)	
	--GLog("Field_8894:OnSessionScene_GSTAR_Start\n")
	
	Session:CombatAll()
	this:SetTimer(Field_8894.TIMER_Area1, Field_8894.TIMER_Area1_LIMIT, false)
	
	local Soldier = Field_8894.GetSoldier(this)
	Soldier[1]:Patrol({2,3,5}, PT_ONCE)
	Soldier[2]:Patrol({11,12,14}, PT_ONCE)
	Soldier[3]:Patrol({21,23}, PT_ONCE)
	Soldier[4]:Patrol({31,32,33,34}, PT_ONCE)	
	Soldier[5]:Patrol({2,12,13,14,41}, PT_ONCE)
	Soldier[6]:Patrol({11,22,42}, PT_ONCE)
	Soldier[7]:Patrol({21,32,44}, PT_ONCE)
	Soldier[8]:Patrol({31,12,45}, PT_ONCE)
	Soldier[9]:Patrol({11,23,35}, PT_ONCE)

	local Cenes = AsNPC( Session:FindBookmark("NPC_Cenes") )
	Cenes:Patrol({5}, PT_ONCE)	
		
	local Borgo = this:GetSpawnNPC( Field_8894.NPC_Borgo )
	Cenes:Attack( Borgo )
	
	Cenes:Patrol({6}, PT_ONCE)
--	Cenes:Say("Debug")
	Session:ChangeScene("Area1")
end

function Field_8894:OnSessionScene_GSTAR_Area1(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_Area1\n")

	this:KillTimer( Field_8894.TIMER_Area1 )
	this:SetTimer( Field_8894.TIMER_Area2, Field_8894.TIMER_Area2_LIMIT, false) 

	local Cenes = AsNPC( Session:FindBookmark("NPC_Cenes") )
	Cenes:Say("$$Field_8894_203")
	Cenes:GainBuff( Field_8894.BUFF_LookAtMe )

	local Soldier = Field_8894.GetSoldier(this)
	Soldier[1]:Patrol({5}, PT_ONCE)
	Soldier[2]:Patrol({35}, PT_ONCE)
	Soldier[3]:Wait(2)  
	Soldier[3]:Say("$$Field_8894_219")
	Soldier[4]:Wait(2)
	Soldier[4]:Say("$$Field_8894_219")
	Soldier[5]:Patrol({15}, PT_ONCE)
	Soldier[6]:Patrol({24}, PT_ONCE)
	Soldier[7]:Patrol({46}, PT_ONCE)
	Soldier[8]:Patrol({7}, PT_ONCE)
	Soldier[9]:Patrol({47}, PT_ONCE)
	
	Cenes:Patrol({7}, PT_ONCE)
	Session:ChangeScene("Area2")
end

function Field_8894:OnSessionScene_GSTAR_Area2(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_Area2\n")

	this:KillTimer( Field_8894.TIMER_Area2 )
	this:SetTimer( Field_8894.TIMER_Area3, Field_8894.TIMER_Area3_LIMIT, false) 

	-- 전투중인 경비병 생성
	this:SpawnByID(51)
	this:SpawnByID(53)
	 
	local Cenes = AsNPC( Session:FindBookmark("NPC_Cenes") )
	Cenes:SayAndNarration("$$Field_8894_243")
	Cenes:GainBuff( Field_8894.BUFF_LookAtMe )

	Session:CombatAll()
	
	local Soldier = Field_8894.GetSoldier(this)
	Soldier[1]:Patrol({50}, PT_ONCE)
	Soldier[2]:Patrol({50}, PT_ONCE)
	Soldier[3]:Patrol({50}, PT_ONCE)
	Soldier[4]:Patrol({50}, PT_ONCE)
	Soldier[5]:Patrol({16}, PT_ONCE)
	Soldier[6]:Patrol({25}, PT_ONCE)
	Soldier[7]:Patrol({50}, PT_ONCE)
	Soldier[8]:Patrol({49}, PT_ONCE)
	Soldier[9]:Patrol({48}, PT_ONCE)	
	
	Cenes:Patrol({8}, PT_ONCE)
	Session:ChangeScene("GolemAppear")
end


function Field_8894:OnSessionScene_GSTAR_GolemAppear(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_GolemAppear\n")

	this:KillTimer( Field_8894.TIMER_Area3 )	
	
	local Cenes = AsNPC( Session:FindBookmark("NPC_Cenes") )
	local Golem = this:SpawnByID( Field_8894.NPC_Golem )
	local Door = this:GetSpawnNPC( Field_8894.NPC_Door )
	this:PlayBGM("bgm_gstar_golemspawn")
	
	Session:AddNPC( Golem )
	Session:AddBookmark( "NPC_Golem", Golem )

	Cenes:Patrol({52}, PT_ONCE)
	Session:CombatSession()
	
	Golem:UseTalent( Field_8894.TALENT_OpenTheDoor, Door )
	Cenes:SayAndNarration("$$Field_8894_305")
	--Session:NonBlocking()
		Golem:UseTalent( Field_8894.TALENT_Jump, Cenes )
	--	Cenes:UseTalentSelf( 211030108 )
	--Session:Blocking()

	--Cenes:Attack(Golem)
	Session:AddChangeSceneRule("GolemDie", Golem, "dead", {})
	Session:ChangeScene("GolemCombat")
end

function Field_8894:OnSessionScene_GSTAR_GolemCombat(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_GolemCombat\n")
	TIMER_LOOP = true
	TIMER_ONCE = false

	this:SetTimer(Field_8894.TIMER_GolemHit1, Field_8894.TIMER_GolemHit1, TIMER_ONCE )
	this:SetTimer(Field_8894.TIMER_GolemHit2, Field_8894.TIMER_GolemHit2, TIMER_ONCE )
	this:SetTimer(Field_8894.TIMER_GolemHit3, Field_8894.TIMER_GolemHit3, TIMER_ONCE )

	Session:CombatAll()

	local Soldier = Field_8894.GetSoldier( this )
	Soldier[1]:Patrol({53}, PT_ONCE)
	Soldier[2]:Patrol({53}, PT_ONCE)
	Soldier[3]:Patrol({53}, PT_ONCE)
	Soldier[4]:Patrol({53}, PT_ONCE)
	Soldier[5]:Patrol({50}, PT_ONCE)
	Soldier[6]:Patrol({51}, PT_ONCE)
	Soldier[7]:Patrol({53}, PT_ONCE)
	Soldier[8]:Patrol({51}, PT_ONCE)	
	Soldier[9]:Patrol({53}, PT_ONCE)
	
	--Session:ChangeScene("GolemDie")
end

function Field_8894:OnSessionScene_GSTAR_GolemDie(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_GolemDie\n")

	this:KillTimer( Field_8894.TIMER_GolemHit1 )
	this:KillTimer( Field_8894.TIMER_GolemHit2 )
	this:KillTimer( Field_8894.TIMER_GolemHit3 )
	
	this:DespawnByID( Field_8894.NPC_TransparentWall ) 
	this:PlayBGM("bgm_gstar_golemdie")

	this:EnableSensor(3)
	
	local Cenes = AsNPC( Session:FindBookmark("NPC_Cenes") )
	Cenes:Patrol({52}, PT_ONCE)	
	Cenes:Wait(10)
	Cenes:SayAndNarration("$$Field_8894_364")
	Cenes:SayAndNarration("$$Field_8894_365")	

	Cenes:Patrol({9}, PT_ONCE)

--	Session:NonBlocking()
	Cenes:Patrol({43}, PT_ONCE) -- 전투하러 달려감.		
end

function Field_8894:OnSensorEnter_3(Actor) -- 소레나 출연
	--GLog("Field_8894:OnSensorEnter_3")
	this:DisableSensor(3)
	local Session = this:FindSession("GSTAR")
	Session:ChangeScene("SorenaAppear")
end

function Field_8894:OnSessionScene_GSTAR_SorenaAppear(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_AppearSorena\n")
	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	local Sorena = this:SpawnByID( Field_8894.NPC_Sorena )
	local marker_npc1 = this:GetSpawnNPC(1007)
	local marker_npc2 = this:GetSpawnNPC(1008)

	this:PlayBGM("bgm_gstar_sorenaspawn")
	--this:ChangeWeather(WEATHER_CLOUDY)
	this:ChangeWeather(WEATHER_HEAVY_RAINY)

	this:SetTimer( Field_8894.TIMER_Sorena1, 14, false)
	this:SetTimer( Field_8894.TIMER_Sorena2, 16, false)
	
	Session:RemoveNPC( Cenes )	
	Cenes:Patrol({4}, PT_ONCE)

	Session:AddNPC( Sorena )
	Sorena:Patrol({22}, PT_ONCE)
	
	Sorena:UseTalentSelf(210500224)
	Sorena:UseTalent(210500212, marker_npc1)
	Sorena:UseTalent(189402201, marker_npc2)
	
	Session:AddNPC( Cenes )
	
	Session:AddChangeSceneRule("SorenaDie", Sorena, "dead", {})
	Session:ChangeScene("SorenaCombat")
end

function Field_8894:OnSessionScene_GSTAR_SorenaCombat(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_SorenaCombat\n")
	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	local Sorena = this:GetSpawnNPC( Field_8894.NPC_Sorena )
	
	Session:CombatAll()

	Cenes:Attack(Sorena)
	Sorena:Attack(Cenes)
end

function Field_8894:OnSessionScene_GSTAR_SorenaDie(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_SorenaDie\n")
	local Cenes = this:GetSpawnNPC( Field_8894.NPC_Cenes )
	this:PlayBGM("bgm_gstar_sorenadie")
	this:ChangeWeather(WEATHER_SUNNY)
	Cenes:Wait(8)
	Cenes:Patrol({4}, PT_ONCE)
	Cenes:GainBuff( Field_8894.BUFF_LookAtMe )
	this:EnableSensor(6) -- 퀘스트 종료 센서
	Cenes:Narration("$$Field_8894_388")
end

function Field_8894:OnSessionScene_GSTAR_Finish(Session)
	--GLog("Field_8894:OnSessionScene_GSTAR_Finish\n")
end

function Field_8894:OnSensorEnter_6(Actor) -- 퀘스트 완료
	AsPlayer(Actor):UpdateQuestVar(889101, 3)	
end