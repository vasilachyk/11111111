-- ¸®Ã÷ ¼ö»ê¹° »óÀÎ »ø¸®

function NPC_1212:OnSpawn(SpawnInfo)
	this:SetTimer(1, 90, true)
end

function NPC_1212:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_7")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_8")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_9")
		end
	end
end



