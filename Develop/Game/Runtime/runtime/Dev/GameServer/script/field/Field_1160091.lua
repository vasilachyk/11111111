-- 아란바스 화산지대 : 아란바스의 폭군 트라이얼

function Field_1160091:OnSensorEnter_1(Actor) -- 센서에 닿으면 아레크 도망 
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(1)
		this:PlayBGM("bgm_Scenetalk_2") 
	end
end

function Field_1160091:OnSensorEnter_2(Actor) -- 센서에 닿으면 아레크 도망 
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(2)
		this:SpawnByID(116504)
		local Arek = this:GetSpawnNPC(116501)
		this:KillTimer(1)
		Arek:ClearJob()
		Arek:MoveToMarker(501)
		
		local Halfmain = this:GetSpawnNPC(116504)
		local Bear = this:GetSpawnNPC(116507)			
		local Hwendril = this:GetSpawnNPC(116508)
		local Fedel = this:GetSpawnNPC(116509)					
		local Session = this:MakeSession("HalfmainRage", {Halfmain,Bear,Hwendril,Fedel})			
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160091:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 116501) then -- 아레크
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:UseTalentSelf(211650101)		
		this:SetTimer(1, 8, true)
	end		
	if (SpawnInfo.SpawnID == 116507) then -- 베오그릴
		SpawnInfo.NPC:SetAlwaysRun(true)	
		SpawnInfo.NPC:DisableInteraction()	
		--SpawnInfo.NPC:GainBuff(110070)
		SpawnInfo.NPC:GainBuff(110071)
	end	
	if (SpawnInfo.SpawnID == 116508) then -- 휀드릴	
		SpawnInfo.NPC:GainBuff(110071)
	end	
	if (SpawnInfo.SpawnID == 116509) then -- 페델		
		SpawnInfo.NPC:GainBuff(110071)
	end		
end

function Field_1160091:OnTimer(TimerID) -- 아레크 초마다 브레스
	if (TimerID == 1) then
		Arek = this:GetSpawnNPC(116501)
		Arek:UseTalentSelf(211650101)
	end
end

function Field_1160091:OnSessionScene_HalfmainRage_Begin(Session)
	local Arek = this:GetSpawnNPC(116501)
	local Halfmain = this:GetSpawnNPC(116504)	
	local Bear = this:GetSpawnNPC(116507)
	local Hwendril = this:GetSpawnNPC(116508)
	local Fedel = this:GetSpawnNPC(116509)	
		
	Session:Blocking()
		Halfmain:SetAlwaysRun(true)
		Halfmain:MoveToMarker(2)	
		Halfmain:FaceTo(Arek)
		Halfmain:Say("{sound=scene10_halfmain_1}{ani=talk2}돌아와! 이 쓸데없이 덩치만 큰 도마뱀 녀석아!", 3.7)	
		--Bear:RemoveBuff(110070)		
		--Hwendril:RemoveBuff(110071)		
		--Fedel:RemoveBuff(110071)
	Session:ChangeScene("extinguish1")
end

function Field_1160091:OnSessionScene_HalfmainRage_extinguish1(Session)
	local Bear = this:GetSpawnNPC(116507)
	local Halfmain = this:GetSpawnNPC(116504)
		--Bear:Wait(2)
		Bear:RemoveBuff(110071)
		Bear:MoveToMarker(3)
		Bear:UseTalentSelf(211650701)			
	Session:ChangeScene("extinguish2")	
end

function Field_1160091:OnSessionScene_HalfmainRage_extinguish2(Session)
	local Bear = this:GetSpawnNPC(116507)
	local Halfmain = this:GetSpawnNPC(116504)	
	
	Session:NonBlocking()	
		--this:Despawn(116404, false) -- 모든 116404가 사라지지 않는다.
		this:DespawnByID(100)
		this:DespawnByID(101)
		this:DespawnByID(102)
		this:DespawnByID(103)
		this:DespawnByID(108)
		this:DespawnByID(109)		
		this:DespawnByID(116)
		this:DespawnByID(117)
		this:DespawnByID(118)			
	Session:ChangeScene("extinguish3")
end

function Field_1160091:OnSessionScene_HalfmainRage_extinguish3(Session)
	local Bear = this:GetSpawnNPC(116507)
	local Halfmain = this:GetSpawnNPC(116504)	
	
	Session:Blocking()
		Halfmain:Say("{sound=scene10_halfmain_2}눈 앞에서 녀석을 놓치다니!",2.1)		
		Halfmain:FaceTo(Bear)
		Halfmain:Say("{sound=scene10_halfmain_3}{ani=complain}베오그릴, 너무 방심한 거 아닌가?",2.5)
		Bear:Say("{sound=scene10_beorgril_1}{ani=sigh}면목이 없습니다. 대장",1.8)
		Halfmain:Say("{sound=scene10_halfmain_4}{ani=talk5}상황이 이리 되었으니 어쩔 수 없지. 화재를 진압하고 전우들의 시신을 수습하게.", 5.3)
		Halfmain:Say("{sound=scene10_halfmain_5}{ani=talk1}난 침식동으로 가 있겠네.",2.1)
		Bear:Say("{sound=scene10_beorgril_2}알겠습니다.",0.7)
	Session:ChangeScene("End")
end

function Field_1160091:OnSessionScene_HalfmainRage_End(Session)
	local Bear = this:GetSpawnNPC(116507)
	local Halfmain = this:GetSpawnNPC(116504)
	
	Session:NonBlocking()
		Halfmain:Patrol({4,5}, PT_ONCE)		
		Bear:FaceTo(Session:FindBookmark("Player"))	
		Bear:Say("{sound=scene10_beorgril_3}{ani=wave}자네는 이리 와서 나 좀 보세.",1.7)	
	Session:Blocking()	
		Bear:EnableInteraction()		
	Session:EndSession()
end