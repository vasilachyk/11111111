-- 늪지 생태 보고서 : 트라이얼 필드
function Field_1030011:OnSensorEnter_103000(Actor) -- 시작점 : 체크 포인트, QuestVar(1)
	
	if (Actor:IsPlayer() == true) then		
		AsPlayer(Actor):UpdateQuestVar(103001, 1)
	end
end

function Field_1030011:OnSensorEnter_103001(Actor) -- 캠프에 도착했을때
	this:DisableSensor(103001)
	
	if (Actor:IsPlayer() == true) then	
		local Narrator = this:GetSpawnNPC(103500)
		this:PlayBGM("bgm_Scenetalk_1")	
		Narrator:Narration("캠프는 비어있습니다. 아무래도 조사단에게 무슨 일이 생긴 것 같습니다.")
		Narrator:Wait(3)
		Narrator:Narration("푸른 섬광탄을 사용해 신호를 보내십시오.")	
		AsPlayer(Actor):UpdateQuestVar(103001, 2)
	end
end

function Field_1030011:OnSensorTalent_103002(Actor, TalentID)
	if (TalentID == 140501) then
		this:SpawnByID(103200)
		Actor:Narration("누군가 뛰어오는 소리가 들립니다.")
		AsPlayer(Actor):UpdateQuestVar(3)
		local Pago = this:GetSpawnNPC(103200)
		local Session = this:MakeSession("PagoRun", {Pago})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1030011:OnSessionScene_PagoRun_Begin(Session)
	local Pago = this:GetSpawnNPC(103200)
		Pago:SetAlwaysRun(true)
		Pago:Patrol({11,12,13,14}, PT_ONCE)
		Pago:FaceTo(Session:FindBookmark("Player"))
		Pago:Say("{ani=respire}허억... 허억. 긴급 신호를 날린 사람이 당신입니까?")
		Pago:Say("{ani=talk1}아니! 야영지에 있던 사람들은 다 어디로 간 거지?")	
	Session:ChangeScene("End")
end

function Field_1030011:OnSessionScene_PagoRun_End(Session)
		this:EnableSensor(103003)
	Session:EndSession()
end

