
-- ////////////////////////// 모튼 기어 구원 트라이얼 퀘스트 ///////////////////////////

function Field_1091041:OnSensorEnter_1(Actor) -- 첫번째 이벤트
	local Field = Actor:GetField()
	local Roco = Field:GetSpawnNPC(109025)	
	Field:PlayBGM("bgm_Scenewar_2") 
	if (Actor:IsPlayer() == true) then
		Roco:DisableInteraction()
		Actor:Narration("$$Field_1091041_10") -- 모튼 기어가 공격받고 있습니다!
		Roco:Say("$$Field_1091041_11") -- 으아아악! 놈들이 닥치는 대로 사람들을 공격하고 있어! (수정: 한상권)
		Roco:Say("$$Field_1091041_12") -- 어떻게든 비전투원들은 안전한 곳으로 대피시켰다네...... (수정: 한상권)		
		Roco:Say("$$Field_1091041_13") -- 하지만 티안 두목이 위험해. 어서 빨리 두목을 도와주게. (수정: 한상권)
		Roco:ScriptSelf("Field_1091041_RocoOut")	
	end
end

function Field_1091041_RocoOut(Self)
	Self:Despawn(false)
end

function Field_1091041:OnSensorEnter_4(Actor) -- 첫번째 웨이브
	local Field = Actor:GetField()
	if (Actor:IsPlayer() == true) then
		Field:DisableSensor(4)
		Field:SpawnByID(10101)
		Field:SpawnByID(10102)
		Field:SpawnByID(10103)
		Field:SpawnByID(10104)	
		Field:EnableSensor(6)		
	end
end

function Field_1091041:OnSessionScene_MorkenFight_Begin(Session)
	Session:ChangeScene("Talk1")
end

function Field_1091041:OnSessionScene_MorkenFight_Talk1(Session)
		local Tian = this:GetSpawnNPC(109020)	
		local Morken = this:GetSpawnNPC(109221)
		
		Morken:Say("$$Field_1091041_42",3.7) -- 아버지의 배를 고작 여관으로나 사용하더니......꼴 좋구나, 동생아.
		Morken:Say("$$Field_1091041_43",3.4) -- 해적의 긍지를 잃었을 때부터 네 패배는 정해졌던 거야! 
		--Morken:Say("$$Field_1091041_44",4.0) 
		Tian:Say("$$Field_1091041_45",4.3) -- 긍지라고? 아버지의 뜻도 제대로 알지 못하는 오라버니가 할 말은 아니지!
		Tian:Say("$$Field_1091041_46",3.8) -- 정체도 알 수 없는 자와 손을 잡다니. 정말 한심스러워.
		Morken:Say("$$Field_1091041_47",1.6) -- 끝까지 날 무시하는구나!
		Morken:Say("$$Field_1091041_48",2.5) -- 칫! 시간 낭비만 했군, 이제 그만 죽어라!	
		Session:ChangeScene("Combat")
end

function Field_1091041:OnSessionScene_MorkenFight_Combat(Session)
	local Tian = this:GetSpawnNPC(109020)	
	local Morken = this:GetSpawnNPC(109221)
	local Pirate1 = this:GetSpawnNPC(1100)
	local Pirate2 = this:GetSpawnNPC(1101)
	local Pirate3 = this:GetSpawnNPC(1102)
	local Pirate4 = this:GetSpawnNPC(1103)
	Session:CombatAll()
	this:PlayBGM("bgm_Scenewar_2") 
	Tian:ChangeAA(AA_FACTION)
	Pirate1:ChangeAA(AA_FACTION)		
	Pirate2:ChangeAA(AA_FACTION)
	Pirate3:ChangeAA(AA_FACTION)
	Pirate4:ChangeAA(AA_FACTION)
	Morken:ChangeAA(AA_FACTION)	
	Pirate1:EnableCombat()		
	Pirate2:EnableCombat()	
	Pirate3:EnableCombat()	
	Pirate4:EnableCombat()	
	Morken:EnableCombat()	
	Session:AddChangeSceneRule("MorkenAttack", Morken, "hp", {0, 40}) -- 모켄이 40% 이하가 되면 사자후 사용
end

function Field_1091041:OnSessionScene_MorkenFight_MorkenAttack(Session) 
	local Tian = this:GetSpawnNPC(109020)	
	local Morken = this:GetSpawnNPC(109221)
	Session:CombatSession()
	Morken:NonDelaySay("$$Field_1091041_79",0.8) -- 방해하지 마라!			
	Morken:UseTalentSelf(210901732)
	Session:ChangeScene("Talk2")
