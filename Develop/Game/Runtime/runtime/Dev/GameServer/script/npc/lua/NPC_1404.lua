-- 리츠 장보는 아이 제미니

function NPC_1404:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1404:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1404_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1404_2")
		end
	end
end



