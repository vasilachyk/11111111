-- 府明 家券贱荤 其扼府

function NPC_1124:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_1124:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:GainBuff(111608)
			this:Balloon("$$Field_1_22")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_23")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_24")
		end
	end
end