end

function Field_1091041:OnSessionScene_MorkenFight_Talk2(Session) -- 사자후 사용 후 
	local Tian = this:GetSpawnNPC(109020)	
	local Morken = this:GetSpawnNPC(109221)
		local Pirate1 = this:GetSpawnNPC(1100)
		local Pirate2 = this:GetSpawnNPC(1101)
		local Pirate3 = this:GetSpawnNPC(1102)
		local Pirate4 = this:GetSpawnNPC(1103)
		Pirate1:Despawn(false)	
		Pirate2:Despawn(false)	
		Pirate3:Despawn(false)	
		Pirate4:Despawn(false)		
	Morken:FaceTo(Tian)
	Tian:FaceTo(Morken)				
	Morken:Say("$$Field_1091041_89",1.9) -- 곧 있으면 크라울러가 풀려난다.
	Morken:Say("$$Field_1091041_90",2.9) -- 그러면 모튼 기어도 내 손안에 들어올 것이다!
	Session:ChangeScene("TianAttack")
end

function Field_1091041:OnSessionScene_MorkenFight_TianAttack(Session) -- 티안 반격
	local Tian = this:GetSpawnNPC(109020)	
	local Morken = this:GetSpawnNPC(109221)
	Session:CombatSession()
	Tian:NonDelaySay("$$Field_1091041_98",0.8) -- 꿈 깨시지!
	Tian:StayawayFrom(Morken, 400)
	Tian:UseTalent(210901813, Morken)
	Session:ChangeScene("Talk3")
end

function Field_1091041:OnSessionScene_MorkenFight_Talk3(Session)
	local Morken = this:GetSpawnNPC(109221)
	Morken:Say("$$Field_1091041_106",1.9) -- 젠장! 어디서 저런 힘이...
	Morken:Say("$$Field_1091041_107",1.5) -- 제일스는 대체 뭘하고 있는 거야!
	Session:ChangeScene("MorkenDespawn")
end

function Field_1091041:OnSessionScene_MorkenFight_MorkenDespawn(Session)
	local Morken = this:GetSpawnNPC(109221)
	Morken:GainBuff(110089)
	Morken:Narration("$$Field_1091041_113") -- 모켄은 전장에서 사라졌습니다.
	Morken:Despawn(false)
	Session:ChangeScene("TianMove")
end

function Field_1091041:OnSessionScene_MorkenFight_TianMove(Session)
	local Tian = this:GetSpawnNPC(109020)	
	this:SpawnByID(109310)		
	this:SpawnByID(2006)
	this:SpawnByID(2007)
	this:SpawnByID(2008)	
	Tian:Wait(1.0)
	Tian:FaceTo(Session:FindBookmark("Player"))
	Tian:Say("$$Field_1091041_122",3.1) -- 도와줘서 고마워. 하지만 아직 끝나지 않았어.
	Tian:Say("$$Field_1091041_123",4.1) -- 자! 크라울러를 쓰러트리려면 당신의 힘이 필요해. 어서 가자.
	Tian:Patrol({2401,2402,2403,2}, PT_ONCE)
	Session:ChangeScene("SpawnJails")
end

function Field_1091041:OnSessionScene_MorkenFight_SpawnJails(Session)	
	this:EnableSensor(8) -- 첫번째 Obj 완료
	this:EnableSensor(10)
	Session:EndSession()	
end

