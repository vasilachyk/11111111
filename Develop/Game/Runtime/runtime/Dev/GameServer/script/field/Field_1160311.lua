-- 아란바스 화산지대 : 트라이얼 (아레크와 하프메인)

function Field_1160311:OnSpawn(SpawnInfo) 
	if (SpawnInfo.NPCID == 116502) then		-- 아레크 스폰시 전투 불가 설정
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:SetAlwaysRun(true)	
	end		
	if (SpawnInfo.NPCID == 116511) then		-- 하프메인 스폰시 설정
		SpawnInfo.NPC:ChangeAA(AA_NONE)	
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:DisableInteraction()		
	end		
	if (SpawnInfo.NPCID == 116516) then		-- 고룡 알케이노의 위습
		SpawnInfo.NPC:ChangeAA(AA_NONE)	
		SpawnInfo.NPC:DisableCombat()		
	end			
end

function Field_1160311:OnSensorEnter_10(Actor)
	if (Actor:IsPlayer() == true) then
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
		local Session = this:MakeSession("Revenge", {Halfmain, Arek})
		Session:AddBookmark("Player", Actor)
	end
end  

function Field_1160311:OnSessionScene_Revenge_Begin(Session)
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
	
	Session:Blocking()
		Halfmain:NonDelaySay("{sound=scene15_halfmain_1}이번에야말로 복수를 완수하겠다.",2.6)	
		Halfmain:Patrol({11,12,13}, PT_ONCE)
		Halfmain:Say("{sound=scene15_halfmain_2}어디지? 놈은 어디 있는 거야?",2.1)		
		Arek:UseTalentSelf(211603016)
		Halfmain:FaceTo(Arek)
		Arek:UseTalentSelf(211603041)
		Arek:MoveToMarker(20)		
		Arek:UseTalentSelf(211603040)
		Arek:SaveHomePoint()
	Session:ChangeScene("Combat")		
end

function Field_1160311:OnSessionScene_Revenge_Combat(Session)
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
	
	Session:Blocking()
	Session:CombatAll()	
		Arek:EnableCombat()
		Arek:ChangeAA(AA_FACTION)
		Halfmain:ChangeAA(AA_FACTION)		
		Arek:Attack(Halfmain)	
	Session:AddChangeSceneRule("ArekBreath", Arek, "hp", {0, 30}) -- 아레크 체력이 30% 이하가 되면
end

function Field_1160311:OnSessionScene_Revenge_ArekBreath(Session) 
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
		local Another = this:GetSpawnNPC(116516)
		
	Session:NonBlocking()		
		this:EnableSensor(116031)
		this:SpawnByID(116516)
		Arek:MoveToMarker(30)
		Halfmain:MoveToMarker(31)
	Session:Blocking()	
	Session:CombatSession()	
		Arek:UseTalentSelf(211603056) -- 하프메인과 거리를 벌린다.
		Halfmain:FaceTo(Arek)	
		Arek:UseTalent(211603030, Halfmain)
		Halfmain:NonDelaySay("{sound=scene15_halfmain_3}네놈의 불꽃은 더 이상 나한테 통하지 않는다!",3.6)
		Halfmain:MoveToMarker(32)
		Halfmain:UseTalent(211651108, Arek)
	Session:ChangeScene("ArekDrain")
end

function Field_1160311:OnSessionScene_Revenge_ArekDrain(Session)
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
		local Another = this:GetSpawnNPC(116516)		
						
	Session:AddNPC(Another)						
		Halfmain:MoveToMarker(33)
		Halfmain:Say("{sound=scene15_halfmain_4}마침내 결말을 지을 때가 왔군...",2.7)
		Halfmain:Say("{sound=scene15_halfmain_5}마지막으로 네놈을 흡수해 내 가족의 원수를 갚겠다!",4.8)		
		Another:ChangeAA(AA_FACTION)			
		--Arek:UseTalentSelf(211603013)		
		--Arek:GainBuff(110018)	
	--Session:CombatAll()		
	Session:CombatSession()		
	Session:Blocking()		
		Halfmain:UseTalentSelf(211651109)	-- 흡수
		Another:UseTalent(211651601, Halfmain)		-- [Bug2] > Attack으로 했더니 Enter BehaviorCombatState 라고 하면서 전투가 종료됨
	--Session:AddChangeSceneRule("DrainFail", Halfmain, "e_motionfactor", {throwup, }) -- [Bug1] > 모션 팩터로는 씬이 안 바뀜
	--Session:AddChangeSceneRule("DrainFail", Halfmain, "hp", {0, 99})	
	--Session:AddChangeSceneRule("DrainFail", Halfmain, "damage", {lightning, 10})	
	Session:ChangeScene("DrainFail")	
end

function Field_1160311:OnSessionScene_Revenge_DrainFail(Session)
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
		local Another = this:GetSpawnNPC(116516)		
		
		Another:Despawn(false)
		Halfmain:NonDelaySay("{sound=scene15_halfmain_6}뭐야?!",0.5)
		Arek:UseTalentSelf(211603041)
		Arek:MoveToMarker(25)		
	Session:ChangeScene("Interaction")
end

function Field_1160311:OnSessionScene_Revenge_Interaction(Session)
		local Arek = this:GetSpawnNPC(116502)
		local Halfmain = this:GetSpawnNPC(116511)
		
		Arek:Despawn(false)
		Halfmain:Say("{sound=scene15_halfmain_7}조금만...... 조금만 더 있었으면 마침내 복수할 수 있었는데!",5.0)		
		Halfmain:Say("{sound=scene15_halfmain_8}대체 어느 놈이 날 방해한 것이냐!",2.7)
		Halfmain:Say("{sound=scene15_halfmain_9}...... 큭! 숨어 있다고 내가 못 찾을 줄 아느냐! 날 방해한 대가를 치르게 할 테다!",5.8)	
		Halfmain:EnableInteraction()
	Session:EndSession()
end
