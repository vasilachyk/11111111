function Field_1170521:OnCreate()		
end

function Field_1170521:OnSensorEnter_1(Actor)	
	this:SpawnByID(283)	
end

function Field_1170521:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 117002) then				
		this:SetTimer(1,20,false)
		this:DisableSensor(140709)				
	end 
end


function Field_1170521:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 117002) then			
		this:SpawnByID(117002)	
	end
end


function Field_1170521:OnSensorTalent_140709(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1170682) == true ) and (TalentID == 140709 ) then		
		AsPlayer(Actor):Tip("$$Quest_117052_001")
		this:SetTimer(117002, 10)
	end
end

	
