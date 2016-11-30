-- 돛대 트롤 선원

function NPC_109059:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_109059:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,3)
		if( dice == 0) then 
			this:Balloon("$$NPC_109059_12")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_109059_15")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_109059_18")
		end
		if( dice == 3) then 
			this:Balloon("$$NPC_109059_21")
		end	
	end
end



