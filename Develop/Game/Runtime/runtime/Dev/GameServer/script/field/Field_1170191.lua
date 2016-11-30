function Field_1170191:OnSensorEnter_110(Actor)			
	this:SpawnByID(11750400)
	this:DisableSensor(110)
	
	local GuardSoldier = this:GetSpawnNPC(11750400)	
	local Session = this:MakeSession("FindMarini",{GuardSoldier})			
	Session:AddBookmark("Player", Actor)
	GLog("Enter110")	
	
end

function Field_1170191:OnSessionScene_FindMarini_Begin(Session)		
	local GuardSoldier = this:GetSpawnNPC(11750400)	
	GuardSoldier:SetAlwaysRun(true)
		
	GuardSoldier:FaceTo(Session:FindBookmark("Player"))
	GuardSoldier:Say("$$Field_1170191_1")	-- 어허. 뭐 이리도 늦게 오나.
	GuardSoldier:Say("$$Field_1170191_2")	-- 레이디가 이곳을 지나갔다는 정보를 입수했네. 이 근처 어딘가에 있을게 분명해. 날 따라오게. 어서!
	GuardSoldier:Patrol({11000, 11001, 11002, 11003}, PT_ONCE)
	
	Session:ChangeScene("Find_1")	
	GLog("Find_1")	
end


function Field_1170191:OnSessionScene_FindMarini_Find_1(Session)				
	local GuardSoldier = this:GetSpawnNPC(11750400)
	
	GuardSoldier:FaceTo(Session:FindBookmark("Player"))
	GuardSoldier:Say("$$Field_1170191_3")	-- 음. 여긴 없는 것 같군. 도대체 어디에 숨어 있는 거지? 계속 수색해보세.
	GuardSoldier:Patrol({11004, 11005, 11006}, PT_ONCE)
	Session:ChangeScene("Find_2")
	GLog("Find_2")
end

function Field_1170191:OnSessionScene_FindMarini_Find_2(Session)
	
	local GuardSoldier = this:GetSpawnNPC(11750400)
	
	GuardSoldier:FaceTo(Session:FindBookmark("Player"))
	GuardSoldier:Say("$$Field_1170191_4")	-- 이 부근도 아니군. 이제 남은 건 위쪽뿐인가? 일단 가보세. 아직 늦지 않았을 거야.
	GuardSoldier:Patrol({11007,11008, 11009}, PT_ONCE)
	Session:ChangeScene("Find_3")
	GLog("Find_3")
end

function Field_1170191:OnSessionScene_FindMarini_Find_3(Session)	
	local GuardSoldier = this:GetSpawnNPC(11750400)	
	GuardSoldier:Say("$$Field_1170191_5")	-- 저기 있는 여자는 혹시?!			
	Session:EndSession()
	GLog("EndSession1")	
end


function Field_1170191:OnSensorEnter_300(Actor)	
	if (Actor:IsNPC() == false) then	
		return 		
	end		
	
	this:DisableSensor(300)	
	this:EnableSensor(299)
	
	this:SpawnByID(11750400)	
	this:SpawnByID(117501)	
end

function Field_1170191:OnSensorEnter_299(Actor)	
	this:DisableSensor(299)
	
	local EscapeLady = this:GetSpawnNPC(117501)											
	local GuardSoldier = this:GetSpawnNPC(11750400)					
			
	local Session = this:MakeSession("ArrestMarini", {EscapeLady, GuardSoldier})								
	Session:AddBookmark("Player", Actor)	
end


function Field_1170191:OnSessionScene_ArrestMarini_Begin(Session)

	local EscapeLady = this:GetSpawnNPC(117501)									
	local GuardSoldier = this:GetSpawnNPC(11750400)				
	
	EscapeLady:FaceTo(GuardSoldier) 			
	GuardSoldier:Say("$$Field_1170191_6",2.9)	-- 드디어 찾았군! 네 이년 정체를 밝혀라!
	EscapeLady:Say("$$Field_1170191_7",2.1)		-- 응!? 벌써 나를 찾아낸 건가?
	EscapeLady:Say("$$Field_1170191_8",3.6)		-- 하지만, 과연 너희 따위가 날 막을 수 있을까? 받아랏!!
	Session:CombatSession()
	EscapeLady:UseTalentSelf(140702)
	
	Session:ChangeScene("Escape1")
	GLog("Escape1")
