-- ¸®Ã÷ »æ¶â´Â ±øÆÐ ´õ±×

function NPC_1329:OnSpawn(SpawnInfo)
	this:SetTimer(1, 45, true)
end

function NPC_1329:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1329_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1329_1")
		end
	end
end



