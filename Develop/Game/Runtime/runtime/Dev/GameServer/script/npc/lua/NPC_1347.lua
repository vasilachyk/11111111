-- ∏Æ√˜ ±Õ¡∑∫Œ¿Œ ∏∂∏∞

function NPC_1347:OnSpawn(SpawnInfo)
	this:SetTimer(1, 70, true)
end

function NPC_1347:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$NPC_1347_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1347_2")
		end
	end
end



