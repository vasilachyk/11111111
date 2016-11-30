function NPC_3000105:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000105:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000010);
	end
end










