--[[
	f0104.lua
	
	Swamp of the Silence
	Script by Joongpil Cho(Venister)
]]--

--[[ --------------------------------------------------------------------------------------------------------------------------
	PORTAL
------------------------------------------------------------------------------------------------------------------------- ]]--

function Field_104:OnSpawn(SpawnInfo)
	--퀘스트주는 NPC들의 로밍처리
	--성기사 크롱
	if (SpawnInfo.NPCID == 104234) then	this:SetTimer(1042340, 1000, true)	end
	
	--용병 장인 제럴드
	if (SpawnInfo.NPCID == 104203) then	this:SetTimer(1042030, 1500, true)	end
	
	--S급 용병 엠마
	if (SpawnInfo.NPCID == 104206) then	this:SetTimer(1042060, 2000, true) end
	
	--빛의 치유사 에르메스
	if (SpawnInfo.NPCID == 104238) then this:SetTimer(1042380, 1000, true)	end
	
	--대장장이 인아누
	if (SpawnInfo.NPCID == 104215) then	this:SetTimer(1042150, 1400, true)	end
		
	--꾸미기NPC 패트롤 처리
	--지휘사령부 순찰하는병사1
	if (SpawnInfo.NPCID == 104520) then	this:SetTimer(1045200, 3000, true)	end
	
	--지휘사령부 순찰하는병사2	
	if (SpawnInfo.NPCID == 104521) then	this:SetTimer(1045210, 2000, true)	end
	
	--지휘사령부 대화하는병사1 talk1
	if (SpawnInfo.SpawnID == 10451000) then	this:SetTimer(1045100,25,true) end
	
	--지휘사령부 대화하는병사2 talk1
	if (SpawnInfo.SpawnID == 10451100) then this:SetTimer(1045110,35,true) 	end
	
	--지휘사령부 훈련하는병사1
	if (SpawnInfo.SpawnID == 10454000) then this:SetTimer(1045400,33,true) 	end
	
	--지휘사령부 훈련하는병사2
	if (SpawnInfo.SpawnID == 10454100) then this:SetTimer(1045410,41,true) 	end
	
	--지휘사령부 보급지원상인 남자
	if (SpawnInfo.SpawnID == 10453000) then this:SetTimer(1045300,10,true) 	end
	
	--지휘사령부 보급지원상인 여자
	if (SpawnInfo.SpawnID == 10453200) then this:SetTimer(1045320,10,true) 	end
	
	
	
	---퀘스트에 사용되는 NPC들 처리
	if (SpawnInfo.NPCID == 104282) then	SpawnInfo.NPC:GainBuff(111000)	end	
	if (SpawnInfo.NPCID == 104283) then	SpawnInfo.NPC:GainBuff(111000)	end	
	if (SpawnInfo.NPCID == 104284) then	SpawnInfo.NPC:GainBuff(111000)	end
	
	---퀘스트 몬스터 처리 
	--변절자 메르다
	if (SpawnInfo.NPCID == 104192) then	this:SetTimer(1041920, 1000, true)	end
	--S급 용병 오리할크
	if (SpawnInfo.NPCID == 104103) then	this:SetTimer(1041030, 500, true) end
	
end


function Field_104:OnSensorEnter_10402500(Actor)
	if (AsPlayer(Actor):CheckCondition(1040251) == true and (AsPlayer(Actor):GetQuestVar(104025)  ~= 3)) then						
		AsPlayer(Actor):UpdateQuestVar(104025, 3)
		
		this:SpawnByID(104195)  -- 생명의 전달자
		this:SpawnByID(104255)  -- X-50
		
		-- local totem = this:GetSpawnNPC(104289)	 	
		-- totem:UseTalentSelf(140609)			
		
		local life_messenger =  this:GetSpawnNPC(104195)
		local x50 =  this:GetSpawnNPC(104255)				
		
		local Session = this:MakeSession("life_messenger",{life_messenger, x50})
		Session:AddBookmark("Player", Actor)		
	end
end


