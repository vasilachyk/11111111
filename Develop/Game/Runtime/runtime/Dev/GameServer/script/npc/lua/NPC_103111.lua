-- 늪지 크립 전사

function NPC_103111:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140504) then	
		local Field = HitInfo.Victim:GetField()
		Field:Spawn(103101, HitInfo.Victim:GetPos())
		AsPlayer(HitInfo.Attacker):UpdateQuestVar(103031,1)
		HitInfo.Victim:Despawn(true)
	end
end
