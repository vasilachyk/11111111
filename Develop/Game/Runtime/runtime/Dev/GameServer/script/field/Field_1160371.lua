-- 아란바스 화산지대 : 트라이얼 (에르다의 창)

function Field_1160371:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116513) then		
		SpawnInfo.NPC:GainBuff(110070)		
		SpawnInfo.NPC:GainBuff(110081)			
	end	
	if (SpawnInfo.NPCID == 281) then			
		SpawnInfo.NPC:GainBuff(110009)			
	end			
end

function Field_1160371:OnSensorEnter_116037(Actor) -- 흐르는 땅 : 에르다의 창 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160371) == true) then
			AsPlayer(Actor):Tip("이곳에서 에르다의 창을 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116037, 2)
		end
	end
end

function Field_1160371:OnSensorLeave_116037(Actor) -- 흐르는 땅 : 에르다의 창 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116037, 1)
	end
end

function Field_1160371:OnSensorEnter_2(Actor) -- 하프메인 사라지고 나서
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(116037)
		this:SetTimer(1, 10, false)
		AsPlayer(Actor):UpdateQuestVar(116037, 1)
		AsPlayer(Actor):Narration("퀘스트를 완료했습니다. 10초 후 캠프로 자동 귀환합니다.")
	end
end

function Field_1160371:OnTimer(TimerID) -- 10초 후 귀환센서 작동
	if (TimerID == 1) then
		this:DisableSensor(2)	
		this:EnableSensor(3)
	end
end