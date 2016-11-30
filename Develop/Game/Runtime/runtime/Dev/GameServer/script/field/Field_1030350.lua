-- ¾Ç¸ùÀÇ ±¼ 1Ãþ

function Field_1030350:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 20) or (SpawnInfo.SpawnID == 21) or (SpawnInfo.SpawnID == 21) then 
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:Patrol({11,12,13,14,15,16,17}, PT_ONCE)
		SpawnInfo.NPC:Roam(500,0)
	end	
	if (SpawnInfo.SpawnID == 23) then 
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:Patrol({21,22,23,24,25,26}, PT_ONCE)
		SpawnInfo.NPC:Roam(500,0)
	end			
end
