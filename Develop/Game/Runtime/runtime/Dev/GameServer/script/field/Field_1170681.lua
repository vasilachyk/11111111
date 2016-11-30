--체크포인트 센서
function Field_1170681:OnSensorEnter_1(Actor)		
	if (this:CheckSensor(140709) == true) and (AsPlayer(Actor):CheckCondition(1170681) == true ) and (TalentID == 140709 ) then		
		-- AsPlayer(Actor):Tip("펑거스가 냄새를 맡고 곧 나타날 것입니다!")				
		this:SetTimer(2,5,false)					
		this:DisableSensor(140709)
	end	
end


function Field_1170681:OnSensorTalent_140709(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1170681) == true ) and (TalentID == 140709 ) then		
		-- AsPlayer(Actor):Tip("펑거스가 냄새를 맡고 곧 나타날 것입니다!")		
		
		this:SetTimer(2,5,false)			
		this:DisableSensor(140709)
	end
end


function Field_1170681:OnSensorEnter_3(Actor)	
	this:SpawnByID(283)
	this:DisableSensor(3)
	AsPlayer(Actor):Tip("$$Quest_117068_001")	
end

function Field_1170681:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 117002) then				
		this:SetTimer(1,20,false)			
	end 
end


function Field_1170681:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 2) then			
		this:SpawnByID(117002)
	end
	
end


