-- 고대의 상자

function NPC_102128:OnTryHit(Actor, TalentID)
	if (TalentID == 140014) then
		this:RemoveBuff(110028)
		this:DisableCombat()
		this:EnableInteraction()
	end
end
