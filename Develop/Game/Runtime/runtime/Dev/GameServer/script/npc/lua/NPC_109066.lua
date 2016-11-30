-- 크라울러 근처의 선원

function NPC_109066:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_109066:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_109066_12")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_109066_15")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_109066_18")
		end
	end
end



