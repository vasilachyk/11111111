-- ¿À¿°µÈ ¼­¸® Á¤·É
function NPC_116118:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(88552) -- µµ³¢ 
end

function NPC_116118:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140555) then	
		local Field = HitInfo.Victim:GetField()
		HitInfo.Attacker:GainBuff(110068)
		HitInfo.Victim:Die(HitInfo.Victim)
	end
end
