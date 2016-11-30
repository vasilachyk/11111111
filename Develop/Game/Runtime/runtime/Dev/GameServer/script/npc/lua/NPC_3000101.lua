function NPC_3000101:OnSpawn(SpawnInfo)
	this:SetTimer(1, 6, false)
end

function NPC_3000101:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000012);
	end
end










