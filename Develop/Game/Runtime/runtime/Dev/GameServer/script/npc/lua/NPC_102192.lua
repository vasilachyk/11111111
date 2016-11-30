function NPC_102192:OnSpawn()
	this:UseTalentSelf(210200309);
end



function NPC_102192:OnTalentEnd(TalentID)
	if (210200309 == TalentID) then
		
		this:DespawnNow();
	end
end






