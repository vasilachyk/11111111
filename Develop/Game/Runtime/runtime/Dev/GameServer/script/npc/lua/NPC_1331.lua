-- ¸®Ã÷ »æ¶â´Â ±øÆÐ ÇÁ·Ï

function NPC_1331:OnSpawn(SpawnInfo)
	this:SetTimer(1, 50, true)
end

function NPC_1331:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1331_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1331_1")
		end
	end
end



