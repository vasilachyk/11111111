-- 이벤트용 호박요정

function NPC_3314:OnSpawn(SpawnInfo)
	this:SetTimer(1, 180, true)	
	this:GainBuff(111639)
end


function NPC_3314:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,3)
		if( dice == 0) then
			this:Balloon("$$NPC_3314_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_3314_2")
		end
		if( dice == 2) then
			this:Balloon("$$NPC_3314_3")
		end
		if( dice == 3) then
			this:Balloon("$$NPC_3314_4")
		end
	end
end