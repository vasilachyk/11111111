-- 렌고트 부족 공병

function NPC_107028:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140028) then
		this:GainBuff(110106)
		this:GainBuff(110107)		
	end
end
