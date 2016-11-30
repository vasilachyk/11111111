-- 리츠 연설하는 사제 제시

function NPC_1311:OnSpawn(SpawnInfo)
	this:SetTimer(1, 50, true)
end

function NPC_1311:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$NPC_1311_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1311_2")
		end
		if( dice == 2) then
			this:Balloon("$$NPC_1311_3")
		end
	end
end