function Field_104:OnSessionScene_life_messenger_Begin(Session)

	local life_messenger =  this:GetSpawnNPC(104195)
	local x50 =  this:GetSpawnNPC(104255)			
	
	life_messenger:Say("$$Field_104_001",3.2) 	-- life_messenger:Say("{ani=roar}으하하~! 역시 돌연변이 놈들") --
	life_messenger:Say("$$Field_104_002",6.0) 	-- life_messenger:Say("이 멍청이 같은 놈들이 일은 확실히 해 놨군. 생명 에너지를 꽉꽉 채워놨군!")
	life_messenger:Say("$$Field_104_003",4.5) 	-- life_messenger:Say("드디어 아렐님이 바라시던 생명 에너지를 거의 다 모을 수 있게 되었어!")
	
	x50:Say("$$Field_104_004",3.7) 				-- x50:Say("으으.. 그게 무슨 말씀이신가요?")
	x50:Say("$$Field_104_005",3.5)		 		-- x50:Say("{ani=talk1}친구들에게 영혼을 넣어 준 것이 아닌가요?")		
	
	life_messenger:Say("$$Field_104_006",4.1) 	--life_messenger:Say("{ani=atk1}네놈 따위 돌연변이가 영혼을 원하다니... 기가 차는군.")
	life_messenger:Say("$$Field_104_007",3.4)	--life_messenger:Say("이젠 필요가 없어졌으니…… 이만 꺼져라.")				
	
	Session:ChangeScene("Combat")

end


function Field_104:OnSessionScene_life_messenger_Combat(Session)

	local life_messenger =  this:GetSpawnNPC(104195)
	local x50 =  this:GetSpawnNPC(104255)			
	
	Session:CombatSession()		
	life_messenger:UseTalent(140608 ,x50)
	
	Session:ChangeScene("Conversation")
end

function Field_104:OnSessionScene_life_messenger_Conversation(Session)

	local life_messenger =  this:GetSpawnNPC(104195)
	local x50 =  this:GetSpawnNPC(104255)			
	local totem = this:GetSpawnNPC(104289)	 		
	
	x50:Say("$$Field_104_008",3.8)			 	-- x50:Say("{ani=die_0}아아아~~~ 악! 안돼!")			
	Session:RemoveNPC(x50)		
	x50:Despawn(false)
	
	life_messenger:Say("$$Field_104_009",6.3) 	-- life_messenger:Say("라드 녀석이 생명 에너지를 이따위로 만들지 않았으면 이런 귀찮은 일을 하지 않아도 되는데 말이야.")
	life_messenger:Say("$$Field_104_010",4.0)	-- life_messenger:Say("오호~ 돌연변이 녀석이 쓸만한 선물을 준비해 놨군.")		
	
	life_messenger:FaceTo(Session:FindBookmark("Player"))
	
	life_messenger:Say("$$Field_104_011",4.4)  	-- life_messenger:Say("네 녀석의 생명 에너지는 정말 대단하군. 에너지를 내놓아라!")
	
	
	Session:ChangeScene("AttackPlayer")
	
end

function Field_104:OnSessionScene_life_messenger_AttackPlayer(Session)
	
	local life_messenger =  this:GetSpawnNPC(104195)
	local x50 =  this:GetSpawnNPC(104255)			
	local totem = this:GetSpawnNPC(104289)	 	
		
	Session:AddNPC(totem)
	Session:RemoveNPC(life_messenger)		
	Session:RemoveNPC(x50)			
	Session:CombatSession()
	totem:UseTalentSelf(140609)			
	Session:EndSession()
end

	
	
