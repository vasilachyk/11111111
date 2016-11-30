function NPC_7102190:OnSpawn()
	this:UseTalentSelf(710200310);
end


function NPC_7102190:OnTalentEnd(TalentID)
	if (710200310 == TalentID) then
		this:DespawnNow();
	end
end






