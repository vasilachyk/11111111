function NPC_3000110:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000110:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000016);
	end
end