--[[
function Field_104:OnSensorEnter_10402500(Actor)
	if (AsPlayer(Actor):CheckCondition(1040251) == true and (AsPlayer(Actor):GetQuestVar(104025)  ~= 3)) then						
		AsPlayer(Actor):UpdateQuestVar(104025, 3)
		
		this:SpawnByID(104195)  -- 생명의 전달자
		this:SpawnByID(104255)  -- X-50
		
		local life_messenger =  this:GetSpawnNPC(104195)
		local x50 =  this:GetSpawnNPC(104255)		
		
		x50:WaitFor(life_messenger)
		life_messenger:DisableCombat()
		x50:DisableCombat()		
		life_messenger:ChangeAA(AA_NONE)		
		x50:ChangeAA(AA_NONE)		
		
		life_messenger:Say("{ani=roar}으하하.. 역시 돌연변이 놈 생명력을 꽉꽉 채워놨군.")
		life_messenger:Say("나는 아르케나에 의해 만들어진 생명체.")
		life_messenger:Say("드디어 아렐님이 바라던 생명 에너지를 거의 모을 수 있게 됐군.")
		life_messenger:NextAction()
		
		life_messenger:WaitFor(x50)
		x50:Say("그그.. 그렇다면…")
		x50:Say("{ani=talk1}친구들에게 영혼을 넣어준게 아닌가요?")		
		x50:NextAction()
		
		x50:WaitFor(life_messenger)		
		life_messenger:Say("{ani=atk1}너 따위 돌연변이가 영혼을 원하다니.. 기가 차는 군")
		life_messenger:NextAction()
		life_messenger:Say("이젠 필요가 없어졌으니.. 이만 꺼져라.")				
		x50:Say("!!")			
		x50:ScriptSelf("Field_104_diex50")		
		life_messenger:UseTalent(140608 ,x50)
		
		-- 한대 맞고 쓰러짐		
		-- usetalent 처리해서 범위안에 player들에게 현재 HP의 50%를 만들어 주기
		
	end
end

function Field_104_diex50(Self)	
	local Field = Self:GetField()
	local life_messenger = Field:GetSpawnNPC(104195)		
	Self:Say("{ani=die}  흐윽")			
	Self:Despawn(false)	
	life_messenger:Say("클클클 하찮은 돌연변이 주제에!!")
	life_messenger:Say("아렐님이 더욱 기뻐하시겠구나!!클클클",5)				
	life_messenger:Say("네 녀석의 생명력은 정말 대단하군.")
	life_messenger:Say("생명력을 내 놓아라!")	
	life_messenger:ScriptSelf("Field_104_life_messenger_atk")		
end

function Field_104_life_messenger_atk(Self)
	local Field = Self:GetField()
	local life_messenger = Field:GetSpawnNPC(104195)		
	local totem = Field:GetSpawnNPC(104289)	
	
	totem:UseTalentSelf(140609)	
	
	life_messenger:EnableCombat()		
	life_messenger:ChangeAA(AA_ALWAYS)
end


]]--


-- Portal to Swamp
function Field_104:OnSensorEnter_1(Actor)
	AsPlayer(Actor):GateToMarker(103, 3);
end

-- Portal to Limos Desert
function Field_104:OnSensorEnter_2(Actor)
	AsPlayer(Actor):GateToMarker(105, 2);
end



-- 고통의 문 파괴  -도르레 사용하면 몬스터 스폰 -- 퀘스트. 루아로 처리



