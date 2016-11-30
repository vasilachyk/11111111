-- 에다산 어딘가.. (디아고 트라이얼)
function Field_1020201:OnSensorEnter_2(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		Field:DisableSensor(2)	
		Field:SpawnByID(2)
		--AsPlayer(Actor):UpdateQuestVar(102020,2)
	end
end

function Field_1020201:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 2) then
		
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:Patrol({3,4,5,6,7}, PT_ONCE)

		--AsPlayer(Actor):UpdateQuestVar(102020, 2)
		--SpawnInfo.Field:SetTimer(1, 17, false)
		--SpawnInfo.Field:SetTimer(2, 13, false)		
	end	
end

function Field_1020201:OnTimer(TimerID)
	if (TimerID == 1) then
		this:EnableSensor(3)
	end
	--if (TimerID == 2) then
		--this:EnableSensor(4)
	--end	
end
