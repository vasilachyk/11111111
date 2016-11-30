
-- ////////////////////////// 모켄의 동굴 트라이얼 퀘스트 ///////////////////////////

function Field_1091031:OnSpawn(SpawnInfo) -- 처음에 공격 불가/선공 불가로 만들기
	if (SpawnInfo.SpawnID == 109021) then
		SpawnInfo.NPC:DisableInteraction()
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:GainBuff(110019)		
	end
	if (SpawnInfo.SpawnID == 109221) then
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:GainBuff(110019)		
	end
	if (SpawnInfo.SpawnID == 7) or (SpawnInfo.SpawnID == 8) then
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
	end	
	if (SpawnInfo.SpawnID == 11) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		local Silver = this:GetSpawnNPC(109021)	
		SpawnInfo.NPC:Attack(Silver)
	end	
	if (SpawnInfo.SpawnID == 12) then
		SpawnInfo.NPC:SetAlwaysRun(true)	
		local Silver = this:GetSpawnNPC(109021)	
		SpawnInfo.NPC:Attack(Silver)
	end		
end

function Field_1091031:OnSensorEnter_2(Actor) -- 시작 이벤트

	if (Actor:IsPlayer() == true) then
		this:DisableSensor(2)
		local Silver = this:GetSpawnNPC(109021)	
		local Session = this:MakeSession("SilverDash", {Silver})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1091031:OnSessionScene_SilverDash_Begin(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Viewpoint = this:GetSpawnNPC(1)
		
	Session:Blocking()	
		Silver:Wait(1)
		Silver:FaceTo(Session:FindBookmark("Player"))		
		Silver:Say("$$Field_1091031_33",5.4) -- 드디어 왔네. 기다리다 지쳐서 나 혼자 처리하려던 참이었다고. 자 이제 출발해볼까?(수정: 한상권)
		Silver:FaceTo(Viewpoint)		
		Silver:Say("$$Field_1091031_35",3.0) -- 자, 어서 이곳을 정리하고 밥 먹으러 가자고.
	Session:CombatAll()
		Silver:Patrol({2,3,4}, PT_ONCE)	
		--this:EnableSensor(3)
	Session:ChangeScene("End")
	--Session:EndSession()
end

function Field_1091031:OnSessionScene_SilverDash_End(Session)
	local Silver = this:GetSpawnNPC(109021)
		Silver:Patrol({5,6}, PT_ONCE)	
		this:DespawnByID(100, false) -- 실버가 지나간 다음 투명벽(1)이 해제		
		this:EnableSensor(3)
	Session:EndSession()
end

function Field_1091031:OnSensorEnter_3(Actor) 
	local Silver = this:GetSpawnNPC(109021)	
	
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(3)	
		local Session = this:MakeSession("DestroyEgg", {Silver})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1091031:OnSessionScene_DestroyEgg_Begin(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Cat = this:GetSpawnNPC(14)		

	Session:Blocking()	
		Silver:FaceTo(Cat)
		Silver:Say("$$Field_1091031_54",4.1) -- 그 동안 모켄이 무슨 꿍꿍이를 꾸미고 있는지 알 수 없었는데. (수정: 한상권)
		Silver:Say("$$Field_1091031_55",3.3) -- 이런 곳에 자신의 기함을 숨겨서 힘을 비축하고 있었군. (수정: 한상권)
	Session:CombatAll()		
		--Silver:ChangeAA(AA_FACTION)
		--Silver:Patrol({12}, PT_ONCE)
	--Session:ChangeScene("Destroy")
		Silver:ChangeAA(AA_FACTION)	
		Silver:Patrol({7,8,9,10}, PT_ONCE)
		this:DespawnByID(101, false) -- 실버가 지나간 다음 투명벽(2)이 해제		
		--this:EnableSensor(4)
	--Session:EndSession()
	Session:ChangeScene("Sensor")
end

function Field_1091031:OnSessionScene_DestroyEgg_Sensor(Session)
		this:EnableSensor(4)
	Session:EndSession()
end

--[[
function Field_1091031:OnSessionScene_DestroyEgg_Destroy(Session)
	local Silver = this:GetSpawnNPC(109021)

	Session:Blocking()
		Silver:ChangeAA(AA_NONE)	
		Silver:Patrol({4,5,6,7,8,9,10}, PT_ONCE)
		this:EnableSensor(4)
	Session:EndSession()
end
--]]
function Field_1091031:OnSensorEnter_4(Actor) 
	local Field = Actor:GetField()
	local Silver = Field:GetSpawnNPC(109021)
	local Morken = Field:GetSpawnNPC(109221)	
	
	if (Actor:IsPlayer() == true) then
		Field:DisableSensor(4)
		
		local Session = this:MakeSession("SilverMorken", {Silver, Morken})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1091031:OnSessionScene_SilverMorken_Begin(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Morken = this:GetSpawnNPC(109221)	

	Session:Blocking()
		Silver:FaceTo(Morken)		
		Morken:FaceTo(Silver)		
		Morken:Say("$$Field_1091031_97",4.3) -- 이곳에서 미끼가 되라고 하더니, 제일스가 말한 대로 날 잡기 위해 왔군. (수정: 한상권)  
		Morken:Say("$$Field_1091031_98",5.8) -- 하하하하! 네놈들이 여기에 와준 덕분에 티안이 있는 모튼기어는 무방비가 되었겠지? (수정: 한상권)
		Silver:Say("$$Field_1091031_102",2.5) -- 이 망나니 자식아! 무슨 꿍꿍이냐!! (수정: 한상권)
		Morken:Say("$$Field_1091031_104",2.1) -- 곧 죽을 놈이 궁금한 게 참 많군. (수정: 한상권)
		Morken:Say("$$Field_1091031_105",2.1) -- 더 이상 상대하기도 귀찮다. 죽여라!! (수정: 한상권)
	Session:ChangeScene("Combat")
end

function Field_1091031:OnSessionScene_SilverMorken_Combat(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Morken = this:GetSpawnNPC(109221)	
	local Pirate1 = this:GetSpawnNPC(7)
	local Pirate2 = this:GetSpawnNPC(8)
	
	Session:NonBlocking()
	Session:CombatAll()
		Silver:ChangeAA(AA_FACTION)
		Morken:ChangeAA(AA_ALWAYS)
		Pirate1:ChangeAA(AA_ALWAYS)
		Pirate2:ChangeAA(AA_ALWAYS)
		
		Morken:EnableCombat()
		Pirate1:EnableCombat()
		Pirate2:EnableCombat()
		
		Silver:SetAlwaysRun(false)	
		Pirate1:SetAlwaysRun(true)	
		Pirate2:SetAlwaysRun(true)	
		
		Morken:Patrol({10}, PT_ONCE)
		Pirate1:Attack(Silver)
		Pirate2:Attack(Silver)
	Session:AddChangeSceneRule("Run", Morken, "hp", {0, 40})
end

function Field_1091031:OnSessionScene_SilverMorken_Run(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Morken = this:GetSpawnNPC(109221)	
	
	--Session:RemoveNPC(Silver)
	Session:Blocking()	
	Session:CombatAll()	
		Morken:ChangeAA(AA_NONE)
		Morken:GainBuff(5000051)		
		Morken:UseTalentSelf(210901731)
		Morken:FaceTo(Silver)		
		Morken:NonDelaySay("$$Field_1091031_177",7.0) -- 칫! 뭐 좋아, 지금은 너희가 이겼지만, 최후에 웃는 자는 내가 될 것이다! 하하하하! (수정: 한상권)
	Session:ChangeScene("Escape")		
end

function Field_1091031:OnSessionScene_SilverMorken_Escape(Session)
	local Silver = this:GetSpawnNPC(109021)
	local Morken = this:GetSpawnNPC(109221)	
	
	Session:Blocking()
		Silver:MakePeace()
	Session:RemoveNPC(Silver)
		Morken:MoveToMarker(130)
		Morken:Narration("$$NPC_109221_37")	-- 모켄은 도망쳤습니다.	
		Morken:Despawn(false)	
		this:SpawnByID(11)
		this:SpawnByID(12)		
		this:SpawnByID(13)			
	Session:EndSession()		
end

function Field_1091031:OnSensorEnter_5(Actor) 
	local Field = Actor:GetField()
	local Silver = Field:GetSpawnNPC(109021)	
	
	if (Actor:IsPlayer() == true) then
		Field:DisableSensor(5)
		--GLog("173 Line")
		Silver:MakePeace()
		Silver:ChangeAA(AA_NONE)
		Silver:FaceTo(Actor)				
		Silver:Say("$$Field_1091031_165",4.5) -- 아, 짜증나! 모켄 녀석 도망쳐버렸잖아!! 다 잡았는데…… (수정: 한상권)
		Silver:Say("$$Field_1091031_166",2.8) -- 모튼 기어가 위험한 것 같아. 어서 돌아가자고. (수정: 한상권)
		Silver:ScriptSelf("Field_1091031_Interaction")		
	end
end

function Field_1091031_Interaction(Self)
	--GLog("183 Line")
	Self:EnableInteraction()
end

function Field_1091031:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	--[[
	if (DespawnInfo.SpawnID == 1) then
		local Pirate2 = Field:GetSpawnNPC(2)
		if (Pirate2:IsDead() == true) then
			Field:DespawnByID(100,false)		-- 해적 1,2가 죽으면 투명벽 해제
		end
	end	
	if (DespawnInfo.SpawnID == 2) then
		local Pirate1 = Field:GetSpawnNPC(1)
		if (Pirate1:IsDead() == true) then
			Field:DespawnByID(100,false)		-- 해적 1,2가 죽으면 투명벽 해제
		end
	end	
	--]]
	if (DespawnInfo.NPCID == 109221) or (DespawnInfo.NPCID == 109209) or (DespawnInfo.NPCID == 109210) then
		--GLog("221Despawn Call\n")
		if (Field:GetNPCCount(1) == 1) and (Field:GetNPCCount(109209) == 0) and (Field:GetNPCCount(109210) == 0) then
			--GLog("EnableSensor_5 On\n")
			Field:EnableSensor(5)
		end
	end
end