function Field_104:OnTimer(TimerID) 

	--퀘스트 주는 NPC 처리
	
	--용병단
	if (TimerID == 1042340) then
		local npc = this:GetSpawnNPC(104234)		
		npc:Patrol({10423400,10423401,10423402,10423403,10423404}, PT_ONCE_RETURN)		
	end
	
	if (TimerID == 1042030) then
		local npc = this:GetSpawnNPC(104203)		
		npc:Patrol({10420300,10420301,10420302,10420303,10420304,10420305,10420306}, PT_ONCE)
	end	
	
	if (TimerID == 1042060) then
		local npc = this:GetSpawnNPC(104206)		
		npc:Patrol({10420600,10420601,10420602,10420603,10420604,10420605}, PT_ONCE)
	end
	
	if (TimerID == 1042380) then
		local npc = this:GetSpawnNPC(104238)		
		npc:Patrol({10423800,10423801,10423802,10423803,10423804}, PT_ONCE_RETURN)		
	end
	
	if (TimerID == 1042150) then
		local npc = this:GetSpawnNPC(104215)		
		npc:Patrol({10421500,10421501,10421502,10421503,10421504,10421505,10421506,10421507}, PT_ONCE)		
	end
	
	
	--지휘사령부
	if (TimerID == 1045200) then
		local npc = this:GetSpawnNPC(104520)		
		npc:Patrol({10452000,10452001,10452002,10452003,10452004,10452005,10452006,10452007,10452008,10452009,10452010,10452011,10452012,10452013,10452014,10452015,10452016,10452017,10452018,10452019,10452020,10452021}, PT_ONCE)		
	end
	
	if (TimerID == 1045210) then
		local npc = this:GetSpawnNPC(104521)		
		npc:Patrol({10452100,10452101,10452102,10452103,10452104,10452105}, PT_ONCE)		
	end
	
	
	--대화하는병사1 talk1	
	if (TimerID == 1045100) then
		local dice1 = math.random(0,2)		
		
		local talknpc1 = this:GetSpawnNPC(10451000)		
		local talknpc2 = this:GetSpawnNPC(10451001)
		local talknpc3 = this:GetSpawnNPC(10451002)
		local talknpc4 = this:GetSpawnNPC(10451003)
		local talknpc5 = this:GetSpawnNPC(10451004)
		local talknpc6 = this:GetSpawnNPC(10451005)
		local talknpc7 = this:GetSpawnNPC(10451006)
		local talknpc8 = this:GetSpawnNPC(10451007)
		
	
		-- GLog("[1]dice = "..dice1.."\n")
		if dice1 == 0 then								
			talknpc1:Balloon("{ani=talk1}")
			talknpc2:Balloon("{ani=talk2}")
			talknpc3:Balloon("{ani=talk3}")
		end		
		
		if dice1 == 1 then		
			talknpc4:Balloon("{ani=positive}")
			talknpc5:Balloon("{ani=talk1}")
			talknpc6:Balloon("{ani=talk2}")
		end
		
		if dice1 == 2 then		
			talknpc7:Balloon("{ani=talk3}")
			talknpc8:Balloon("{ani=positive}")
		end

	end
	
	
		
	--대화하는병사2 talk1	
	if (TimerID == 1045110) then
	
		local dice2 = math.random(0,2)		
		
		local talknpc1 = this:GetSpawnNPC(10451100)		
		local talknpc2 = this:GetSpawnNPC(10451101)
		local talknpc3 = this:GetSpawnNPC(10451102)
		local talknpc4 = this:GetSpawnNPC(10451103)
		local talknpc5 = this:GetSpawnNPC(10451104)
		local talknpc6 = this:GetSpawnNPC(10451105)
		local talknpc7 = this:GetSpawnNPC(10451106)
		local talknpc8 = this:GetSpawnNPC(10451107)
		
	
		-- GLog("[2]dice = "..dice2.."\n")
		if dice2 == 0 then								
			talknpc1:Balloon("{ani=talk1}")
			talknpc2:Balloon("{ani=talk2}")
			talknpc3:Balloon("{ani=talk3}")
		end		
		
		if dice2 == 1 then		
			talknpc4:Balloon("{ani=positive}")
			talknpc5:Balloon("{ani=talk1}")
			talknpc6:Balloon("{ani=talk2}")
		end
		
		if dice2 == 2 then		
			talknpc7:Balloon("{ani=talk3}")
			talknpc8:Balloon("{ani=positive}")
		end
	
	end
	
	
	
	--훈련하는 병사1 동작 처리
	if(TimerID == 1045400) then
		local dice3 = math.random(0,5)				
		local trainSoldier1_1 = this:GetSpawnNPC(10454000)		
		local trainSoldier1_2 = this:GetSpawnNPC(10454001)		
		local trainSoldier1_3 = this:GetSpawnNPC(10454002)		
		local trainSoldier1_4 = this:GetSpawnNPC(10454003)		
		-- GLog("[3]dice = "..dice3.."\n")
		if dice3 == 0 then trainSoldier1_1:Balloon("{ani=respire}") end		
		if dice3 == 1 then trainSoldier1_2:Balloon("{ani=respire}") end		
		if dice3 == 2 then trainSoldier1_3:Balloon("{ani=respire}") end		
		if dice3 == 3 then trainSoldier1_4:Balloon("{ani=respire}") end						
		
	end
	
	--훈련하는 병사2 동작 처리
	if(TimerID == 1045410) then
		local dice4 = math.random(0,3)				
		-- GLog("[4]dice = "..dice4.."\n")
		local trainSoldier2_1 = this:GetSpawnNPC(10454100)		
		local trainSoldier2_2 = this:GetSpawnNPC(10454101)				
		
		if dice4 == 0 then trainSoldier2_1:Balloon("{ani=respire}") end		
		if dice4 == 1 then trainSoldier2_2:Balloon("{ani=respire}") end		
	end
	
	--지원상인 남자1 동작 처리
	if (TimerID == 1045300) then
		local dice5 = math.random(0,8)		
		local male_mechant_1 = this:GetSpawnNPC(10453000)		
		local male_mechant_2 = this:GetSpawnNPC(10453001)		
		local male_mechant_3 = this:GetSpawnNPC(10453002)				
		local male_mechant_4 = this:GetSpawnNPC(10453003)				
		local male_mechant_5 = this:GetSpawnNPC(10453004)				
		local male_mechant_6 = this:GetSpawnNPC(10453005)				
		local male_mechant_7 = this:GetSpawnNPC(10453006)				
		local male_mechant_8 = this:GetSpawnNPC(10453007)				
		local male_mechant_9 = this:GetSpawnNPC(10453008)						
		
		-- GLog("[5]dice = "..dice5.."\n")
				
		if dice5 == 0 then male_mechant_1:Balloon("{ani=ignore}") end		
		if dice5 == 1 then male_mechant_2:Balloon("{ani=boring}") end		
		if dice5 == 2 then male_mechant_3:Balloon("{ani=dance2}") end				
		if dice5 == 3 then male_mechant_4:Balloon("{ani=lookaround}") end		
		if dice5 == 4 then male_mechant_5:Balloon("{ani=sneeze}") end		
		if dice5 == 5 then male_mechant_6:Balloon("{ani=complain}") end		
		if dice5 == 6 then male_mechant_7:Balloon("{ani=kiss}") end
		if dice5 == 7 then male_mechant_8:Balloon("{ani=dance3}") end		
		if dice5 == 8 then male_mechant_9:Balloon("{ani=laugh}") end		
		
	end
	
	if (TimerID == 1045320) then
		local dice6 = math.random(0,2)	
		-- GLog("[6]dice = "..dice6.."\n")		
		
		local female_mechant_1 = this:GetSpawnNPC(10453200)		
		local female_mechant_2 = this:GetSpawnNPC(10453201)		
		local female_mechant_3 = this:GetSpawnNPC(10453202)				
		local female_mechant_4 = this:GetSpawnNPC(10453203)				
		local female_mechant_5 = this:GetSpawnNPC(10453204)				
		local female_mechant_6 = this:GetSpawnNPC(10453205)				
		local female_mechant_7 = this:GetSpawnNPC(10453206)				
		local female_mechant_8 = this:GetSpawnNPC(10453207)				
		local female_mechant_9 = this:GetSpawnNPC(10453208)		
			
		if dice6 == 0 then female_mechant_1:Balloon("{ani=dance1}") end		
		if dice6 == 1 then female_mechant_2:Balloon("{ani=laugh}") end		
		if dice6 == 2 then female_mechant_3:Balloon("{ani=cheer}") end				
		if dice6 == 3 then female_mechant_4:Balloon("{ani=nagetive}") end		
		if dice6 == 4 then female_mechant_5:Balloon("{ani=positive}") end		
		if dice6 == 5 then female_mechant_6:Balloon("{ani=shy}") end		
		if dice6 == 6 then female_mechant_7:Balloon("{ani=talk1}") end
		if dice6 == 7 then female_mechant_8:Balloon("{ani=talk2}") end		
		if dice6 == 8 then female_mechant_9:Balloon("{ani=clap}") end		
	
	end
	
	
	-- 퀘스트 몬스터 처리

	if (TimerID == 1042150) then
		local npc = this:GetSpawnNPC(104215)		
		npc:Patrol({10419200,10419201,10419202,10419203,10419204,10419205}, PT_ONCE_RETURN)
	end
	
	if (TimerID == 1041030) then
		local npc = this:GetSpawnNPC(104103)		
		npc:Patrol({10410300,10410301,10410302,10410303,10410304,10410305,10410306,10410307}, PT_ONCE_RETURN)
	end
	
	--104007 에너지측량 - 아르케나 사용
	if (TimerID == 1040070) then	
		local a_energy1 = this:GetSpawnNPC(104282)
		local a_energy2 = this:GetSpawnNPC(104283)
		local a_energy3 = this:GetSpawnNPC(104284)		
		
		if (a_energy1:CheckBuff(111000) == true) then												
			a_energy1:GainBuff(111000)
		end
		
		if (a_energy2:CheckBuff(111000) == true) then									
			a_energy2:GainBuff(111000)
		end
		
		if (a_energy3:CheckBuff(111000) == true) then									
			a_energy3:GainBuff(111000)
		end		
	
	end
	
	
	--104012 청색 신호탄 이펙트 버프해제
	if (TimerID == 1040120) then
	
		local pyrotechnics1 = this:GetSpawnNPC(104285)
		local pyrotechnics2 = this:GetSpawnNPC(104286)
		local pyrotechnics3 = this:GetSpawnNPC(104287)
		local pyrotechnics4 = this:GetSpawnNPC(104288)
		
		if (pyrotechnics1:CheckBuff(111001) == true) then			
			pyrotechnics1:RemoveBuff(111001)
			pyrotechnics1:RemoveBuff(111003)
		end
		
		if (pyrotechnics2:CheckBuff(111001) == true) then			
			pyrotechnics2:RemoveBuff(111001)
			pyrotechnics2:RemoveBuff(111003)			
		end
		
		if (pyrotechnics3:CheckBuff(111001) == true) then			
			pyrotechnics3:RemoveBuff(111001)
			pyrotechnics3:RemoveBuff(111003)
		end
		
		if (pyrotechnics4:CheckBuff(111001) == true) then			
			pyrotechnics4:RemoveBuff(111001)
			pyrotechnics4:RemoveBuff(111003)			
		end
	
	end	
	
	-- 104020 크라이크에 걸린 이펙트 버프를 해제
	if (TimerID == 1040200) then		
		local cryik = this:GetSpawnNPC(104254)		
		if (cryik:CheckBuff(40904) == true) then					
			cryik:RemoveBuff(40904)					
		end
	end
	
	-- 104023 타워 이펙트 버프 해제
	if (TimerID == 1040230) then		
		local black_tower = this:GetSpawnNPC(104276)
		if (black_tower:CheckBuff(111002) == true) then					
			black_tower:RemoveBuff(111002)					
		end
	
	end
	
	--104019 고통의 도르레 인터렉션 되면 디스폰 할때까지의 시간
	if (TimerID == 1040190) then		
		local pain_pulley = this:GetSpawnNPC(104290)		
		if pain_pulley:GetMode() == 1 then
			this:DespawnByID(pain_pulley)
		end
	end
