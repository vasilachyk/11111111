function NPC_3000015:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000015:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000013);
	end
end










