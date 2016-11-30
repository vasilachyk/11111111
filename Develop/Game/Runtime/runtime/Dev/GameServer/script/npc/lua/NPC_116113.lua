-- 오염된 불의 정령

function NPC_116113:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(88540) -- 검(임시)
	SpawnInfo.NPC:GainBuff(88544) -- 방패(임시)
end
