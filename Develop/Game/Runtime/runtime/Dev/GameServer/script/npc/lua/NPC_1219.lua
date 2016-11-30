-- ¸®Ã÷ °î¹° »óÀÎ ¸¶´Ù¸°

function NPC_1219:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_1219:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$Field_1_40")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_42")
		end
	end
end



