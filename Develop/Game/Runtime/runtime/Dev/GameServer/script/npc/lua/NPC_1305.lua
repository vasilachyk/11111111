-- 리츠 잡담 아줌마 네가와

function NPC_1305:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_1305:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,1)
		if( dice == 0) then 
			this:Balloon("$$NPC_1305_1")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_1305_2")
		end	
	end
end



