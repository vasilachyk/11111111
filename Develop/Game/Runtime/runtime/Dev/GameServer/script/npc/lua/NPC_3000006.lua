function NPC_3000006:OnSpawn(SpawnInfo)
	this:SetTimer(1, 6, false)
end

function NPC_3000006:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000002);
	end
end










