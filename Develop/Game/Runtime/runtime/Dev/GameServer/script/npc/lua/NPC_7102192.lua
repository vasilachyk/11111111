function NPC_7102192:OnSpawn()
	this:UseTalentSelf(710200310);
end



function NPC_7102192:OnTalentEnd(TalentID)
	if (710200310 == TalentID) then
		this:DespawnNow();
	end
end






