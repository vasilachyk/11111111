function Field_512001:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 512104) then -- 고위사제 콰트라 이동
		
		SpawnInfo.NPC:Patrol({12,13,14,15,16,17,18,19,20,21}, PT_LOOP_BACKORDER)
		
 
	elseif (SpawnInfo.NPCID == 512108) then -- 협잡꾼 도지 도주 시작
		
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:Balloon("$$Field_512001_10")
		SpawnInfo.NPC:Patrol({3,4,5,6,7,8,9,10,11}, PT_ONCE)
		SpawnInfo.NPC:Despawn(false)	
		
	elseif (SpawnInfo.NPCID == 512112) then -- 상위기사 탐핀 이동
		
		SpawnInfo.NPC:Patrol({24,25,26,27,28,29,30,31,32,33,34,35,36}, PT_LOOP_BACKORDER)
			
		
	elseif (SpawnInfo.NPCID == 113214) then -- 헤이든
		--SpawnInfo.NPC:SetAlwaysRun(true)	
		
	elseif (SpawnInfo.NPCID == 113217) then -- 아이젠트 트리어
		--SpawnInfo.NPC:SetAlwaysRun(true)
		this:EnableSensor(10)

	elseif (SpawnInfo.NPCID == 113245) then -- 제일스의 영혼
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:Wait(6)
		SpawnInfo.NPC:ScriptSelf("Field_512001_Event2")
		
	end
end

function Field_512001:OnDie(DespawnInfo) 
	local Field = this:GetID()
	
	if (DespawnInfo.SpawnID == 134) then -- 만넬로스 사망시 
		this:EnableSensor(9)	
	end
	
	if (DespawnInfo.SpawnID == 23) then -- 바스테로 사망
		DespawnInfo.NPC:NarrationNow("$$Field_512001_42")		
	end
	if (DespawnInfo.SpawnID == 24) then -- 리비우트 사망
		DespawnInfo.NPC:NarrationNow("$$Field_512001_45")		
	end
end

function Field_512001:OnSensorEnter_9(Actor) -- 퀘스트를 가진자가 있다면 이벤트를 작동	
	if (Actor:IsPlayer() == true) then	
		if (AsPlayer(Actor):CheckCondition(1131132) == true)then
			this:DisableSensor(9)
			local Heiden = this:GetSpawnNPC(113214)
			local WarpPos = this:GetMarkerPos(52)
			Heiden:DisableInteraction()
			Heiden:Narration("$$Field_512001_56")
			Heiden:Warp(WarpPos)
			this:SpawnByID(113217)
			this:SpawnByID(113222)			
		end
	end
end

function Field_512001:OnSensorEnter_10(Actor) -- 센서에 닿으면 이벤트 1
	this:DisableSensor(10)
	local Jar = this:GetSpawnNPC(113222)
	local Heiden = this:GetSpawnNPC(113214)
	local Iesent = this:GetSpawnNPC(113217)
	this:PlayBGM("bgm_Scenetalk_2") 	
	
	if (Actor:IsPlayer() == true) then	
		Heiden:StayawayFrom(Jar, 300)
		Iesent:StayawayFrom(Jar, 300)
		Heiden:WaitFor(Iesent)
		Iesent:Say("$$Field_512001_75",2.0) -- 이것이 바로 생명의 단지야
		Iesent:Say("$$Field_512001_76",3.7) -- 이 단지를 파괴하면 만넬로스는 영원히 사라지게 된다.
		Iesent:NextAction()
		Heiden:Say("$$Field_512001_78",2.4) -- 저 생명의 단지를 파괴하시게
	end
end

function Field_512001_Event2(Self)	-- 생명의 단지 파괴 후
	local Field = Self:GetField()
	local Jails = Field:GetSpawnNPC(113245)
	--Field:DespawnByID(113217, false)
	Field:EnableSensor(11)
end

function Field_512001:OnSensorEnter_11(Actor) -- 센서에 닿으면 이벤트 2
	this:DisableSensor(11)
	local Heiden = this:GetSpawnNPC(113214)
	local Jails = this:GetSpawnNPC(113245)
	
	if (Actor:IsPlayer() == true) then	
		Jails:GainBuff(110032)
		Heiden:WaitFor(Jails)
		Jails:Say("$$Field_512001_97",4.3) -- 내 모든 계획이 물거품이 되다니
		Jails:Say("$$Field_512001_98",3.0) -- 이 치욕은 반드시 값아주고 말겠다.
		Jails:NextAction()
		Jails:WaitFor(Heiden)
		Heiden:Say("$$Field_512001_101",2.4) -- 난 아렐의 성격을 잘 알지
		Heiden:Say("$$Field_512001_102",4.0) -- 아렐이 실패를 거듭한 그대에게 더 이상 기회를 줄 거 같나?
		Heiden:NextAction()
		this:PlayBGM("bgm_Scenewar_1") 
		Heiden:WaitFor(Jails)		
		Jails:Say("$$Field_512001_106",2.9) -- 아니, 우리와 아렐님의 존재를 알고 있다니.
		Jails:Say("$$Field_512001_107",1.9) -- 네놈들 정체가 뭐냐
		Jails:NextAction()
		Heiden:Say("$$Field_512001_109")		
		Heiden:NonDelaySay("$$Field_512001_110",2.3) -- 자네와는 더 이상 볼일이 없다네		
		Heiden:UseTalent(140017, Jails)
		Heiden:ScriptSelf("Field_512001_Event3",1.7) -- 잘 가게. 제일스
	end
end

function Field_512001_Event3(Self)	-- 생명의 단지 파괴 후에
	local Field = Self:GetField()
	local Jails = Field:GetSpawnNPC(113245)
	local Heiden = Field:GetSpawnNPC(113214)
	Heiden:EnableInteraction()
	Jails:GainBuff(110035)	
	Jails:Say("$$Field_512001_122",3.5)	-- 으아아아~ 크아아악~
	Jails:ScriptSelf("Field_512001_DespawnSelf")
end

function Field_512001_DespawnSelf(Self)
	Self:Despawn(true)
end






