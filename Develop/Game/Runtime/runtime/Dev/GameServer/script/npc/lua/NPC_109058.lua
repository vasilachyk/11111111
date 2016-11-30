-- 돛대 술마시는 선원

function NPC_109058:OnSpawn(SpawnInfo)
	this:SetTimer(1, 100, true)
end

function NPC_109058:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$Field_1092001_11")
		end
		if( dice == 1) then 
			this:Balloon("$$Field_1092001_11")
		end
		if( dice == 2) then 
			this:Balloon("$$Field_1092001_11")
		end
	end
end