end

function Field_1170191:OnSessionScene_ArrestMarini_Escape1(Session)
	
	local EscapeLady = this:GetSpawnNPC(117501)
	local GuardSoldier = this:GetSpawnNPC(11750400)
	
	EscapeLady:SetAlwaysRun(true)	
	-- Session:NonBlocking()
	-- Session:MakePeace()				
	EscapeLady:MoveToMarker(11750100)	
	GuardSoldier:SayNow("$$Field_1170191_9",2.8)	-- 크윽!! 모든 문을 봉쇄하랏!!		
	this:SpawnByID(11736000)	
	this:SpawnByID(50121200)
	Session:ChangeScene("Escape2")
	GLog("Escape2")	
end


function Field_1170191:OnSessionScene_ArrestMarini_Escape2(Session)
	
	local EscapeLady = this:GetSpawnNPC(117501)											
	local GuardSoldier = this:GetSpawnNPC(11750400)	
	local ActivateDoor = this:GetSpawnNPC(11736000)					
	
	-- Session:Blocking()			
	this:SpawnByID(50121200)		
	ActivateDoor:Say("$$Field_1170191_10")			--guard:Say("헉헉...문을 닫았습니다!!!")
	
			
	EscapeLady:FaceTo(ActivateDoor)
	EscapeLady:Say("$$Field_1170191_11",5.5)			-- 모든 출구를 봉쇄한 건가? 하?! 깔깔깔, 우습구나.
	EscapeLady:FaceTo(GuardSoldier) 			
	
	Session:ChangeScene("Escape3_0")
	GLog("Escape3")
end


function Field_1170191:OnSessionScene_ArrestMarini_Escape3_0(Session)
	
	local EscapeLady = this:GetSpawnNPC(117501)												
	local GuardSoldier = this:GetSpawnNPC(11750400)			
	local WarpPos = this:GetMarkerPos(11750101)
	local WarpEffect1 = this:GetSpawnNPC(30100)
	local WarpEffect2 = this:GetSpawnNPC(30101)
	
	WarpEffect1:GainBuff(111104)
	WarpEffect2:GainBuff(111104)
	
	GuardSoldier:Say("$$Field_1170191_12")			-- 아니!
	EscapeLady:FaceTo(GuardSoldier)
	EscapeLady:Warp(WarpPos)
	EscapeLady:FaceTo(GuardSoldier)	
	EscapeLady:Say("$$Field_1170191_13",5.2)			-- 이렇게 허술하게 뒤를 빼앗기는데, 봉쇄를 한다고 무슨 소용이냐, 애석하구나.		
	-- EscapeLady:UseTalentSelf(140705)
	
	Session:ChangeScene("Escape4")
	GLog("Escape4")
end

function Field_1170191:OnSessionScene_ArrestMarini_Escape4(Session)
	local EscapeLady = this:GetSpawnNPC(117501)
	local GuardSoldier = this:GetSpawnNPC(11750400)				
	
	Session:CombatSession()
	-- Session:NonBlocking()	
	GuardSoldier:SayNow("$$Field_1170191_14")		-- 으악!		
	-- GuardSoldier:Die(GuardSoldier)			
	EscapeLady:UseTalent(140705, GuardSoldier)		
	-- Session:Blocking()	
	
	Session:ChangeScene("Escape4_0")	
	GLog("Escape4_0")
end

