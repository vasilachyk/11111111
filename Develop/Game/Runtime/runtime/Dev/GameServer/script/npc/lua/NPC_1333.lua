-- 府明 没家何 歹胶奇

function NPC_1333:OnSpawn(SpawnInfo)
	this:SetTimer(1, 70, true)
end

function NPC_1333:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1333_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1333_1")
		end
	end
end



