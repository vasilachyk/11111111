
-- ////////////////////////// 부러진 돛대 트라이얼 퀘스트 ///////////////////////////

function Field_1090111:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 109022) or (SpawnInfo.NPCID == 109023) then -- 습격자
		SpawnInfo.NPC:SetAlwaysRun(true)
	end
end

function Field_1090111:OnSensorEnter_5(Actor) -- 시작 이벤트
	local Field = Actor:GetField()
	if Actor:IsPlayer() == true then
		Field:DisableSensor(5)
		local First = Field:GetSpawnNPC(10)
		local Second = Field:GetSpawnNPC(11)
		local Soldier1 = Field:GetSpawnNPC(12)
		local Soldier2 = Field:GetSpawnNPC(13)
		local Soldier3 = Field:GetSpawnNPC(14)		

		Second:Narration("$$Field_1090111_20")
		Second:WaitFor(Soldier1)
		Soldier1:Say("$$Field_1090111_22")
		Soldier1:WaitFor(First)
		First:Wait(1)
		First:Say("$$Field_1090111_25")
		First:NextAction()
		First:WaitFor(Second)
		Soldier1:Say("$$Field_1090111_28")
		Soldier1:NextAction()
		Second:Say("$$Field_1090111_30")
		Second:NextAction()
		First:Say("$$Field_1090111_32")
		First:Say("$$Field_1090111_33")		
	end
end

function Field_1090111:OnSensorEnter_2(Actor) -- 시작 이벤트
	local Field = Actor:GetField()
	if Actor:IsPlayer() == true then
		Field:DisableSensor(2)
		local First = Field:GetSpawnNPC(10)
		local Second = Field:GetSpawnNPC(11)
		local Soldier1 = Field:GetSpawnNPC(12)
		local Soldier2 = Field:GetSpawnNPC(13)
		local Soldier3 = Field:GetSpawnNPC(14)	

		First:ClearJob()
		Second:ClearJob()
		Soldier1:ClearJob()
		Soldier2:ClearJob()
		Soldier3:ClearJob()
		
		First:WaitFor(Second)
		Soldier1:WaitFor(First)
		Second:FaceTo(Actor)
		Second:Say("$$Field_1090111_56")
		Second:NextAction()
		Second:WaitFor(Soldier1)
		First:FaceTo(Actor)		
		First:Say("$$Field_1090111_60")
		First:NextAction()
		Soldier1:Say("$$Field_1090111_62")
		Soldier1:NextAction()
		Soldier1:Attack(Actor)		
		Second:NonDelaySay("$$Field_1090111_65")
		Second:ScriptSelf("Run1")
	end
end

function Run1(Self)
	local Field = Self:GetField()
	local First = Field:GetSpawnNPC(10)
	local Second = Field:GetSpawnNPC(11)
	local Soldier1 = Field:GetSpawnNPC(12)
	local Soldier2 = Field:GetSpawnNPC(13)
	local Soldier3 = Field:GetSpawnNPC(14)	
	local Viewpoint = Field:GetSpawnNPC(10000)	

	First:ClearJob()
	Second:ClearJob()
	Soldier2:ClearJob()
	Soldier3:ClearJob()	
	
	Soldier1:EnableCombat()	
	First:Patrol({10,2,3,4}, PT_ONCE)	
	Second:Patrol({41,42,43,44}, PT_ONCE)
	Soldier2:Patrol({21,22,23,24}, PT_ONCE)	
	Soldier3:Patrol({31,32,33,34,35}, PT_ONCE)	
	First:FaceTo(Viewpoint)	
	Second:FaceTo(Viewpoint)
	Soldier2:FaceTo(Viewpoint)	
	Soldier3:FaceTo(Viewpoint)		
end		


function Field_1090111:OnSensorEnter_3(Actor) -- 시작 이벤트
	local Field = Actor:GetField()
	if Actor:IsPlayer() == true then
		Field:DisableSensor(3)
		local First = Field:GetSpawnNPC(10)
		local Second = Field:GetSpawnNPC(11)
		local Soldier2 = Field:GetSpawnNPC(13)
		local Soldier3 = Field:GetSpawnNPC(14)	
		local Viewpoint = Field:GetSpawnNPC(10001)
		
		First:WaitFor(Soldier2)		
		Second:WaitFor(Soldier2)
		Soldier2:FaceTo(Actor)
		Soldier2:Say("$$Field_1090111_109")
		Soldier2:Say("$$Field_1090111_110")
		Soldier2:NextAction()
		Second:FaceTo(Actor)
		Second:Say("$$Field_1090111_113")		
		First:Wait(1)
		First:Say("$$Field_1090111_115")
		First:NonDelaySay("$$Field_1090111_116")		
		
		First:Patrol({5,6,7,8,9}, PT_ONCE)	
		Second:Patrol({45,46,47,48,49}, PT_ONCE)
		Soldier2:Attack(Actor)	
		Soldier3:Attack(Actor)
		
		First:FaceTo(Viewpoint)	
		Second:FaceTo(Viewpoint)	
	end
end


