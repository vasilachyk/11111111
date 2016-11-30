function NPC_3010002:OnSpawn(SpawnInfo)
	this:SetTimer(1, 10, false)
end

function NPC_3010002:OnTimer(TimerID)
	if (TimerID == 1) then
		this:UseTalentSelf(3000019);
	end
end










