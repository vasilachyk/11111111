-- 늪지 크립 보초

function NPC_103114:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140504) then	
		local Field = HitInfo.Victim:GetField()
		Field:Spawn(103104, HitInfo.Victim:GetPos())
		AsPlayer(HitInfo.Attacker):UpdateQuestVar(103031,4)
		HitInfo.Victim:Despawn(true)
	end
end
