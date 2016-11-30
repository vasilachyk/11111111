
-- ////////////////////////// 부러진 돛대 트라이얼 퀘스트 ///////////////////////////
function Field_1090021:OnSensorEnter_1(Actor) -- 시작 이벤트
	local Field = Actor:GetField()
	if Actor:IsPlayer() == true then
		Field:DisableSensor(1)
		local Leon = Field:GetSpawnNPC(109002)
		local Sailor = Field:GetSpawnNPC(10)
		local Viewpoint = Field:GetSpawnNPC(100)
		Sailor:SetAlwaysRun(true)
		Sailor:WaitFor(Leon)
		
		Leon:Wait(1)
		Leon:FaceTo(Actor)		
		Leon:Say("$$Field_1090021_15") -- 말소리가 들려옵니다.
		Leon:FaceTo(Viewpoint)		
		Leon:Say("$$Field_1090021_17")
		Leon:NextAction()
		Leon:WaitFor(Sailor)
		
		Sailor:MoveToMarker(2)
		Sailor:MoveToMarker(4)		
		Sailor:FaceTo(Leon)
		Sailor:Say("$$Field_1090021_24")
		Sailor:NextAction()
		
		Leon:FaceTo(Sailor)
		Leon:Say("$$Field_1090021_28")
		Leon:FaceTo(Actor)		
		Leon:Say("$$Field_1090021_30")
		Leon:ScriptSelf("SummonOfficer")
	end
end

function SummonOfficer(Self)
	local Field = Self:GetField()
	Field:SpawnByID(109003)
end

function Field_1090021:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 109003) then
		local Officer = SpawnInfo.NPC
		local Field = SpawnInfo.NPC:GetField()
		local Leon = Field:GetSpawnNPC(109002)
		Leon:WaitFor(Officer)
		Officer:SetAlwaysRun(true)
		Officer:MoveToMarker(3)
		Officer:FaceTo(Leon)		
		Officer:Say("$$Field_1090021_49")
		Officer:NextAction()
		Officer:WaitFor(Leon)
		
		Leon:FaceTo(Officer)
		Leon:Say("$$Field_1090021_54")
		Leon:FaceTo(Officer)		
		Leon:Say("$$Field_1090021_56")
		Leon:NextAction()
		Leon:WaitFor(Officer)

		Officer:Say("$$Field_1090021_60")
		Officer:MoveToMarker(5)
		Officer:FaceTo(Leon)		
		Officer:NextAction()

		Leon:SetAlwaysRun(true)		
		Leon:Narration("$$Field_1090021_66")
		Leon:MoveToMarker(6)		
		Leon:ScriptSelf("FirstCombatSensor")		
	end
	if (SpawnInfo.SpawnID == 16) then
		SpawnInfo.NPC:Patrol({8}, PT_ONCE)	
	end
	if (SpawnInfo.SpawnID == 19) then
		SpawnInfo.NPC:Patrol({8}, PT_ONCE)		
	end	
end

function FirstCombatSensor(Self)
	local Field = Self:GetField()
	Field:EnableSensor(2)
end

function Field_1090021:OnSensorEnter_2(Actor) -- 첫번째 전투 센서
	local Field = Actor:GetField()
	local Leon = Field:GetSpawnNPC(109002)	
	
	if Actor:IsPlayer() == true then		
		Field:DisableSensor(2)
		Leon:NonDelaySay("$$Field_1090021_89")
		Leon:Patrol({7}, PT_ONCE)
		Field:SpawnByID(14)
		Field:SpawnByID(15)
		Field:SpawnByID(16)
		Field:SpawnByID(17)
		Field:SpawnByID(18)
		Field:SpawnByID(19)
		Field:SpawnByID(20)		
	end
end

function Field_1090021:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	local Leon = Field:GetSpawnNPC(109002)	
	
	if (DespawnInfo.NPCID == 109201) or (DespawnInfo.NPCID == 109202) then
		if (Field:GetNPCCount(109201) == 0) and (Field:GetNPCCount(109202) == 0) then
			Leon:Say("$$Field_1090021_107")
			Leon:ScriptSelf("FirstEventSensor")
		end
	end
	if (DespawnInfo.NPCID == 109207) or (DespawnInfo.NPCID == 109208) then -- 포병 모두 처치, 대포 무력화
		if (Field:GetNPCCount(109207) == 0 ) and (Field:GetNPCCount(109208) == 0 )then
			Leon:ClearJob()
			
			Leon:NonDelaySay("$$Field_1090021_115")
			Leon:ScriptSelf("CompleteSensor")			
		end
	end		
end

function FirstEventSensor(Self)
	local Field = Self:GetField()
	Field:EnableSensor(5)
end