function Field_1170191:OnSessionScene_ArrestMarini_Escape4_0(Session)	
	local EscapeLady = this:GetSpawnNPC(117501)
	-- local GuardSoldier = this:GetSpawnNPC(11750400)			
	
	EscapeLady:FaceTo(Session:FindBookmark("Player"))			
	EscapeLady:Say("$$Field_1170191_15",2.7)			-- 아니? 넌...... 내 계획을 방해한 용병이구나."
	EscapeLady:FaceTo(Session:FindBookmark("Player"))
	EscapeLady:Say("$$Field_1170191_16",5.6)			-- 호호...... 하지만 겨우 그 실력으로 용케 내 계획을 방해했군.
	EscapeLady:FaceTo(Session:FindBookmark("Player"))
	EscapeLady:Say("$$Field_1170191_17",4.1)			-- 날 알아보는 자 앞에서 더 이상 이 모습으로 있을 필요는 없지.
	
	
	Session:ChangeScene("Escape5")
	
	--이펙트 더미 NPC를 만들자
	for i = 30000, 30006 do
		this:SpawnByID(i)
	end	
	
	GLog("Escape5")
end

	
function Field_1170191:OnSessionScene_ArrestMarini_Escape5(Session)
	this:DespawnByID(117501, false)	
	this:SpawnByID(117502)

	local Marini = this:GetSpawnNPC(117502)
	Session:AddNPC(Marini)		
	
	Marini:FaceTo(Session:FindBookmark("Player"))	
	
	local WarpEffect1 = this:GetSpawnNPC(30100)
	local WarpEffect2 = this:GetSpawnNPC(30101)
	WarpEffect1:RemoveBuff(111104)
	WarpEffect2:RemoveBuff(111104)
	
	Marini:FaceTo(Session:FindBookmark("Player"))
	Marini:Say("$$Field_1170191_18",3.0)			-- 성 파넬 수도원 이후로는 오랜만이지?	
	
	Marini:FaceTo(Session:FindBookmark("Player"))	
	Marini:Say("$$Field_1170191_19",4.7)			-- 더 이상 너와 상대하는 것은 귀찮구나. 내 아이들과 상대하거라.			
	
	Session:ChangeScene("Escape6")
	
	GLog("Escape6")
end


function Field_1170191:OnSessionScene_ArrestMarini_Escape6(Session)
	--타이머가 몬스터를 스폰하고 이펙트를 생성해준다
	this:SetTimer(11701910, 1, false)
	
	local Marini = this:GetSpawnNPC(117502)
	Marini:GainBuff(111105)
	
	Session:EndSession()
	GLog("TimerOn")	
end


function Field_1170191:OnSensorEnter_400(Actor)
	this:DisableSensor(400)
	-- this:KillTimer(11701912)
	
	local Marini = this:GetSpawnNPC(117502)		
	local Session = this:MakeSession("Finish", {Marini})									
	
	AsPlayer(Actor):UpdateQuestVar(117019, 1)
	
	Session:AddBookmark("Player", Actor)					
	GLog("Enter400")
end

function Field_1170191:OnSessionScene_Finish_Begin(Session)	
	local Marini = this:GetSpawnNPC(117502)	
	Marini:RemoveBuff(111105)
	Marini:FaceTo(Session:FindBookmark("Player"))
	Marini:Say("$$Field_1170191_20",6.3)			-- 아르케나 에너지로 강화된 아이들을 상대로 힘겨워하다니. 과연 이걸 받아낼 수 있을까?			
	Marini:UseTalent(140703, Session:FindBookmark("Player")) --파이어볼								
	
	Marini:FaceTo(Session:FindBookmark("Player"))
	Marini:Say("$$Field_1170191_21",4.7)			-- ...... 용케 받아냈군. 시간이 없으니 목숨만을 살려주겠다.
	Marini:Say("$$Field_1170191_22",6.0)			-- 하지만 앞으로 나의 계획을 계속 방해하면 그때에는 더 이상 자비 따윈 없을 것이다.								
	
	Session:ChangeScene("End0")	
		
end

function Field_1170191:OnSessionScene_Finish_End0(Session)		
	this:DespawnByID(117502, false)		
	this:SetTimer(117502, 1, false)
	Session:EndSession()
	GLog("Finish")		
end

