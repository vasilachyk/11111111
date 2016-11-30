-- 모스 (개 산책시키는 소녀)

function NPC_3015:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_3015:OnTimer(TimerID)
	local Field = this:GetField()
	local Mors = Field:GetNPC(3015)
	local Vita = Field:GetNPC(3016)
	local Distance = Mors:DistanceTo( Vita )

	if (TimerID == 1) then 
		this:ClearJob()
		if (Distance < 120) then
			this:Wait(1)	
		else
			local dice = math.random(0,2)
			if (dice == 0)then
				this:NonDelayBalloon("$$NPC_3015_20")
			end
			if (dice == 1)then
				this:NonDelayBalloon("$$NPC_3015_23")
			end
			if (dice == 2)then
				this:NonDelayBalloon("$$NPC_3015_26")
			end		
		end
	end
end



