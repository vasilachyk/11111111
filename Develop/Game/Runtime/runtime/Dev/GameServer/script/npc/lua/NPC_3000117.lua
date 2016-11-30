function NPC_3000117:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000117:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000017);
	end
end










