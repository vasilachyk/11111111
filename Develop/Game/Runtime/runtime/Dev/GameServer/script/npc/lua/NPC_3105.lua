-- 인젠 채소상인 아리

function NPC_3105:OnSpawn(SpawnInfo)
	this:SetTimer(1, 130, true)
end

function NPC_3105:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_19")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_20")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_21")
		end
	end
end



