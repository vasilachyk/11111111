-- ¸®Ã÷ ¿¬±Ý¼ú»ç ºô¶ó

function NPC_1338:OnSpawn(SpawnInfo)
	this:SetTimer(1, 55, true)
end

function NPC_1338:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1338_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1338_2")
		end
	end
end



