-- 침식동 (peace)

function Field_116001:OnSensorEnter_116020(Actor) -- 묘지 : 기도문 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160301) == true) then
			AsPlayer(Actor):Tip("이곳에서 정령신주를 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116030, 2)
		end
	end
end
function Field_116001:OnSensorLeave_116030(Actor) -- 묘지 : 멀어지면 기도문 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116030, 1)
	end
end
function Field_116001:OnSensorTalent_116030(Actor, TalentID) -- 기도문 사용시
	if (TalentID == 140554) then
		AsPlayer(Actor):UpdateQuestVar(116030, 3)
		this:SpawnByID(116210, false)
	end
end