function Field_1090021:OnSensorEnter_5(Actor) -- 두번째 전투 센서
	local Field = Actor:GetField()
	local Leon = Field:GetSpawnNPC(109002)	
	local Sailor1 = Field:GetSpawnNPC(14)	
	local Sailor2 = Field:GetSpawnNPC(15)	

	if Actor:IsPlayer() == true then		
		Field:DisableSensor(5)
		AsPlayer(Actor):UpdateQuestVar(109002, 2)
		Sailor1:SetAlwaysRun(true)
		Sailor2:SetAlwaysRun(true)		
		Sailor1:NonDelaySay("$$Field_1090021_137")
		Sailor2:NonDelaySay("$$Field_1090021_138")		
		Sailor1:MoveToMarker(21)
		Sailor2:MoveToMarker(22)	
		Sailor1:Despawn()
		Sailor2:Despawn()
		Leon:FaceTo(Actor)
		Leon:Say("$$Field_1090021_144")
		Leon:ScriptSelf("SecondEventSensor")
		Leon:MoveToMarker(15)
		Leon:MoveToMarker(16)			
	end
end

function SecondEventSensor(Self)
	local Field = Self:GetField()
	Field:EnableSensor(3)
	Field:SpawnByID(21)
	Field:SpawnByID(22)
	Field:SpawnByID(23)
	Field:SpawnByID(24)	
end

function Field_1090021:OnSensorEnter_3(Actor) -- 두번째 이벤트 센서
	local Field = Actor:GetField()
	local Runner1 = Field:GetSpawnNPC(21)	
	local Runner2 = Field:GetSpawnNPC(22)
	local Runner3 = Field:GetSpawnNPC(23)
	local Runner4 = Field:GetSpawnNPC(24)
	local Leon = Field:GetSpawnNPC(109002)	
	
	if Actor:IsPlayer() == true then	
		AsPlayer(Actor):Cutscene(1090021)
		Field:DisableSensor(3)
		Runner1:SetAlwaysRun(true)	
		Runner2:SetAlwaysRun(true)	
		Runner3:SetAlwaysRun(true)	
		Runner4:SetAlwaysRun(true)			
		Runner1:NonDelaySay("$$Field_1090021_175")
		Runner1:DisableCombat()
		Runner2:DisableCombat()
		Runner3:DisableCombat()
		Runner4:DisableCombat()		
		Runner1:Wait(6)	
		Runner2:Wait(6)
		Runner3:Wait(6)
		Runner4:Wait(6)		
		Runner1:Patrol({9,10}, PT_ONCE)
		Runner1:NonDelaySay("$$Field_1090021_185")		
		Runner1:Patrol({11,12,13,14}, PT_ONCE)			
		Runner2:Patrol({9,10,11,12,13,14}, PT_ONCE)
		Runner3:Patrol({9,10,11,12,13,14}, PT_ONCE)
		Runner4:Patrol({9,10,11,12,13,14}, PT_ONCE)	
		Runner1:Despawn()
		Runner2:Despawn()
		Runner3:Despawn()
		Runner4:Despawn()
		Leon:Wait(9)
		Leon:Say("$$Field_1090021_195")
		Leon:Patrol({17,18}, PT_ONCE)
		Leon:ScriptSelf("SecondCombatSensor")		
	end
end

function SecondCombatSensor(Self)
	local Field = Self:GetField()
	Field:EnableSensor(4)
end

function Field_1090021:OnSensorEnter_4(Actor) -- 두번째 전투 센서
	local Field = Actor:GetField()
	local Leon = Field:GetSpawnNPC(109002)	
	
	if Actor:IsPlayer() == true then
		Field:DisableSensor(4)
		
		Leon:Say("$$Field_1090021_213")
		Leon:NonDelaySay("$$Field_1090021_214")		
		Leon:Narration("$$Field_1090021_215")
		Leon:Patrol({19,13,20}, PT_ONCE)			

		local SpawnTable = {25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48}
		local i = 1
		
		repeat 
			Field:SpawnByID(SpawnTable[i])
			i = i + 1
		until i >= table.getn(SpawnTable)+1
	end
end

function CompleteSensor(Self) -- 포병 무력화
	local Field = Self:GetField()
	Field:EnableSensor(6) -- 타이머 센서
end

function Field_1090021:OnSensorEnter_6(Actor) -- 두번째 전투 센서
	local Field = Actor:GetField()
	
	if Actor:IsPlayer() == true then
		Field:DisableSensor(6)	
		Actor:Narration("$$Field_1090021_238")
		AsPlayer(Actor):UpdateQuestVar(109002, 3)			
		this:SetTimer(1, 11, false)		-- 타이머로 귀환 센서 작동
	end
end

function Field_1090021:OnTimer(TimerID) 
	if (TimerID == 1) then
		this:EnableSensor(7) -- 귀환 센서 ON
	end
end
