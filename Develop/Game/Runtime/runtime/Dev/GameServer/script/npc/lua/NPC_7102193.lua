function NPC_7102193:OnSpawn()
	this:UseTalentSelf(710200311);
end



function NPC_7102193:OnTalentEnd(TalentID)
	if (710200311 == TalentID) then
		this:DespawnNow();
	end
end






