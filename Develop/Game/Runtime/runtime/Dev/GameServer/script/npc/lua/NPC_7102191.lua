function NPC_7102191:OnSpawn()
	this:UseTalentSelf(710200311);
end






function NPC_7102191:OnTalentEnd(TalentID)
	if (710200311 == TalentID) then
		this:DespawnNow();
	end
end






