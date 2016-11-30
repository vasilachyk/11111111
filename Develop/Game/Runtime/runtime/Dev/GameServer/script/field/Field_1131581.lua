--체크포인트센서
function Field_1131581:OnSensorTalent_1(Actor, TalentID)	
	if (this:CheckSensor(200) == true) and (AsPlayer(Actor):CheckCondition(1131581) == true ) and (TalentID == 141200 ) then		
		AsPlayer(Actor):Tip("$$Quest_113158_001")				
		this:SetTimer(2,5,false)			
		this:DisableSensor(200)
	end
end

function Field_1131581:OnSensorTalent_200(Actor, TalentID)	
	if (AsPlayer(Actor):CheckCondition(1131581) == true ) and (TalentID == 141200 ) then		
		AsPlayer(Actor):Tip("$$Quest_113158_001")				
		
		this:SetTimer(2,5,false)			
		this:DisableSensor(200)
	end
end

function Field_1131581:OnSensorEnter_1(Actor)			
	AsPlayer(Actor):Tip("$$Quest_113158_002")		
end

function Field_1131581:OnSensorEnter_1000(Actor)			
	AsPlayer(Actor):Narration("$$Quest_113158_003")
	this:SetTimer(1, 20, false)				
	this:DisableSensor(1000)				
end

function Field_1131581:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 113180) then				
		-- this:SetTimer(1,20,false)			
		this:EnableSensor(1000)
	end 
end


function Field_1131581:OnTimer(TimerID)
	if (TimerID == 1) then			
		this:EnableSensor(2)	
	end
	
	if (TimerID == 2) then			
		this:SpawnByID(113180)
	end
end


