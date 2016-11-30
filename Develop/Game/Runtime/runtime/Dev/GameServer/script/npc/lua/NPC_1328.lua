-- ¸®Ã÷ °ÅÁö

function NPC_1328:OnSpawn(SpawnInfo)
	this:SetTimer(1, 20, true)
end

function NPC_1328:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1328_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1328_2")
		end
	end
end



