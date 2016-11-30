-- ¸®Ã÷ °¡Á×»óÁ¡ ¾Æ¸®°í

function NPC_1344:OnSpawn(SpawnInfo)
	this:SetTimer(1, 65, true)
end

function NPC_1344:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$NPC_1344_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1344_2")
		end
	end
end



