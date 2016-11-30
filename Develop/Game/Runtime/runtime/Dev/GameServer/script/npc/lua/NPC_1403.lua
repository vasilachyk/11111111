-- 리츠 장보는 아줌마 주키즈

function NPC_1403:OnSpawn(SpawnInfo)
	this:SetTimer(1, 75, true)
end

function NPC_1403:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1403_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1403_2")
		end
	end
end



