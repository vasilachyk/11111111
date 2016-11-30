-- 돛대 술마시는 선원

function NPC_109455:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_109455:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$Field_1094551_11")
		end
		if( dice == 1) then 
			this:Balloon("$$Field_1094551_12")
		end
		if( dice == 2) then 
			this:Balloon("$$Field_1094551_13")
		end
	end
end



