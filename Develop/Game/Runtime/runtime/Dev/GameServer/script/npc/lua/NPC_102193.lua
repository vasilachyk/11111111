function NPC_102193:OnSpawn()
	this:UseTalentSelf(210200310);
end



function NPC_102193:OnTalentEnd(TalentID)
	if (210200310 == TalentID) then
		
		this:DespawnNow();
	end
end






