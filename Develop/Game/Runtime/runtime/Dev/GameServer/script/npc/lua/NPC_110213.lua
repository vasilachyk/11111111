-- 마법 지뢰
function NPC_110213:OnSpawn(Spawn)
	this:GainBuff(110003)  -- 은신 버프
end

function NPC_110213:OnTryHit(Actor, TalentID)
	if (140005 == TalentID) then
		
		this:Balloon("$$NPC_110213_9")
		this:RemoveBuff(110003) -- 은신 사라짐
		--this:EnableCombat()
	end
	if (140006 == TalentID) then
		this:Die(Actor)
	end	
end

