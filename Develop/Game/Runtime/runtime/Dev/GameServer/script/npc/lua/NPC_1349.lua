-- 府明 家俺泼 歹后

function NPC_1349:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1349:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1349_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1349_2")
		end
	end
end



