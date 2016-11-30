-- ÀÎÁ¨ Á¤À°Á¡ Á÷¿ø ¹ÌÅ¸

function NPC_3102:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_3102:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_10")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_11")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_12")
		end
	end
end