end

function Field_104:OnSensorEnter_104285(Actor)	
	local pyrotechnics1 = this:GetSpawnNPC(104285)
	
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (pyrotechnics1:CheckBuff(111001) == false) then								
		pyrotechnics1:GainBuff(111001) --110087로 변경해야 함			
		this:SetTimer(1040120, 20, false)				
	end	
end

function Field_104:OnSensorEnter_104286(Actor)
	local pyrotechnics2 = this:GetSpawnNPC(104286)			
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (pyrotechnics2:CheckBuff(111001) == false) then		
		pyrotechnics2:GainBuff(111001) --110087로 변경해야 함	
		this:SetTimer(1040120, 20, false)
	end	
end

function Field_104:OnSensorEnter_104287(Actor)
	local pyrotechnics3 = this:GetSpawnNPC(104287)
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (pyrotechnics3:CheckBuff(111001) == false) then						
		pyrotechnics3:GainBuff(111001) --110087로 변경해야 함	
		this:SetTimer(1040120, 20, false)
	end	
end


function Field_104:OnSensorEnter_104288(Actor)
	local pyrotechnics4 = this:GetSpawnNPC(104288)			
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (pyrotechnics4:CheckBuff(111001) == false) then			
		pyrotechnics4:GainBuff(111001) --110087로 변경해야 함	
		this:SetTimer(1040120, 20, false)
	end	
