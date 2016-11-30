-- µÀ´ë ¸¶¸®¿Ë ¼±¿ø

function NPC_109057:OnSpawn(SpawnInfo)
	this:SetTimer(1, 150, true)
end

function NPC_109057:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_109057_12")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_109057_15")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_109057_18")
		end
	end
end



