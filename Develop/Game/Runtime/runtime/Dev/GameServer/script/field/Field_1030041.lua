-- 코웬 늪지대 : 봉봉의 마을 (peace)

function Field_1030041:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 103503) then	
		SpawnInfo.NPC:SetAlwaysRun(true)
	end
	if (SpawnInfo.SpawnID == 103507) then	
		SpawnInfo.NPC:SetAlwaysRun(true)
	end	
	if (SpawnInfo.SpawnID == 103521) then	
		SpawnInfo.NPC:SetAlwaysRun(true)
	end	
	if (SpawnInfo.SpawnID == 103522) then	
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:DisableInteraction()
	end		
end

function Field_1030041:OnSensorEnter_1(Actor) -- 시작시 포로 디버프가 걸림
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(1)
		AsPlayer(Actor):GainBuff(110059)
		local Pago = this:GetSpawnNPC(103503)	
		local Slaver1 = this:GetSpawnNPC(10)		
		local Session = this:MakeSession("Wake", {Pago,Slaver1})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1030041:OnSessionScene_Wake_Begin(Session)
	local Pago = this:GetSpawnNPC(103503)
	local Charle = this:GetSpawnNPC(103504)
	local Garner = this:GetSpawnNPC(103505)	
	local Slaver1 = this:GetSpawnNPC(10)		
		
		Pago:Wait(6)
		Pago:FaceTo(Session:FindBookmark("Player"))
		Pago:Say("{sound=scene9_pago_1}{ani=talk1}이봐요? 정신이 듭니까?",1.2)
		Pago:Say("{sound=scene9_pago_2}{ani=talk1}여긴 봉봉들의 마을입니다. 놈들이 우릴 이곳으로 끌고 왔죠.",3.5)
		Pago:Say("{sound=scene9_pago_3}{ani=negative}당신 몸 상태가 말이 아니군요.",1.8)
		Pago:Say("{sound=scene9_pago_4}{ani=positive}당신의 전투 능력 때문에 놈들이 더 혹독하게 다룬 것 같습니다.",3.4)
		Slaver1:MoveToMarker(100)
		Pago:FaceTo(Slaver1)
		Pago:Say("{sound=scene9_pago_5}{ani=talk1}이런, 우리를 잡아온 놈이 오네요.",1.7)		
		Slaver1:Say("{sound=scene9_slaver1_1}거기, 노예 둘. 일할 시간이다. 빨리 날 따라와!",3.7)	
	Session:ChangeScene("Sensor")
	--Session:EndSession()
end

function Field_1030041:OnSessionScene_Wake_Sensor(Session)
		this:EnableSensor(2)
	Session:EndSession()
end

function Field_1030041:OnSensorEnter_2(Actor) -- 진행 센서
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(2)

		local Pago = this:GetSpawnNPC(103503)
		local Charle = this:GetSpawnNPC(103504)
		local Garner = this:GetSpawnNPC(103505)		
		local Slaver1 = this:GetSpawnNPC(10)			
		local Slaver2 = this:GetSpawnNPC(30)			
		local Runner = this:GetSpawnNPC(103507)			
		local Session = this:MakeSession("Work", {Pago,Charle,Garner,Slaver1,Slaver2,Runner})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1030041:OnSessionScene_Work_Begin(Session)
	local Pago = this:GetSpawnNPC(103503)		
	local Slaver1 = this:GetSpawnNPC(10)	
	Session:Blocking()	
	Pago:StayawayFrom(Slaver1, 300)
	Session:ChangeScene("Seed1")		
end
		
function Field_1030041:OnSessionScene_Work_Seed1(Session)
	local Pago = this:GetSpawnNPC(103503)
	local Slaver1 = this:GetSpawnNPC(10)		
	local Runner = this:GetSpawnNPC(103507)	
	
		Pago:SetAlwaysRun(false)
	Session:NonBlocking()
		Slaver1:Patrol({101, 102},PT_ONCE)		
		Pago:Patrol({110, 111},PT_ONCE)
	Session:Blocking()
		Pago:Say("{sound=scene9_pago_6}저 사람은 조사단의...",1.3)
		Runner:Say("{sound=scene9_researcher_1}안돼! 더는 이렇게 살 수 없어!",2.4)	
		Runner:MoveToMarker(120)
	Session:ChangeScene("Seed2")
end 

