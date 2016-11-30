function NPC_3000116:OnSpawn(SpawnInfo)
	this:SetTimer(1, 6, false)
end

function NPC_3000116:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000018);
	end
end