end

--104012 청색 신호탄 사용
function Field_104:OnSensorTalent_104285(Actor, TalentID)
	local pyrotechnics1 = this:GetSpawnNPC(104285)	
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (TalentID == 140603 ) then		
		AsPlayer(Actor):UpdateQuestVar(104012, 1)						
		pyrotechnics1:GainBuff(111003)
		this:SetTimer(1040120, 20, false)		
	end
end

function Field_104:OnSensorTalent_104286(Actor, TalentID)
	local pyrotechnics2 = this:GetSpawnNPC(104286)	
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (TalentID == 140603 ) then	
		AsPlayer(Actor):UpdateQuestVar(104012, 2)					
		pyrotechnics2:GainBuff(111003)
		this:SetTimer(1040120, 20, false)		
	end
end

function Field_104:OnSensorTalent_104287(Actor, TalentID)
	local pyrotechnics3 = this:GetSpawnNPC(104287)
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (TalentID == 140603 ) then	
		AsPlayer(Actor):UpdateQuestVar(104012, 3)					
		pyrotechnics3:GainBuff(111003)
		this:SetTimer(1040120, 20, false)		
	end	
end


function Field_104:OnSensorTalent_104288(Actor, TalentID)
	local pyrotechnics4 = this:GetSpawnNPC(104288)	
	if (AsPlayer(Actor):CheckCondition(1040121) == true ) and (TalentID == 140603 ) then	
		AsPlayer(Actor):UpdateQuestVar(104012, 4)
		pyrotechnics4:GainBuff(111003)
		this:SetTimer(1040120, 20, false)		
	end
