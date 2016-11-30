-- 늪지 크립 유충

function NPC_103112:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140504) then
		local Field = HitInfo.Victim:GetField()
		Field:Spawn(103102, HitInfo.Victim:GetPos())
		AsPlayer(HitInfo.Attacker):UpdateQuestVar(103031,2)
		HitInfo.Victim:Despawn(true)
	end
end
