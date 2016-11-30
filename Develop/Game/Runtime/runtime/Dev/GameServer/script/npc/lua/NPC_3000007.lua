function NPC_3000007:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3000007:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000001);
	end
end










