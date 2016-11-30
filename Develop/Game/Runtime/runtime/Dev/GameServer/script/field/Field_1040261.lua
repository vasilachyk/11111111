function Field_1040261:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 104260) then
		SpawnInfo.NPC:GainBuff(111005)	
	end
end


function Field_1040261:OnSensorEnter_50(Actor) -- 시작 이벤트
	local Leg = this:GetSpawnNPC(104010) 
	this:DisableSensor(50)
	
	local Session = this:MakeSession("Leg",{Leg})		
	Session:AddBookmark("Player", Actor)		
	Session:MakePeace()
end

function Field_1040261:OnSessionScene_Leg_Begin(Session)
	local Leg = this:GetSpawnNPC(104010) 	
	
	Session:MakePeace()
	Leg:Say("$$Field_1040261_001",4.5) 			--Leg:드디어.. 암흑의 시간이 얼마 남지 않았다. 
	Leg:Say("$$Field_1040261_002",11.2)			--Leg:멍청한 라드 녀석이 생명 에너지를 낭비해 버리는 바람에 기다림의 시간이 더 오래 걸리게 되었어. 
	Leg:Say("$$Field_1040261_003",5.2) 			--Leg:하지만 결국 아렐님이 내리신 명령을 해내고 말았다.
	Leg:Say("$$Field_1040261_004",7.7)			--Leg:이제 아르케나 더 소울리버가 부활하고 암흑의 시간이 도래하게 될 것이다.
	
	Session:ChangeScene("ArelSpawn")
end

function Field_1040261:OnSessionScene_Leg_ArelSpawn(Session)
	Session:Blocking()	
	Session:MakePeace()
	this:SpawnByID(104249)
	local Leg = this:GetSpawnNPC(104010) 		
	local Arel = this:GetSpawnNPC(104249)		
	Arel:GainBuff(40904)		
	Arel:FaceTo(Leg)		
	Leg:Wait(2)
	Leg:FaceTo(Arel)
	Leg:Say("$$Field_1040261_005",5.0) 			--Leg:오오.. 암흑의 근원이시여.
	Leg:Say("$$Field_1040261_006",8.0)	 		--Leg:몇 가지 착오가 있긴 했지만, 생명 에너지를 수집하라는 명령을 이행할 수 있었습니다. 
	Leg:Say("$$Field_1040261_007",12.5)	 		--Leg:아르케나 더 소울리버가 부화해 암흑의 하늘이 열리게 되면 당신의 일부가 되어 암흑의 전당에 데려가 주십시오.	
	
	Arel:Say("$$Field_1040261_008",8.5) 		--Arel:수고하셨습니다. 하지만 저를 실망하게 했군요. 생명의 전달자가 쓰러져 생명 에너지의 수집에 차질이 생긴 것을 모르시다니. 정말 실망입니다.		
	
	Leg:FaceTo(Session:FindBookmark("Player"))
	
	Leg:Say("$$Field_1040261_009",16.5)	  		--Leg:아니?! 아렐님. 실망하게 해 드려 죄송합니다. 하지만 지금 저자에게 느껴지는 강력한 생명 에너지라면 오늘로써 아르케나 더 소울리버가 부활할 수 있을 것입니다.
	Leg:Say("$$Field_1040261_010",5)	  		--Leg:이제 드디어 암흑의 시간이 도래할 것입니다.
	Arel:FaceTo(Session:FindBookmark("Player"))	
	Arel:Say("$$Field_1040261_011",14.0) 		--Arel:흠…… 그렇군요. 처음 봤을 때에는 묘했는데, 빛과 연결된 자라. 확실히 이제야 이해가 가는군요. 하하하~ 이래서 사는 게 재미있습니다.		
	Arel:Say("$$Field_1040261_012",2.1) 		--Arel:하하하.		
	
	Leg:Say("$$Field_1040261_013",12.0)		 	--Leg:이제 주인님의 마지막 명령을 이행할 때가 되었다. 너의 생명을 어둠에 바쳐라!
	
	Session:ChangeScene("Combat")
		
end

function Field_1040261:OnSessionScene_Leg_Combat(Session)
	local Arel = this:GetSpawnNPC(104249)			
	Arel:Despawn(false)	
	
	Session:CombatAll()	
	Session:EndSession()	
end

--[[

function ArelSpawn(Self)

	local Field = Self:GetField()
	local Leg = Field:GetSpawnNPC(104010) 
	local Arel = Field:GetSpawnNPC(50)		
	
	Leg:DisableCombat()
	Arel:DisableCombat()	
	
	Arel:GainBuff(40904)		
	Arel:FaceTo(Leg)	
	Arel:Say("훗. 이 곳이 그곳인가.. 순수한 암흑 마법의 기운이군")	
	Arel:WaitFor(Leg)
	Leg:FaceTo(Arel)
	Leg:Say("{ani=pain2}오오.. 암흑의 근원이시여.. ",8)
	Leg:Say("몇가지 착오가 있긴 했지만, 전달자가 생명 에너지를 전달 할 것 입니다. 그 때가 되면, 우리는 일부가 되어 암흑의 전당에 저도 데려가 주십시요.",15)
	Leg:NextAction()	
	Leg:WaitFor(Arel)	
	Arel:Say("{ani=walk}난 그딴것 관심 없다. 내가 하고 싶은 대로 할 뿐.",8) --임시		
	Arel:NextAction()
	Leg:Say("누구냐!!",3)			
	Leg:ScriptSelf("AwarePlayer")				
end

function AwarePlayer(Self)
	local Field = Self:GetField()	
	local Arel = Field:GetSpawnNPC(50)		
	Field:EnableSensor(51)		
end


function Field_1040261:OnSensorEnter_51(Actor)			
	local Leg = this:GetSpawnNPC(104010) 
	local Arel = this:GetSpawnNPC(50)	
	
	this:DisableSensor(51)
	
	Leg:FaceTo(AsPlayer(Actor))
	Arel:FaceTo(AsPlayer(Actor))		
	Arel:WaitFor(Leg)
	Leg:Say("생명의 전달자가 느꼈던 그 강력한 생명이구나. 으하하하~! 더더욱 암흑의 시간이 앞당겨 지겠구나!!", 5)	
	Leg:NextAction()	
	Arel:Say("음.. 그런 것이었군.. 역시 사는 것은 재밌단 말이야", 5) --임시		
	Leg:Say("너의 생명을 받쳐라!", 5)		
	Leg:ScriptSelf("LegCombat")		
end

function LegCombat(Self)		
	local Field = Self:GetField()
	local Leg = Field:GetSpawnNPC(104010)
	local Arel = Field:GetSpawnNPC(50)		
	
	Leg:EnableCombat()
	Leg:ChangeAA(AA_ALWAYS)					
	Arel:Despawn(false)				
end

]]--



