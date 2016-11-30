-- 리츠 연금술사 보르도 

function NPC_1337:OnSpawn(SpawnInfo)
	this:SetTimer(1, 62, true)
end

function NPC_1337:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then
			this:Balloon("$$NPC_1337_1")
		end
		if( dice == 1) then
			this:Balloon("$$NPC_1337_2")
		end
	end
end