function Field_1170191:OnDie(DespawnInfo)		
	
	if (DespawnInfo.NPCID == 117510) then 	
		if (this:GetNPCCount(117510) == 0 ) and (this:GetNPCCount(117511) == 0 ) then
			this:EnableSensor(400)			
			GLog("DespawnGetAllMon")
		end
	end
	
	if (DespawnInfo.NPCID == 117511) then
		if (this:GetNPCCount(117510) == 0 ) and (this:GetNPCCount(117511) == 0 ) then
			this:EnableSensor(400)			
			GLog("DespawnGetAllMon")
		end	
	end
	
	-- if (DespawnInfo.NPCID == 117502) then		
		-- this:SetTimer(117502, 10 , false)	
	-- end
end


-- function Field_1170191:OnSensorEnter_500(Actor)	
	-- AsPlayer(Actor):GateToMarker(117, 3)	
	-- GLog("Enter 500")
-- end
	
function Field_1170191:OnTimer(TimerID)
	
	-- if (TimerID == 11701912) then		
	
		-- local dice = math.random(0,2)		 
		-- local Marini = this:GetSpawnNPC(117502)
		
		-- if dice == 0 then					
			-- Marini:Say("$$Field_1170191_015") 		--marini:Say("후훗 아직 끝난게 아니야!") 		
		-- end
	
		-- if dice == 1 then				
			-- Marini:Say("$$Field_1170191_016") 			--marini:Say("어서 날 잡아보시지 그래!") 			
		-- end					
	-- end
	
	if (TimerID == 11701910) then		
		
		local effect1 = this:GetSpawnNPC(30000)
		local effect2 = this:GetSpawnNPC(30001)
		local effect3 = this:GetSpawnNPC(30002)
		local effect4 = this:GetSpawnNPC(30003)
		local effect5 = this:GetSpawnNPC(30004)
		local effect6 = this:GetSpawnNPC(30005)
		local effect7 = this:GetSpawnNPC(30006)
		
		effect1:GainBuff(40904)
		effect2:GainBuff(40904)
		effect3:GainBuff(40904)
		effect4:GainBuff(40904)
		effect5:GainBuff(40904)
		effect6:GainBuff(40904)
		effect7:GainBuff(40904)		
				
		for i = 20000, 20011 do			
			this:SpawnByID(i)	
		end		
		
		this:SetTimer(11701911, 5, false)				
	end	
	
	if (TimerID == 11701911 ) then
	
		local effect1 = this:GetSpawnNPC(30000)
		local effect2 = this:GetSpawnNPC(30001)
		local effect3 = this:GetSpawnNPC(30002)
		local effect4 = this:GetSpawnNPC(30003)
		local effect5 = this:GetSpawnNPC(30004)
		local effect6 = this:GetSpawnNPC(30005)
		local effect7 = this:GetSpawnNPC(30006)
		
		-- local wall = this:GetSpawnNPC(11724302)		
		-- local guard1 = this:GetSpawnNPC(11736000)					
		-- local door = this:GetSpawnNPC(50121200)		
		
		effect1:RemoveBuff(40904)
		effect2:RemoveBuff(40904)
		effect3:RemoveBuff(40904)
		effect4:RemoveBuff(40904)
		effect5:RemoveBuff(40904)
		effect6:RemoveBuff(40904)
		effect7:RemoveBuff(40904)		
		
		-- this:DespawnByID(wall, false)
		-- this:DespawnByID(guard1, false)
		-- this:DespawnByID(door, false)			
		-- this:EnableSensor(100)			
		-- this:EnableSensor(101)			
		
		-- this:EnableSensor(400)
		
	end
	
	if (TimerID == 117502) then				
		-- this:Despawn(117502, false)
		this:EnableSensor(500)		
	end
end

 
 function Field_1170191:OnSpawn(SpawnInfo)	
	if (SpawnInfo.NPCID == 117226) then	
		local cursed_water1 = this:GetNPC(117226)
		cursed_water1:GainBuff(111100)
	end
	
	--오염된물질 	
	if (SpawnInfo.NPCID == 117227) then	
		local cursed_water2 = this:GetNPC(117227)
		cursed_water2:GainBuff(111101)
	end
end

