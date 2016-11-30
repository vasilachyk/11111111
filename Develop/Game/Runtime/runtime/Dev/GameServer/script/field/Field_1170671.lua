function Field_1170671:OnSensorEnter_1(Actor)	

	if (this:CheckSensor(140708) == true ) and (AsPlayer(Actor):CheckCondition(1170671) == true ) and (TalentID == 140708 ) then		
		-- AsPlayer(Actor):Tip("폴루토가 냄새를 맡고 곧 나타날 것입니다!")		
		this:SetTimer(2,5,false)					
		this:DisableSensor(140708)
	end
end

function Field_1170671:OnSensorTalent_140708(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1170671) == true ) and (TalentID == 140708 ) then		
		-- AsPlayer(Actor):Tip("폴루토가 냄새를 맡고 곧 나타날 것입니다!")		
		this:SetTimer(2,5,false)			
		this:DisableSensor(140708)
	end
end


function Field_1170671:OnSensorEnter_3(Actor)	
	this:SpawnByID(283)
	this:DisableSensor(3)
	AsPlayer(Actor):Tip("$$Quest_117067_001")		
end

function Field_1170671:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 117000) then				
		this:SetTimer(1,20,false)			
	end 
end


function Field_1170671:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 2) then			
		this:SpawnByID(117000)
	end
end