end


------------------


--104007 에너지측량 - 아르케나 사용1
function Field_104:OnSensorTalent_104282(Actor, TalentID)
	local a_energy1 = this:GetSpawnNPC(104282)
	if (AsPlayer(Actor):CheckCondition(1040071) == true ) and (TalentID == 140601) then				
		AsPlayer(Actor):UpdateQuestVar(104007, 1)			
		--this:DisableSensor(117226)
	end
end

--104007 에너지측량 - 아르케나 사용2
function Field_104:OnSensorTalent_104283(Actor, TalentID)
	local a_energy2 = this:GetSpawnNPC(104283)	
	if (AsPlayer(Actor):CheckCondition(1040071) == true ) and (TalentID == 140601 ) then	
		AsPlayer(Actor):UpdateQuestVar(104007, 2)					
	end
end

--104007 에너지측량 - 아르케나 사용3
function Field_104:OnSensorTalent_104284(Actor, TalentID)
	local a_energy3 = this:GetSpawnNPC(104284)	
	if (AsPlayer(Actor):CheckCondition(1040071) == true ) and (TalentID == 140601 ) then			
		AsPlayer(Actor):UpdateQuestVar(104007, 3)					
	end
end

-- 104020 빨간약 대신 성수를… - 성수 사용
function Field_104:OnSensorTalent_104254(Actor, TalentID)
	if (AsPlayer(Actor):CheckCondition(1040201) == true ) and (TalentID == 140604 ) then		
		
		local cryik = this:GetSpawnNPC(104254)
		
		cryik:Say("$$Field_104_013",10) --cryik:Say("{ani=shiver} 으아아가!! 비겁하게 성수를 쓰다니..",10)
		cryik:GainBuff(40904)
		
		this:SetTimer(1040200, 10, false)		
		
		AsPlayer(Actor):UpdateQuestVar(104020, 1)
	end	
end


-- 104019 너도 나도 모두 속은거야

-- function Field_104:OnSensorEnter_104289(Actor)
	-- if (AsPlayer(Actor):CheckCondition(1040191 == true) ) then		
		-- AsPlayer(Actor):Tip("토템을 설치하기 적당합니다")
	-- end
-- end


-- function Field_104:OnSensorTalent_104289(Actor, TalentID)
	-- if (AsPlayer(Actor):CheckCondition(1040191) == true ) and (TalentID == 140605 ) then		
		
		-- local life_stealer = this:GetSpawnNPC(104195)
		-- local emma = this:GetSpawnNPC(104195)
		
		
	-- end

-- end



--104023 희망은 없지만, 절망도 없다

function Field_104:OnSensorEnter_104276(Actor)	
	local black_tower = this:GetSpawnNPC(104276)
	black_tower:GainBuff(111002)
	
	this:SetTimer(1040230, 20, false)		
	-- black_tower:Say("나한테 탈렌트를 쓰시오")
end

function Field_104:OnSensorTalent_104276(Actor, TalentID)
	if (AsPlayer(Actor):CheckCondition(1040231) == true ) and (TalentID == 140607 ) then				
		local black_tower = this:GetSpawnNPC(104276)						
		black_tower:Die(black_tower)
		AsPlayer(Actor):UpdateQuestVar(104023, 2)
	end	
end