function Field_1091041:OnSensorEnter_6(Actor) -- 두번째 웨이브(세션 시작)
	if (Actor:IsPlayer() == true) then
	 	this:DisableSensor(6)
		this:PlayBGM("bgm_Scenetalk_2") 	
		local Tian = this:GetSpawnNPC(109020)	
		local Morken = this:GetSpawnNPC(109221)
		local Session = this:MakeSession("MorkenFight", {Tian, Morken})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1091041:OnSensorEnter_10(Actor) -- 제일스 세션 시작
	local Field = Actor:GetField()
	local Tian = Field:GetSpawnNPC(109020)
	local Jails = Field:GetSpawnNPC(109310)
	Field:PlayBGM("bgm_Scenetalk_3") 

	if (Actor:IsPlayer() == true) then
		Field:DisableSensor(10)
		local Session = this:MakeSession("JailsFight", {Tian, Jails})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1091041:OnSessionScene_JailsFight_Begin(Session)
	local Tian = this:GetSpawnNPC(109020)
	local Jails = this:GetSpawnNPC(109310)

	Session:Blocking()	
		Tian:FaceTo(Jails)
		Tian:Say("$$Field_1091041_165",3.3) -- 뭐지, 이 녀석들은..? 어딘가 홀린 듯 한데.
		Tian:Say("$$Field_1091041_166",2.2) -- 네녀석이 이들을 조종하고 있나?
		Jails:Say("$$Field_1091041_167",4.8) -- 그래. 특별히 내가 준비해놓은 무대지. 바로 널 죽이기 위한 무대.
		Jails:Say("$$Field_1091041_168",3.3) -- 네가 부하들과 떨어져 홀로 나오는 것을 기다리고 있었다.
		Jails:Say("$$Field_1091041_169",6.0) -- 네년을 죽여야만, 내 목적이 성사되지. 너의 죽음과 함께 인젠을 파멸로 몰고 가……
		Jails:Say("$$Field_1091041_170",7.4) -- 우리의 계획의 첫 단추가 꿰매지는 것이다! 하하하! 선물로 너에게 가장 고통스러운 죽음을 선사해주마.		
	Session:ChangeScene("Control")
end

function Field_1091041:OnSessionScene_JailsFight_Control(Session)
	local Tian = this:GetSpawnNPC(109020)
	local Jails = this:GetSpawnNPC(109310)

	Session:Blocking()		
		Tian:NonDelaySay("$$Field_1091041_201") -- 크윽		
		Jails:NonDelaySay("$$Field_1091041_202",1.9) -- 다른 놈은 너희들이 처치해라!
		this:PlayBGM("bgm_Scenewar_2")	
	Session:ChangeScene("Combat")
end

function Field_1091041:OnSessionScene_JailsFight_Combat(Session)
	local Tian = this:GetSpawnNPC(109020)
	local Jails = this:GetSpawnNPC(109310)
	local Servant1 = this:GetSpawnNPC(2006)
	local Servant2 = this:GetSpawnNPC(2007)
	local Servant3 = this:GetSpawnNPC(2008)

		Tian:GainBuff(110018)	
		Jails:GainBuff(110020)
		Servant1:EnableCombat()
		Servant2:EnableCombat()
		Servant3:EnableCombat()
		Servant1:ChangeAA(AA_ALWAYS)
		Servant2:ChangeAA(AA_ALWAYS)
		Servant3:ChangeAA(AA_ALWAYS)
	Session:EndSession()	
end

function Field_1091041:OnSpawn(SpawnInfo) 
	if (SpawnInfo.SpawnID == 109020) then -- 티안
		SpawnInfo.NPC:DisableInteraction()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:GainBuff(110017)
		SpawnInfo.NPC:GainBuff(110019)		
	end
	if (SpawnInfo.SpawnID == 109100) then -- 크라울러
		SpawnInfo.NPC:GainBuff(110015)
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:EnableEternalAuthority()
	end
	if (SpawnInfo.SpawnID == 1005)then  -- 아군 선원
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Roam(500, 5)		
		SpawnInfo.NPC:Patrol({1203,1202,1201}, PT_ONCE_RETURN)		
	end	
	if (SpawnInfo.SpawnID == 1008)then  -- 아군 선원
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Roam(500, 5)
		SpawnInfo.NPC:Patrol({1103,1102,1101}, PT_ONCE_RETURN)		
	end		
	if (SpawnInfo.SpawnID == 10101) then -- 첫번째 웨이브 5명
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({1101,1102,1103,10101}, PT_ONCE)
	end
	if (SpawnInfo.SpawnID == 10102) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({1101,1102,1103,10102}, PT_ONCE)
	end
	if (SpawnInfo.SpawnID == 10103) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({1201,1202,1203,10103}, PT_ONCE)
	end
	if (SpawnInfo.SpawnID == 10104) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({1201,1202,1203,10105}, PT_ONCE)
	end
	if (SpawnInfo.SpawnID == 1100) then   -- 티안과 전투
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2201,2301,2203}, PT_ONCE)
		--SpawnInfo.NPC:Roam(500, 0)
	end
	if (SpawnInfo.SpawnID == 1101)then  -- 티안과 전투
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2301,2302,2303}, PT_ONCE)
		--SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 1102) then  -- 티안과 전투
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2401,2402,2503}, PT_ONCE)
		--SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 1103)then  -- 티안과 전투
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2501,2502,2503}, PT_ONCE)
		--SpawnInfo.NPC:Roam(500, 0)		
	end		
	if (SpawnInfo.SpawnID == 1104)then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2101,2302,2403}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 1105)then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		--SpawnInfo.NPC:Patrol({2201,2202,2203}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end
	if (SpawnInfo.SpawnID == 1106) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2201,2102,2203}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end
	if (SpawnInfo.SpawnID == 1107) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2101,2302,2503}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end		
	if (SpawnInfo.SpawnID == 1108) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2601,2502,2403}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 1109) then 
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2601,2602,2603}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 1110)  then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2401,2302,2403}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end
	if (SpawnInfo.SpawnID == 1111) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2401,2302,2303}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end		
	if (SpawnInfo.SpawnID == 1112) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2501,2502,2503}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end		
	if (SpawnInfo.SpawnID == 1113)  then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:Patrol({2601,2602,2603}, PT_ONCE)
		SpawnInfo.NPC:Roam(500, 0)		
	end	
	if (SpawnInfo.SpawnID == 109221)  then -- 모켄
		--local Field = SpawnInfo.Field
		--local Tian = Field:GetSpawnNPC(109020)	
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()		
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:GainBuff(110019)		
	end	
	if (SpawnInfo.SpawnID == 20003)  then  -- 세번째 트리거
		SpawnInfo.NPC:ScriptSelf("Field_1091041_SensorEight")
	end		
