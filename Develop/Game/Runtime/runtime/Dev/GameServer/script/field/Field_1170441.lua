function Field_1170441:OnCreate()
	-- this:SpawnByID(117000)
end

function Field_1170441:OnSensorEnter_1(Actor)	
	this:SpawnByID(283)	
end


function Field_1170441:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 117000) then		
		this:SetTimer(1,20,false)					
		this:DisableSensor(140708)		
	end 
end


function Field_1170441:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 117000) then			
		this:SpawnByID(117000)
	end
	
end

function Field_1170441:OnSensorTalent_140708(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1170672) == true ) and (TalentID == 140708 ) then		
		AsPlayer(Actor):Tip("$$Quest_117044_001")
		this:SetTimer(117000, 10)
	end
end

	

