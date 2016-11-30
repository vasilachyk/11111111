-- 하프메인 (아레크의 둥지)

function NPC_116210:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116210) then		
		SpawnInfo.NPC:GainBuff(110076)		
	end		
end

