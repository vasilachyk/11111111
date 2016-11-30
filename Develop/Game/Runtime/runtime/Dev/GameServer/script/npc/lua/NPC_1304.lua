-- ¸®Ã÷ º¥Ä¡³² º¥ÀÚ¹Î

function NPC_1304:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1304:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then 
			this:Balloon("$$NPC_1303_1")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_1304_2")
		end	
	end
end



