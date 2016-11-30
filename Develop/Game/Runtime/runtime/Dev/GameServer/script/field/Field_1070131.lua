-- 베스피오단 소굴.
function Field_1070131:OnSensorEnter_3(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		Field:DisableSensor(3)						
		local John = Field:GetSpawnNPC(2)
		local Mustang = Field:GetSpawnNPC(30)
		John:NonDelaySay("$$Field_1070131_8")
		John:Attack(Actor)
		Mustang:Attack(Actor)
	end
end

function Field_1070131:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	local John = Field:GetSpawnNPC(2)

	if (Field:GetNPCCount(107022) == 0) then
		John:ClearJob()	
		
		John:Say("$$Field_1070131_21")
		John:Say("$$Field_1070131_22")
	end
end

function Field_1070131:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 22) then 
		
		SpawnInfo.NPC:Patrol({220,221,222,223,224}, PT_LOOP_BACKORDER)
	elseif (SpawnInfo.SpawnID == 21) then
		
		SpawnInfo.NPC:Patrol({210,211,212,213,212,211,210,214,215,214}, PT_LOOP)
	elseif (SpawnInfo.SpawnID == 17) then
		
		SpawnInfo.NPC:Patrol({171,172,173,174,175,176,175,174,173,172,171}, PT_LOOP)
	elseif (SpawnInfo.SpawnID == 28) then
		
		SpawnInfo.NPC:Patrol({281,282,283,284,285,286,285,284,283,282,281}, PT_LOOP)
	elseif (SpawnInfo.SpawnID == 32) then
		
		SpawnInfo.NPC:Patrol({321,322,323,324,325,324,323,322,321}, PT_LOOP)		
	end	
end