end

function Field_1091041_SensorEight(Self)
	local Field = Self:GetField()	
	Field:EnableSensor(8)
end

function Field_1091041:OnSensorEnter_2(Actor) -- 두번째 전투 센서
	local Field = Actor:GetField()
	
	if Actor:IsPlayer() == true then
		Field:DisableSensor(2)	
		Actor:Narration("$$Field_1091041_449") -- 퀘스트를 완료했습니다. 40초 후 모튼 기어로 자동 귀환합니다.	
		this:SetTimer(1, 41, false)		-- 타이머로 귀환 센서 작동
	end
end

function Field_1091041:OnTimer(TimerID) 
	if (TimerID == 1) then
		this:EnableSensor(3) -- 귀환 센서 ON
	end
end

function Field_1091041:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	local Tian = Field:GetSpawnNPC(109020)	
	
	if (DespawnInfo.SpawnID == 109100) then
		DespawnInfo.Field:EnableSensor(2) -- 크라울러 죽으면 전투 종료
		DespawnInfo.Field:EnableSensor(13) -- obj 3 크라울러 처치 완료 센서
		Tian:EnableInteraction()
		--Tian:Say("$$Field_1091041_467",2.2) # [Session이 끝난 다음에 세션 외에 잡이 제대로 수행이 되지 않는 것 같다.] (확인 필요)
		local Session = this:MakeSession("QuestEnd", {Tian})
	end

	if (DespawnInfo.NPCID == 109311) or (DespawnInfo.NPCID == 109312) or (DespawnInfo.NPCID == 109319) then
		if (Field:GetNPCCount(109311) == 0) and (Field:GetNPCCount(109312) == 0) and (Field:GetNPCCount(109319) == 0) then
			local Jails = Field:GetSpawnNPC(109310)	
			local Tian = Field:GetSpawnNPC(109020)						
			local Session = Field:MakeSession("TianControl",{Jails, Tian})
		end
	end
end

function Field_1091041:OnSessionScene_QuestEnd_Begin(Session)
	local Tian = this:GetSpawnNPC(109020)		
	
	Session:Blocking()	
		Tian:Say("$$Field_1091041_467",3.8)	-- 이것으로 우리의 승리군. 당신의 힘이 컸어. 수고했어.
		Tian:MoveToMarker(100)
		Tian:SaveHomePoint()
	Session:EndSession()	
end

function Field_1091041:OnSessionScene_TianControl_Begin(Session)
	local Jails = this:GetSpawnNPC(109310)	
	local Tian = this:GetSpawnNPC(109020)		
	
	Session:Blocking()	
		Jails:SayAndNarrationNow("$$Field_1091041_487",1.9) -- 이런 쓸모없는 녀석들!
		Jails:NarrationNow("$$Field_1091041_488") -- 제일스를 공격할 수 있게 되었습니다.
		Session:CombatAll()	
		Jails:EnableCombat()	
	Session:AddChangeSceneRule("Damage", Jails, "hp", {0, 99})
