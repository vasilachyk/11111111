-- 府明 盲家惑牢 单繁

function NPC_1215:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_1215:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$Field_1_16")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_17")
		end
	end
end



