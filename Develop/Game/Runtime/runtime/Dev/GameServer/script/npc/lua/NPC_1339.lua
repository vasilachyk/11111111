-- ¸®Ã÷ ¿¬±Ý¼ú»ç ¼Òºñ³ó

function NPC_1339:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1339:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1339_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1339_2")
		end
	end
end



