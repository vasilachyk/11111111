-- 조미료상인 스케버스

function NPC_3106:OnSpawn(SpawnInfo)
	this:SetTimer(1, 130, true)
end

function NPC_3106:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$Field_1_41")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_43")
		end
	end
end



