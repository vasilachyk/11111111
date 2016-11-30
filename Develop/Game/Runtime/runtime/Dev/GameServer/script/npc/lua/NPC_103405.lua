function NPC_103405:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, false)
	local Pos = SpawnInfo.Pos
	local Dir = SpawnInfo.NPC:GetDir()
	local SummonTable = Math_GetPolygonPoints(Pos, Dir, 300, 3)
	local Pos1 = SummonTable["1"]
	local Pos2 = SummonTable["2"]
	local Pos3 = SummonTable["3"]	
	
	this:Summon(103116, Pos1)
	this:Summon(103116, Pos2)
	this:Summon(103116, Pos3)	
end

function NPC_103405:OnTimer(TimerID)
	if (TimerID == 1) then
		this:Despawn(false)
	end
end










