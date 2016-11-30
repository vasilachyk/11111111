-- 오염된 물의 정령
function NPC_116117:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(88550) -- 검(임시)
	SpawnInfo.NPC:GainBuff(88554) -- 방패(임시)
end

function NPC_116117:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140555) then	
		local Field = HitInfo.Victim:GetField()
		HitInfo.Attacker:GainBuff(110068)
		HitInfo.Victim:Die(HitInfo.Victim)
	end
end
