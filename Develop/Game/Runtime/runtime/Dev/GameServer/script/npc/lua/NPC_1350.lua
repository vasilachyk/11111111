-- 리츠 소개팅 소이비나

function NPC_1350:OnSpawn(SpawnInfo)
	this:SetTimer(1, 65, true)
end

function NPC_1350:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1350_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1350_2")
		end
	end
end



