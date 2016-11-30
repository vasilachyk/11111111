-- 당신이 잠든 사이

function Field_1030211:OnSensorEnter_1(Actor) -- 환각 시작
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(1)	
		AsPlayer(Actor):GainBuff(110063)
	end
end
function Field_1030211:OnSensorEnter_2(Actor) -- 환각 끝
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):RemoveBuff(110063)
	end
end
function Field_1030211:OnSensorEnter_11(Actor) -- 첫번째 센서
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(11)	
		this:SpawnByID(300)
		this:SpawnByID(301)
		this:SpawnByID(302)
		this:SpawnByID(303)
		this:SpawnByID(304)
		this:SpawnByID(305)
		this:SpawnByID(306)
		this:SpawnByID(307)
		this:SpawnByID(308)
		this:SpawnByID(309)
		this:SpawnByID(310)		
	end
end

function Field_1030211:OnSensorEnter_13(Actor) -- 퀘스트 완료시
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(13)
		this:SetTimer(1, 10, false)
		AsPlayer(Actor):Narration("퀘스트를 완료했습니다. 10초 후 캠프로 자동 귀환합니다.")
	end
end

function Field_1030211:OnTimer(TimerID) -- 10초 후 귀환센서 작동
	if (TimerID == 1) then
		this:EnableSensor(2)
	end
end

function Field_1030211:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:SetAlwaysRun(true)
	if (SpawnInfo.SpawnID == 303) or (SpawnInfo.SpawnID == 304) or (SpawnInfo.SpawnID == 308) then 
		SpawnInfo.NPC:Patrol({101,102,103,104,105,106,107,108,109,110,111}, PT_ONCE)	
	end
	if (SpawnInfo.SpawnID == 300) or (SpawnInfo.SpawnID == 301) or (SpawnInfo.SpawnID == 305)  or (SpawnInfo.SpawnID == 309)then 
		SpawnInfo.NPC:Patrol({201,202,203,204,205,206,207,208,209,210,211}, PT_ONCE)
	end
	if (SpawnInfo.SpawnID == 302) or (SpawnInfo.SpawnID == 306) or (SpawnInfo.SpawnID == 307)  or (SpawnInfo.SpawnID == 310)then 
		SpawnInfo.NPC:Patrol({301,302,303,304,305,306,307,308,309,310,311,312,313}, PT_ONCE)
	end	
end