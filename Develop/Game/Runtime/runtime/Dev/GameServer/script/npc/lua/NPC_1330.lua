-- ¸®Ã÷ »æ¶â´Â ±øÆÐ °¥·ë

function NPC_1330:OnSpawn(SpawnInfo)
	this:SetTimer(1, 40, true)
end

function NPC_1330:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1330_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1330_1")
		end
	end
end



