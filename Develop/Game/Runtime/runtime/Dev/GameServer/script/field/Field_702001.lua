function Field_702001:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 702104) then -- 고위사제 콰트라 이동
		
		SpawnInfo.NPC:Patrol({12,13,14,15,16,17,18,19,20,21}, PT_LOOP_BACKORDER)
		
	elseif (SpawnInfo.NPCID == 702112) then -- 상위기사 탐핀 이동
		
		SpawnInfo.NPC:Patrol({24,25,26,27,28,29,30,31,32,33,34,35,36}, PT_LOOP_BACKORDER)
			
	end
end

function Field_702001:OnDie(DespawnInfo) 
	local Field = this:GetID()

	if (DespawnInfo.SpawnID == 23) then -- 바스테로 사망
		DespawnInfo.NPC:NarrationNow("$$Field_512001_42")		
	end
	if (DespawnInfo.SpawnID == 24) then -- 리비우트 사망
		DespawnInfo.NPC:NarrationNow("$$Field_512001_45")		
	end
end






