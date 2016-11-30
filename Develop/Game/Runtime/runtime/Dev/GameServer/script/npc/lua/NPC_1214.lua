-- 리츠 정육점 아르바이트 로라

function NPC_1214:OnSpawn(SpawnInfo)
	this:SetTimer(1, 110, true)
end

function NPC_1214:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_13")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_14")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_40")
		end
	end
end



