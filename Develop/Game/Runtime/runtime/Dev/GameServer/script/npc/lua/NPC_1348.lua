-- ∏Æ√˜ ±Õ¡∑∫Œ¿Œ æ”∂ﬂ¿¢

function NPC_1348:OnSpawn(SpawnInfo)
	this:SetTimer(1, 65, true)
end

function NPC_1348:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1348_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1348_2")
		end
	end
end



