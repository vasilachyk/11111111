-- 비타 (산책중인 개)

function NPC_3016:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_3016:OnTimer(TimerID)
	local Field = this:GetField()
	local Mors = Field:GetNPC(3015)
	local Vita = Field:GetNPC(3016)
	local Distance = Vita:DistanceTo( Mors )	
	
	if (TimerID == 1) then 
		this:ClearJob()
		if (Distance > 520) then
			this:Wait(1)
		else
			local dice = math.random(0,2)	
			if (dice == 0)then
				this:NonDelayBalloon("$$NPC_3016_20")
			end
			if (dice == 1)then
				this:NonDelayBalloon("$$NPC_3016_23")
			end
			if (dice == 2)then
				this:NonDelayBalloon("$$NPC_3016_26")
			end	
		end
	end
end
