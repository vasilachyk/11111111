-- 리츠 여관의 모험가 인센

function NPC_1410:OnSpawn(SpawnInfo)
	this:SetTimer(1, 62, true)
end

function NPC_1410:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1410_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1410_2")
		end
	end
end



