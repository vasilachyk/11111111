-- ¿À¿°µÈ ¹°ÀÇ ¿µÈ¥
function NPC_116119:OnSpawn(SpawnInfo)
	--SpawnInfo.NPC:GainBuff(88553) -- ¿Ïµå 
end

function NPC_116119:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140555) then	
		local Field = HitInfo.Victim:GetField()
		HitInfo.Attacker:GainBuff(110068)
		HitInfo.Victim:Die(HitInfo.Victim)
	end
end