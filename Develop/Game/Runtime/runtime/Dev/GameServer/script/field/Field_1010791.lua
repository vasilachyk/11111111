--체크포인트센서
function Field_1010791:OnSensorTalent_1(Actor, TalentID)	
	if (this:CheckSensor(200) == true) and (AsPlayer(Actor):CheckCondition(1010791) == true ) and (TalentID == 140063 ) then		
		AsPlayer(Actor):Tip("$$Quest_101079_001")				
		this:SetTimer(2,5,false)			
		this:DisableSensor(200)
	end
end

function Field_1010791:OnSensorTalent_200(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1010791) == true ) and (TalentID == 140063 ) then		
		AsPlayer(Actor):Tip("$$Quest_101079_001")				
		
		this:SetTimer(2,5,false)			
		this:DisableSensor(200)
	end
end

function Field_1010791:OnSensorEnter_3(Actor)		
	this:DisableSensor(3)
	AsPlayer(Actor):Tip("$$Quest_101079_002")		
end


function Field_1010791:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 101020) then				
		this:SetTimer(1,20,false)			
	end 
end


function Field_1010791:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 2) then			
		this:SpawnByID(101020)
	end
end


