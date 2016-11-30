function NPC_3000013:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000013:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000014);
	end
end










