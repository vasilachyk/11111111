function NPC_102191:OnSpawn()
	this:UseTalentSelf(210200310);
end






function NPC_102191:OnTalentEnd(TalentID)
	if (210200310 == TalentID) then
		
		this:DespawnNow();
	end
end






