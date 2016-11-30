function NPC_5000051:OnSpawn(Spawn)
	this:SetDecayTime(60);
	this:GainBuff(5000051, 0, 0);
end

function NPC_5000051:OnTryHit(Actor, TalentID)
	if (150050 == TalentID) then
		this:Die(Actor);
	end
end
