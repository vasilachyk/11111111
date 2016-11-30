-- 인젠 자유 경비대 여자

function NPC_3072:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_3072:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,6)
		if( dice == 0) then 
			this:Balloon("$$NPC_3072_12")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3072_15")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3072_18")
		end
		if( dice == 3) then 
			this:Balloon("$$NPC_3072_21")
		end		
	end
end


