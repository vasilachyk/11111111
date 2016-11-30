-- 납치된 여행자
function NPC_113235:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:GainBuff(110005)
	this:SetTimer(1, 30, true)	
end
function NPC_113235:OnTimer(TimerID)
	--this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:BalloonNow("$$NPC_113235_11")
		end
		if( dice == 1) then 
			this:BalloonNow("$$NPC_113235_14")
		end
		if( dice == 2) then 
			this:BalloonNow("$$NPC_113235_17")
		end
	end
end