function Field_1030041:OnSessionScene_Work_Seed2(Session)
	local Pago = this:GetSpawnNPC(103503)
	local Charle = this:GetSpawnNPC(103504)	
	local Slaver1 = this:GetSpawnNPC(10)	
	local Slaver2 = this:GetSpawnNPC(30)	
	local Runner = this:GetSpawnNPC(103507)	
	
		Pago:FaceTo(Runner)
		Runner:GainBuff(110088)
		Pago:Say("{sound=scene9_pago_7}이런, 세상에!",1.1)
		Slaver1:Say("{sound=scene9_slaver1_2}모든 노예의 몸에는 씨앗이 심어지지...",3.3)
		Slaver1:Say("{sound=scene9_slaver1_3}너희도 명령을 듣지 않으면 저렇게 될 거다.",4.6)
	Session:NonBlocking()			
		Slaver1:Patrol({103},PT_ONCE)	
		Pago:Patrol({112},PT_ONCE)
	Session:Blocking()
		Pago:FaceTo(Charle)
		Pago:Say("{sound=scene9_pago_8}샤를이잖아? 샤를도 여기 붙잡혀 있었어?",2.6)
		Slaver1:FaceTo(Pago)
		Slaver1:Say("{sound=scene9_slaver1_4}누가 저 안경 쓴 녀석을 데리고 흑연꽃을 캐와라.",3.1)
		Slaver1:Say("{sound=scene9_slaver1_5}도망치지 않게 잘 감시하고.",2.8)
		Charle:Say("{sound=scene9_charle_1}노랗고... 파란빛이... 환하게(중얼중얼)",7.6)
		Slaver2:FaceTo(Pago)		
		Slaver2:Say("{sound=scene9_slaver2_1}케케케, 이 녀석은 얼마나 오래 버틸까나.",4.4)		
		Slaver2:Say("{sound=scene9_slaver2_2}자, 어서 가자!",1.5)
		Slaver1:FaceTo(Session:FindBookmark("Player"))
		Slaver1:Say("{sound=scene9_slaver1_6}넌 계속 날 따라와.",1.7)		
		Slaver1:Narration("노예 사냥꾼을 따라가십시오.")
	Session:ChangeScene("Move")
end 
	
function Field_1030041:OnSessionScene_Work_Move(Session)
	local Pago = this:GetSpawnNPC(103503)
	local Slaver1 = this:GetSpawnNPC(10)
	local Slaver2 = this:GetSpawnNPC(30)	
	local Bottle = this:GetSpawnNPC(102)	
	
	Session:NonBlocking()	
		Slaver2:Patrol({115, 116},PT_ONCE)	
		Slaver1:Patrol({104, 105},PT_ONCE)		
		Pago:Patrol({113, 114},PT_ONCE)
	Session:Blocking()
		Slaver1:FaceTo(Session:FindBookmark("Player"))
		Slaver1:Say("{sound=scene9_slaver1_7}너는 오늘 운이 좋군.",1.7)	
		Slaver1:Say("{sound=scene9_slaver1_8}흑연꽃을 캐지 않아도 되니 말이야.",2.7)			
		Slaver1:FaceTo(Bottle)
		Slaver1:Say("{sound=scene9_slaver1_9}안으로 들어가서 병을 가지고 나와라.",2.4)
		this:EnableSensor(5)
		Pago:Despawn(false)
		Slaver2:Despawn(false)		
	Session:EndSession()	
end

function Field_1030041:OnSensorEnter_5(Actor) -- 병 가지고 나오면
	if (Actor:IsPlayer() == true) then	
		if (AsPlayer(Actor):CheckCondition(1030042) == true) then	
			this:DisableSensor(5)	
			local Slaver1 = this:GetSpawnNPC(10)		
			local Session = this:MakeSession("ToSwamp", {Slaver1})
			Session:AddBookmark("Player", Actor)	
		end
	end
end

function Field_1030041:OnSessionScene_ToSwamp_Begin(Session)		
	local Slaver1 = this:GetSpawnNPC(10)	
	Session:Blocking()	
		Slaver1:SetAlwaysRun(true)
		Slaver1:Say("{sound=scene9_slaver1_10}좋아, 잘했다.",2.0)
		Slaver1:Say("{sound=scene9_slaver1_11}이제 한눈팔지 말고 잘 따라오라고.",2.6)		
		Slaver1:Patrol({106, 107, 108, 109},PT_ONCE)	
		this:EnableSensor(6)
	Session:EndSession()			
end

function Field_1030041:OnSensorEnter_6(Actor) -- 늪지 앞까지 이동
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(6)	
		local Slaver1 = this:GetSpawnNPC(10)		
		local Session = this:MakeSession("ToLair", {Slaver1})
		Session:AddBookmark("Player", Actor)	
	end
