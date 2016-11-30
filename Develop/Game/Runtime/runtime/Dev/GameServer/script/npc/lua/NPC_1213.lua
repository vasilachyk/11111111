-- ¸®Ã÷ Á¤À°Á¡ Á÷¿ø Á¶ÀÌ

function NPC_1213:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_1213:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$Field_1_10")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_11")
		end
	end
end



