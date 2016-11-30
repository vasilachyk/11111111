-- ¸®Ã÷ °¡Á×»óÁ¡ Ä«³ë

function NPC_1345:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1345:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1345_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1345_2")
		end
	end
end



