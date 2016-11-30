-- ¿Œ¡® √§º“ªÛ¿Œ ¿⁄∏£µÚ

function NPC_3104:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_3104:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_16")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_17")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_18")
		end
	end
end



