-- 아란바스 화산지대 : 트라이얼 (정도를 넘어서다.)

function Field_1160341:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116306) then		
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:ChangeAA(AA_NONE)
	end		
	if (SpawnInfo.NPCID == 116356) then		
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:ChangeAA(AA_NONE)		
	end	
	if (SpawnInfo.NPCID == 116512) then		
		--SpawnInfo.NPC:GainBuff(110070)		
	end		
end

function Field_1160341:OnSensorEnter_10(Actor) -- 이벤트 시작: 화산 분화
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(10)	
		
		local Halfmain = this:GetSpawnNPC(116512)			
		local Session = this:MakeSession("Event", {Halfmain})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160341:OnSessionScene_Event_Begin(Session)
		local Halfmain = this:GetSpawnNPC(116512)
	
	Session:Blocking()
		Halfmain:Say("{sound=scene16_halfmain_1}알케이노가 잠든 불균형의 천칭. 하지만 그 비밀을 풀지 못한 이상 들어갈 수 없단 말인가?", 7.2)
		Halfmain:Say("{sound=scene16_halfmain_2}들어갈 수 없다면! 아란바스 화산을 다시 분화시켜 다시는 이 세상에 나올 수 없도록 매장해주마!", 6.6)
		Halfmain:Say("{sound=scene16_halfmain_3}알케이노 네 녀석이 숨어 있는 불균형의 천칭과 함께!", 4.6)
		Halfmain:Say("{sound=scene16_halfmain_4}잘도 내가 아레크를 죽이는 것을 방해했겠다!", 3.6)		
		Halfmain:UseTalentSelf(211651201)		
	Session:ChangeScene("Act")	
end

function Field_1160341:OnSessionScene_Event_Act(Session)
	local Halfmain = this:GetSpawnNPC(116512)
	local Lava0 = this:GetSpawnNPC(200)
	local Lava1 = this:GetSpawnNPC(201)	
	local Lava2 = this:GetSpawnNPC(202)
	local Lava3 = this:GetSpawnNPC(203)	
	local Lava4 = this:GetSpawnNPC(204)
	local Lava5 = this:GetSpawnNPC(205)	
	local Lava6 = this:GetSpawnNPC(206)
	local Lava7 = this:GetSpawnNPC(207)	
	local Lava8 = this:GetSpawnNPC(208)
	local Lava9 = this:GetSpawnNPC(209)		
	local Lava10 = this:GetSpawnNPC(210)
	local Lava11 = this:GetSpawnNPC(211)		
	
	Session:Blocking()
	Session:FindBookmark("Player"):GainBuff(110081)
		--Halfmain:GainBuff(110081)
		Lava0:GainBuff(110009)
		Lava1:GainBuff(110009)
		Lava2:GainBuff(110009)
		Lava3:GainBuff(110009)
		Lava4:GainBuff(110009)
		Lava5:GainBuff(110009)
		Lava6:GainBuff(110009)
		Lava7:GainBuff(110009)
		Lava8:GainBuff(110009)
		Lava9:GainBuff(110009)
		Lava10:GainBuff(110009)		
		Lava11:GainBuff(110009)		
		
		this:SpawnByID(100)
		this:SpawnByID(101)
		this:SpawnByID(102)
		this:SpawnByID(103)		
		this:EnableSensor(11)
	Session:EndSession()	
end

function Field_1160341:OnSensorEnter_11(Actor) -- 이벤트 시작: 정령 학살
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(11)	
		
		local Halfmain = this:GetSpawnNPC(116512)			
		local FE1 = this:GetSpawnNPC(100)	
		local FE2 = this:GetSpawnNPC(101)	
		local FE3 = this:GetSpawnNPC(102)	
		local FE4 = this:GetSpawnNPC(103)
	
		local Session = this:MakeSession("Killing", {Halfmain, FE1, FE2, FE3, FE4})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160341:OnSessionScene_Killing_Begin(Session)
		local Halfmain = this:GetSpawnNPC(116512)
		local FE1 = this:GetSpawnNPC(100)	
		local FE2 = this:GetSpawnNPC(101)	
		local FE3 = this:GetSpawnNPC(102)	
		local FE4 = this:GetSpawnNPC(103)			
	
	Session:NonBlocking()	
		FE1:MoveToMarker(100)
		FE2:MoveToMarker(101)
		FE3:MoveToMarker(102)
		FE4:MoveToMarker(103)		
	Session:Blocking()
		FE2:Say("{sound=scene16_fire_1}하프메인, 멈추시오!",1.9)
		FE1:Say("{sound=scene16_fire_2}화산을 다시 분화시켜서는 안 돼!",2.1)
	Session:ChangeScene("WaterSpawn")
