function NPC_3000000:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000000:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000000);
	end
end










