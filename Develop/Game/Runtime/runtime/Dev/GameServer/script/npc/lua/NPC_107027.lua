-- 렌고트 부족 치료사

function NPC_107027:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.TalentID == 140028) then
		this:GainBuff(110106)
		this:GainBuff(110107)		
	end
end
