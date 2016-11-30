-- 리츠 여관의 모험가 타크스

function NPC_1411:OnSpawn(SpawnInfo)
	this:SetTimer(1, 180, true)
end

function NPC_1411:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1411_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1411_2")
		end
	end
end



