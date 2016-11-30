-- µ¿¥Î ¡÷¡§π¿Ã æÀ

function NPC_109004:OnSpawn(SpawnInfo)
	this:SetTimer(1, 70, true)
end

function NPC_109004:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$Field_1090041_11")
		end
		if( dice == 1) then 
			this:Balloon("$$Field_1090041_12")
		end
		if( dice == 2) then 
			this:Balloon("$$Field_1090041_13")
		end
	end
end



