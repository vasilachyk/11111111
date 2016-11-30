-- 돛대 술먹는 생선 (술에 절은 케비아)

function NPC_109140:OnSpawn(SpawnInfo)
	this:SetTimer(1, 40, true)
end

function NPC_109140:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$Field_1091401_11" ,5)
		end
		if( dice == 1) then 
			this:Balloon("$$Field_1091401_12")
		end
		if( dice == 2) then 
			this:Balloon("$$Field_1091401_13",5)
		end
	end
end



