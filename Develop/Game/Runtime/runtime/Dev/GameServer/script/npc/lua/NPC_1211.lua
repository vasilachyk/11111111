-- 리츠 수산물 상인 로널드

function NPC_1211:OnSpawn(SpawnInfo)
	this:SetTimer(1, 80, true)
end

function NPC_1211:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:Balloon("$$Field_1_4")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_5")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_6")
		end
	end
end