end

function Field_1160341:OnSessionScene_Killing_WaterSpawn(Session)		
		this:SpawnByID(150)
		this:SpawnByID(151)
		this:SpawnByID(152)
		this:SpawnByID(153)
		this:SpawnByID(154)	
	Session:ChangeScene("Talk")
end
		
function Field_1160341:OnSessionScene_Killing_Talk(Session)
		local Halfmain = this:GetSpawnNPC(116512)		
		local FE2 = this:GetSpawnNPC(101)			
		local WE1 = this:GetSpawnNPC(150)
		local WE2 = this:GetSpawnNPC(151)		
		local WE3 = this:GetSpawnNPC(152)
		local WE4 = this:GetSpawnNPC(153)
		local WE5 = this:GetSpawnNPC(154)		
		
	Session:AddNPC(WE1)
	Session:AddNPC(WE2)
	Session:AddNPC(WE3)
	Session:AddNPC(WE4)
	Session:AddNPC(WE5)
	Session:NonBlocking()	
		WE1:MoveToMarker(150)
		WE2:MoveToMarker(151)
		WE3:MoveToMarker(152)
		WE4:MoveToMarker(153)		
		WE5:MoveToMarker(154)
	Session:Blocking()
		WE3:Say("{sound=scene16_water_1}아란바스 화산이 한 번 더 분화했다간 대재앙이 일어날 거요.", 4.6)		
		WE1:Say("{sound=scene16_water_2}이곳은 물론이고 주변 지역들까지 모두 용암에 잠겨버리게 돼!", 4.6)
		Halfmain:Say("{sound=scene16_halfmain_5}닥쳐라!",0.7)
		Halfmain:Say("{sound=scene16_halfmain_6}이제 그 누구도 내 복수를 방해할 수 없어!", 3.0)
		Halfmain:Say("{sound=scene16_halfmain_7}내 앞길을 막는 놈들은...... 모조리 다 죽여버리겠다!", 4.4)
		Halfmain:ChangeAA(AA_FACTION)
	Session:CombatSession()
		Halfmain:UseTalent(211651202, FE2)
	Session:ChangeScene("FireDespawn")
end

function Field_1160341:OnSessionScene_Killing_FireDespawn(Session)
		local Halfmain = this:GetSpawnNPC(116512)
		local FE1 = this:GetSpawnNPC(100)	
		local FE2 = this:GetSpawnNPC(101)	
		local FE3 = this:GetSpawnNPC(102)	
		local FE4 = this:GetSpawnNPC(103)						
		local WE3 = this:GetSpawnNPC(152)
		
	Session:Blocking()		
	Session:CombatSession()	
		Halfmain:UseTalent(211651203, WE3)
	Session:ChangeScene("WaterDespawn")
end

function Field_1160341:OnSessionScene_Killing_WaterDespawn(Session)
		local Halfmain = this:GetSpawnNPC(116512)
		local WE1 = this:GetSpawnNPC(150)	
		local WE2 = this:GetSpawnNPC(151)
		local WE3 = this:GetSpawnNPC(152)
		local WE4 = this:GetSpawnNPC(153)
		local WE5 = this:GetSpawnNPC(154)				
		
	Session:Blocking()	
		Halfmain:Say("{sound=scene16_halfmain_8}렌델 대륙이 통째로 가라앉는 한이 있더라도 아레크와 용들을 없애버릴 것이다!", 5.6)	
		Halfmain:UseTalentSelf(211651204)
	Session:ChangeScene("SensorOn")		
end

function Field_1160341:OnSessionScene_Killing_SensorOn(Session)
		this:EnableSensor(116034)	
	Session:EndSession()
end

function Field_1160341:OnSensorEnter_116034(Actor) -- 이벤트 끝~
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(116034)	
		Actor:RemoveBuff(110081)
		AsPlayer(Actor):GateToMarker(116,116150)
	end
end