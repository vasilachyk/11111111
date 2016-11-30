-- 잡혀있는 동료
function NPC_113228:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(110000)
	this:SetTimer(1, 30, true)		
end
function NPC_113228:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:BalloonNow("$$NPC_113228_11")
		end
		if( dice == 1) then 
			this:BalloonNow("$$NPC_113228_14")
		end
		if( dice == 2) then 
			this:BalloonNow("$$NPC_113228_17")
		end
	end
end