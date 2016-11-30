function NPC_5000061:OnSpawn(Spawn)
	this:GainBuff(5000051, 0, 0);
end

function NPC_5000061:OnTryHit(Actor, TalentID)
	if (150060 == TalentID) then
		if (true == this:CheckBPart(1)) then
		this:Die(Actor);
		end
	end
end
