function NPC_3000111:OnSpawn(SpawnInfo)
	this:SetTimer(1, 6, false)
end

function NPC_3000111:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000018);
	end
end










