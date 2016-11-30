-- 주술에 걸린 말벌
function NPC_110033:OnTryHit(Actor, TalentID)
	if (140009 == TalentID) then
		this:GainBuff(110002) -- 이 몬스터에게만 효과가 있어야 하므로 여기서 버프. 탤런트에 넣으면 안됨
	end
end