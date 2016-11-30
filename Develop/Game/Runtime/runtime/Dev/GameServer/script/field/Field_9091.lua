function Field_9091:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 5200006) then
		
		SpawnInfo.NPC:Patrol({4,5}, PT_LOOP)
	end
end