-- 리츠 장보는 아줌마 호세안

function NPC_1402:OnSpawn(SpawnInfo)
	this:SetTimer(1, 70, true)
end

function NPC_1402:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1402_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1402_2")
		end
	end
end



