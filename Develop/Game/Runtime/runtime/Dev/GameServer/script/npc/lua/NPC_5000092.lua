function NPC_5000092:OnSpawn(Spawn)
	this:SetDecayTime(0);
	this:SetTimer(1, 2, false);
end

function NPC_5000092:OnTimer(TimerID)
	if (1 == TimerID) then
		this:Despawn(false);
	end
end