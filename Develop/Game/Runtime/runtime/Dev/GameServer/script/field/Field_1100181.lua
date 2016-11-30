
-- ////////////////////////// 트라이얼 진입 관련 ///////////////////////////
function Field_1100181:OnSensorEnter_1(Actor) -- 시작 이벤트
	local Field = Actor:GetField()
	if Actor:IsPlayer() == true then
		if (AsPlayer(Actor):CheckCondition(1100182) == false) then
			Field:DisableSensor(1)
			AsPlayer(Actor):UpdateQuestVar(110018, 2)
			AsPlayer(Actor):Narration("$$Field_1100181_8")
		elseif (AsPlayer(Actor):CheckCondition(1100182) == true) then
			Field:DisableSensor(1)		
			local Location = AsPlayer(Actor):GetPos()
			local Fixed = Math_GetDistancePoint(Location, vec3(-0.91, 0.41, 0.0), 800)
			Field:Spawn(110023, Fixed)			
		end
	end
end

function Field_1100181:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 110023) then  -- 요오마 등장시
		
		SpawnInfo.NPC:Narration("$$Field_1100181_15")
	end
end

function Field_1100181:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 110023) then  -- 요오마 사망시 
		this:SetTimer(1, 11, false)
	end
end

function Field_1100181:OnTimer(TimerID) -- 요오마 사망 후 10초뒤 대형 센서가 켜지며 이동
	if (TimerID == 1) then
		this:EnableSensor(2)
	end
end