end

function Field_1091041:OnSessionScene_TianControl_Damage(Session)
	local Jails = this:GetSpawnNPC(109310)	
	local Tian = this:GetSpawnNPC(109020)		
	
	Session:CombatNone()	
	Session:Blocking()
		Jails:DisableCombat()
		Jails:RemoveBuff(110020)
		Jails:SetAlwaysRun(true)
		Jails:MoveToMarker(5)
		Jails:SaveHomePoint()
		Jails:FaceTo(Session:FindBookmark("Player"))
		Jails:NonDelaySay("$$NPC_109310_18",2.1) -- 네놈, 방해를 하다니...			
		Tian:RemoveBuff(110018)
		Tian:Narration("$$NPC_109310_20") -- 티안이 제일스의 저주로부터 벗어났습니다.
		Tian:Say("$$NPC_109310_21",2.0) -- 하아... 덕분에 살았어.
		Tian:FaceTo(Session:FindBookmark("Player"))
		Tian:Say("$$NPC_109310_23",1.0) -- 도와줘서 고마워.
		Tian:Wait(2)
		Tian:MoveToMarker(4)	
	Session:ChangeScene("End")
end

function Field_1091041:OnSessionScene_TianControl_End(Session)
	
	this:EnableSensor(12)
	Session:EndSession()	
end

function Field_1091041:OnSensorEnter_12(Actor) -- 12번 센서 크라울러
	local Field = Actor:GetField()
	local Jails = Field:GetSpawnNPC(109310)
	local Mage0 = Field:GetSpawnNPC(3000)
	local Mage1 = Field:GetSpawnNPC(3001)
	local Mage2 = Field:GetSpawnNPC(3002)
	local Mage3 = Field:GetSpawnNPC(3003)
	local Mage4 = Field:GetSpawnNPC(3004)	
	local Tian = Field:GetSpawnNPC(109020)	
	
	if (Actor:IsPlayer() == true) then
		Field:DisableSensor(12)		
		local Session = Field:MakeSession("Crawler",{Jails, Tian})
		Session:Blocking()
			Jails:Say("$$Field_1091041_248",4.9) -- 흥! 어차피 네놈들은 크라울러의 먹이가 된다는 것에는 변함이 없다.
			Jails:Say("$$Field_1091041_252",6.8) -- 고대 쿠오테스 왕국조차 죽일 수 없어 봉인한 크라울러의 공포를 느끼며 죽어가라. 하하하.
			Jails:SetAlwaysRun(true)
			Jails:MoveToMarker(6)
			Jails:Say("$$Field_1091041_249",2.0) -- 크라울러의 결계를 해제해라!			

		Session:ChangeScene("Combat")
	end
end

function Field_1091041:OnSessionScene_Crawler_Combat(Session)
	local Jails = this:GetSpawnNPC(109310)
	local Mage0 = this:GetSpawnNPC(3000)
	local Mage1 = this:GetSpawnNPC(3001)
	local Mage2 = this:GetSpawnNPC(3002)
	local Mage3 = this:GetSpawnNPC(3003)
	local Mage4 = this:GetSpawnNPC(3004)
	local Tian = this:GetSpawnNPC(109020)		
	local Crawler = this:GetSpawnNPC(109100)
	this:PlayBGM("bgm_war_10")
	
	Session:CombatAll()
		Jails:GainBuff(110089)
		Mage0:GainBuff(110089)		
		Mage1:GainBuff(110089)
		Mage2:GainBuff(110089)
		Mage3:GainBuff(110089)
		Mage4:GainBuff(110089)
		Jails:Despawn(false)
		Mage0:Despawn(false)		
		Mage1:Despawn(false)
		Mage2:Despawn(false)
		Mage3:Despawn(false)
		Mage4:Despawn(false)		
		Crawler:RemoveBuff(110015)
		Crawler:EnableCombat()
		Crawler:ChangeAA(AA_ALWAYS)
		Crawler:Patrol({5}, PT_ONCE)
		Crawler:Narration("$$Field_1091041_282") -- 크라울러를 처치하십시오.
		Tian:Attack(Crawler)
	Session:EndSession()
end