end

function Field_1030041:OnSessionScene_ToLair_Begin(Session)		
	local Slaver1 = this:GetSpawnNPC(10)	
	Session:Blocking()	
		Slaver1:Say("{sound=scene9_slaver1_12}꾸물대지 말고 빨리 따라와",1.8)		
		Slaver1:Patrol({121, 122, 123, 124},PT_ONCE)	
		this:EnableSensor(7)
	Session:EndSession()				
end

function Field_1030041:OnSensorEnter_7(Actor) -- 크립 둥지 앞
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(7)	
		local Slaver1 = this:GetSpawnNPC(10)		
		local Session = this:MakeSession("UseBottle", {Slaver1})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1030041:OnSessionScene_UseBottle_Begin(Session)		
	local Slaver1 = this:GetSpawnNPC(10)	
	Session:Blocking()	
		Slaver1:Say("{sound=scene9_slaver1_13}저 굴 근처에서 아까 가져온 병을 깨트려.",3.4)	
		this:EnableSensor(1030042)
	Session:EndSession()				
end

function Field_1030041:OnSensorEnter_1030042(Actor) -- 둥지 근처 : 액체가 든 병 사용 가능해짐
	if (Actor:IsPlayer() == true) then	
		Actor:Narration("액체가 든 병을 사용하십시오.")
		AsPlayer(Actor):UpdateQuestVar(103004, 2)
	end
end

function Field_1030041:OnSensorLeave_1030042(Actor) -- 둥지로부터 멀어지면 액체가 든 병이 사용 불가능해짐
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(103004, 1)
	end
end

function Field_1030041:OnSensorTalent_1030042(Actor, TalentID)
	if (TalentID == 140505) then
		Actor:Narration("액체가 든 병을 사용했습니다.")
		this:DisableSensor(1030042)
		AsPlayer(Actor):UpdateQuestVar(103004, 3)
		AsPlayer(Actor):GainBuff(110057)
		local Slaver1 = this:GetSpawnNPC(10)		
		local Reffi = this:GetSpawnNPC(103521)
		local Rynec = this:GetSpawnNPC(103522)		
		local Session = this:MakeSession("Freedom", {Slaver1, Reffi, Rynec})
		Session:AddBookmark("Player", Actor)	
	end
end

function Field_1030041:OnSessionScene_Freedom_Begin(Session)		
	local Slaver1 = this:GetSpawnNPC(10)	
	Session:Blocking()	
		Slaver1:Wait(3)
		Slaver1:Say("{sound=scene9_slaver1_14}이제 놈들한테 한 병으론 부족한가...",3.3)		
		Slaver1:Say("{sound=scene9_slaver1_15}돌아가서 좀 더 가져와야겠다.",2.1)		
		this:SpawnByID(103521)
		this:SpawnByID(103522)
		Slaver1:Wait(3)		
	Session:ChangeScene("Slay")				
end

function Field_1030041:OnSessionScene_Freedom_Slay(Session)		
	local Slaver1 = this:GetSpawnNPC(10)	
	local Reffi = this:GetSpawnNPC(103521)
	local Rynec = this:GetSpawnNPC(103522)
	
	Session:AddNPC(Reffi)
	Session:AddNPC(Rynec)	
		Slaver1:GainBuff(110082)
	Session:NonBlocking()
		Reffi:MoveToMarker(125)
		Rynec:MoveToMarker(126)	
	Session:Blocking()
		Rynec:Say("{sound=scene9_rynec_1}무사하십니까?",0.8)
	Session:ChangeScene("Cure")				
end

function Field_1030041:OnSessionScene_Freedom_Cure(Session)		
	local Reffi = this:GetSpawnNPC(103521)
	local Rynec = this:GetSpawnNPC(103522)
	
	Session:Blocking()	
		Rynec:EnableInteraction()
		Rynec:Say("{sound=scene9_rynec_2}당신을 찾고 있었습니다.",1.3)		
		Reffi:Say("{sound=scene9_reffi_1}일단 놈들이 심어놓은 씨앗부터 제거해 드리죠.",2.7)
	Session:ChangeScene("Talk")					
end

function Field_1030041:OnSessionScene_Freedom_Talk(Session)		
	local Reffi = this:GetSpawnNPC(103521)
	local Rynec = this:GetSpawnNPC(103522)
	
	Session:Blocking()
		Session:FindBookmark("Player"):RemoveBuff(110059)
		Session:FindBookmark("Player"):GainBuff(1754)
	Session:EndSession()				
end