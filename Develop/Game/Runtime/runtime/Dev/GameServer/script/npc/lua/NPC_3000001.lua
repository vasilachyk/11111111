function NPC_3000001:OnSpawn(SpawnInfo)
	this:SetTimer(1, 6, false)
end

function NPC_3000001:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000002);
	end
end










