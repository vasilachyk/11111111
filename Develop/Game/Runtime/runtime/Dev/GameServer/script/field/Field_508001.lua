-- 레나스 신전

function Field_508001:OnCreate()
	Field_508001.NPC_Veinus = 508020
	Field_508001.NPC_Coold = 508001
	Field_508001.NPC_Frorogy = 508002
	
	Field_508001.NPC_DoorVeinus = 107101
	Field_508001.NPC_DoorFrorogy = 105401
	Field_508001.NPC_DoorCoold = 103310
	
	Field_508001.NPC_Room6Wave = 106100
	
	Field_508001.ROOM_1 = 100
	Field_508001.ROOM_2 = 200
	Field_508001.ROOM_3 = 300
	Field_508001.ROOM_4 = 400
	Field_508001.ROOM_5 = 500
	Field_508001.ROOM_6 = 600
	Field_508001.ROOM_7 = 700
	
	Field_508001.Talent_OpenTheDoor = 250820401
	
end

function Field_508001:OnTimer( Index )

end

function Field_508001:OnDie(DespawnInfo)
	-- GLog("Field_508001:OnDie() "..DespawnInfo.SpawnID.."\n")
	
	if (DespawnInfo.SpawnID == Field_508001.NPC_Veinus ) then
		local Door = this:GetSpawnNPC( Field_508001.NPC_DoorVeinus )
		Door:Wait(5)
		Door:Narration("$$Field_501001_29")
		Door:UseTalentSelf( Field_508001.Talent_OpenTheDoor )
		
	elseif (DespawnInfo.SpawnID == Field_508001.NPC_Frorogy ) then
		local Door = this:GetSpawnNPC( Field_508001.NPC_DoorFrorogy )
		Door:Narration("$$COLT_0512208_24")		
		Door:Die(Door)
		
		this:EnableSensor(501)
	elseif (DespawnInfo.SpawnID == Field_508001.NPC_Coold ) then
		local Door = this:GetSpawnNPC( Field_508001.NPC_DoorCoold )
		Door:Wait(5)
		Door:Narration("$$Field_501001_29")				
		Door:UseTalentSelf( Field_508001.Talent_OpenTheDoor )
		
	end
end

-- 룸 활성화
function Field_508001:OnSensorEnter_101(Actor)
	--GLog("Room")
	this:ActivateSpawnGroup(Field_508001.ROOM_2)
	this:DisableSensor(101)
end
function Field_508001:OnSensorEnter_201(Actor)
	this:ActivateSpawnGroup(Field_508001.ROOM_3)
	this:DisableSensor(201)
end
function Field_508001:OnSensorEnter_202(Actor)
	this:ActivateSpawnGroup(Field_508001.ROOM_3)
	this:DisableSensor(202)
end
function Field_508001:OnSensorEnter_301(Actor)
	this:ActivateSpawnGroup(Field_508001.ROOM_4)
	this:DisableSensor(301)
end
function Field_508001:OnSensorEnter_401(Actor)
	this:ActivateSpawnGroup(Field_508001.ROOM_5)
	this:DisableSensor(401)
end
function Field_508001:OnSensorEnter_501(Actor)	

	this:ActivateSpawnGroup(Field_508001.ROOM_6)
	this:DisableSensor(501)
end
function Field_508001:OnSensorEnter_601(Actor)
	this:ActivateSpawnGroup(Field_508001.ROOM_7)
	this:DisableSensor(601)
end

-- 웨이브
function Field_508001:OnSensorEnter_502(Actor)
	GLog("Field_508001:OnSensorEnter_502()\n")
	this:ActivateSpawnGroup(Field_508001.ROOM_6) -- test
	
	for i=1, 6 do 
		local Enemy = this:GetSpawnNPC( Field_508001.NPC_Room6Wave + i )
		Enemy:Wait(i)
		Enemy:Attack(Actor)
		Enemy:MoveToMarker(11)
	end
	
	for i=1, 6 do 
		local Enemy = this:GetSpawnNPC( Field_508001.NPC_Room6Wave + 100 + i )
		Enemy:Wait(i)
		Enemy:Attack(Actor)
		Enemy:MoveToMarker(11)
	end
	
	this:DisableSensor(502)
end




