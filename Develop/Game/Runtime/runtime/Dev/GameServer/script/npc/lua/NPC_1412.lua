-- 리츠 여관의 모험가 던피

function NPC_1412:OnSpawn(SpawnInfo)
	this:SetTimer(1, 160, true)
end

function NPC_1412:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1412_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1412_2")
		end
	end
end



