-- ´ËÁö Å©¸³ ¶¥±¼¹ú·¹

function NPC_103113:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140504) then
		local Field = HitInfo.Victim:GetField()
		Field:Spawn(103103, HitInfo.Victim:GetPos())
		AsPlayer(HitInfo.Attacker):UpdateQuestVar(103031,3)
		HitInfo.Victim:Despawn(true)
	end
end
