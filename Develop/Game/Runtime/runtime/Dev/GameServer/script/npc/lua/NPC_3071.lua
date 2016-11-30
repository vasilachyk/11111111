-- 인젠 자유 경비대 남자

function NPC_3071:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_3071:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,6)
		if( dice == 0) then 
			this:Balloon("$$NPC_3071_12")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3071_15")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3071_18")
		end
		if( dice == 3) then 
			this:Balloon("$$NPC_3071_21")
		end	
	end
end



