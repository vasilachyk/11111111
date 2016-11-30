function Field_117:OnCreate() 
	-- GLog("create Line")	
	-- this:SetTimer(1, 50, false)	-- 퀘스트 초기화용
	---퀘스트용 이펙트 나오게 하는것	
	this:SetTimer(1,60,false)
	-- GLog("settimer 60 on")	
	
	
	-- this:SpawnByID(117226)
	-- this:SpawnByID(117227)	
		
end


function Field_117:OnSpawn(SpawnInfo)	

	if (SpawnInfo.SpawnID == 117014) then	this:SetTimer(1170140, 10, true)	end --세타블 패트롤
	
	if (SpawnInfo.SpawnID == 11730200) then	this:SetTimer(1173020, 3000, true)	end --1번구역순찰하는민간인1
	if (SpawnInfo.SpawnID == 11730300) then	this:SetTimer(1173030, 2000, true)	end --1번구역순찰하는민간인2
	if (SpawnInfo.SpawnID == 11730400) then	this:SetTimer(1173040, 4000, true)	end --1번구역순찰하는민간인3
	
	if (SpawnInfo.SpawnID == 11734200) then	this:SetTimer(1173420, 2000, true)	end 	--중앙 순찰하는민간인1
	if (SpawnInfo.SpawnID == 11734300) then	this:SetTimer(1173430, 3000, true)	end 	--중앙 순찰하는민간인2
	
	
	--수질검사 이펙트
	if (SpawnInfo.NPCID == 117226) then	
		local cursed_water1 = this:GetNPC(117226)
		cursed_water1:GainBuff(111100)
	end
	
	--오염된물질 	
	if (SpawnInfo.NPCID == 117227) then	
		local cursed_water2 = this:GetNPC(117227)
		cursed_water2:GainBuff(111101)
	end
		
	--오염된보급품 	
	if (SpawnInfo.SpawnID == 117361) then			
		local cursed_supply1 = this:GetSpawnNPC(117361)		
		cursed_supply1:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117362) then			
		local cursed_supply2 = this:GetSpawnNPC(117362)		
		cursed_supply2:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117363) then			
		local cursed_supply3 = this:GetSpawnNPC(117363)		
		cursed_supply3:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117364) then			
		local cursed_supply4 = this:GetSpawnNPC(117364)		
		cursed_supply4:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117365) then			
		local cursed_supply5 = this:GetSpawnNPC(117365)		
		cursed_supply5:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117366) then			
		local cursed_supply6 = this:GetSpawnNPC(117366)		
		cursed_supply6:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117367) then			
		local cursed_supply7 = this:GetSpawnNPC(117367)		
		cursed_supply7:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117368) then			
		local cursed_supply8 = this:GetSpawnNPC(117368)		
		cursed_supply8:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117369) then			
		local cursed_supply9 = this:GetSpawnNPC(117369)		
		cursed_supply9:GainBuff(111102)		
	end
	
	if (SpawnInfo.SpawnID == 117370) then			
		local cursed_supply10 = this:GetSpawnNPC(117370)		
		cursed_supply10:GainBuff(111102)		
	end
	
end




function Field_117:OnTimer(TimerID) 		
	if (TimerID == 1) then
	
		this:SpawnByID(117226)
		this:SpawnByID(117227)	
		
	end 

	--1번구역순찰하는민간인1
	if (TimerID == 1173020) then
		local npc = this:GetSpawnNPC(11730200)		
		npc:Patrol({11730200,11730201,11730202,11730203,11730204,11730205,11730206,11730207,11730208,11730209,11730210,11730211,11730212,11730213,11730214,11730215,11730216,11730217,11730218,11730219,11730220,11730221,11730222}, PT_ONCE_RETURN)
	end
	
	--1번구역순찰하는민간인2
	if (TimerID == 1173030) then
		local npc = this:GetSpawnNPC(11730300)
		npc:Patrol({11730300,11730301,11730302,11730303,11730304,11730305,11730306,11730307,11730308,11730309,11730310,11730311,11730312,11730313,11730314,11730315}, PT_ONCE_RETURN)
	end
	
	--1번구역순찰하는민간인3
	if (TimerID == 1173040) then
		local npc = this:GetSpawnNPC(11730400)		
		npc:Patrol({11730400,11730401,11730402,11730403,11730404,11730405,11730406,11730407,11730408,11730409,11730410,11730411,11730412,11730413,11730414,11730415,11730416,11730417,11730418,11730419,11730420,11730421,11730422}, PT_ONCE_RETURN)
	end
	
	
	--중앙 순찰하는민간인1
	if (TimerID == 1173420) then
		local npc = this:GetSpawnNPC(11734200)		
		npc:Patrol({11734200,11734201,11734202,11734203,11734204}, PT_ONCE)
	end
	
	--중앙 순찰하는민간인2
	if (TimerID == 1173430) then
		local npc = this:GetSpawnNPC(11734300)		
		npc:Patrol({11734300,11734301,11734302,11734303,11734304,11734305,11734306}, PT_ONCE)
	end
	
	
	--세타블 패트롤
	if (TimerID == 1170140) then
		local npc = this:GetSpawnNPC(1170140)		
		npc:Patrol({11701400,11701401,11701402,11701403,11701404,11701405,11701406,11701407,11701408,11701409,11701410,11701411,11701412}, PT_ONCE)
	end
	
		
	--수질오염 퀘스트
	if (TimerID == 117046) then		
		local cursed_water1 = this:GetSpawnNPC(117226)		
		if (cursed_water1:CheckBuff(111100) == false) then			
			cursed_water1:GainBuff(111100)			
		end	
	end
	
	--오염에 노출된 리츠 퀘스트
	if (TimerID == 117047) then		
		local cursed_water2 = this:GetSpawnNPC(117227)		
		if (cursed_water2:CheckBuff(111101) == false) then			
			cursed_water2:GainBuff(111101)			
		end	
	end
	
	--오염물질을 제거하라 퀘스트	
	if (TimerID == 117048) then	
		local cursed_supply1 = this:GetSpawnNPC(117361)
		local cursed_supply2 = this:GetSpawnNPC(117362)
		local cursed_supply3 = this:GetSpawnNPC(117363)
		local cursed_supply4 = this:GetSpawnNPC(117364)
		local cursed_supply5 = this:GetSpawnNPC(117365)
		local cursed_supply6 = this:GetSpawnNPC(117366)
		local cursed_supply7 = this:GetSpawnNPC(117367)
		local cursed_supply8 = this:GetSpawnNPC(117368)
		local cursed_supply9 = this:GetSpawnNPC(117369)
		local cursed_supply10 = this:GetSpawnNPC(117370)
				
		
		if (cursed_supply1:CheckBuff(111103) == true) then			
			cursed_supply1:RemoveBuff(111103)
			this:DespawnByID(117361,true)
		end
		
		if (cursed_supply2:CheckBuff(111103) == true) then
			cursed_supply2:RemoveBuff(111103)
			this:DespawnByID(117362,true)
		end
		
		if (cursed_supply3:CheckBuff(111103) == true) then
			cursed_supply3:RemoveBuff(111103)
			this:DespawnByID(117363,true)
		end
		
		if (cursed_supply4:CheckBuff(111103) == true) then
			cursed_supply4:RemoveBuff(111103)
			this:DespawnByID(117364,true)
		end
		
		if (cursed_supply5:CheckBuff(111103) == true) then
			cursed_supply5:RemoveBuff(111103)
			this:DespawnByID(117365,true)
		end
		
		if (cursed_supply6:CheckBuff(111103) == true) then
			cursed_supply6:RemoveBuff(111103)
			this:DespawnByID(117366,true)
		end
		
		if (cursed_supply7:CheckBuff(111103) == true) then
			cursed_supply7:RemoveBuff(111103)
			this:DespawnByID(117367,true)
		end
		
		if (cursed_supply8:CheckBuff(111103) == true) then
			cursed_supply8:RemoveBuff(111103)
			this:DespawnByID(117368,true)
		end
		
		if (cursed_supply9:CheckBuff(111103) == true) then
			cursed_supply9:RemoveBuff(111103)
			this:DespawnByID(117369,true)
		end
		
		if (cursed_supply10:CheckBuff(111103) == true) then
			cursed_supply10:RemoveBuff(111103)
			this:DespawnByID(117370,true)
		end
		
		
	end	
end

--오염물질을 제거하라



-- 수질검사1
function Field_117:OnSensorTalent_117226(Actor, TalentID) 
	local cursed_water1 = this:GetSpawnNPC(117226)		
	
	if (AsPlayer(Actor):CheckCondition(1170461) == true ) and (TalentID == 140707) then		
		AsPlayer(Actor):UpdateQuestVar(117046, 1)			
		--this:DisableSensor(117226)
		cursed_water1:RemoveBuff(111100)		
		this:SetTimer(117046, 10, false)		
	end	
end

-- 오염에 노출된 리츠
function Field_117:OnSensorTalent_117227(Actor, TalentID) 	
	local cursed_water2 = this:GetSpawnNPC(117227)		
	
	if (AsPlayer(Actor):CheckCondition(1170471) == true ) and (TalentID == 140706) then	
		AsPlayer(Actor):UpdateQuestVar(117047, 2)			
		--this:DisableSensor(117228)
		cursed_water2:RemoveBuff(111101)		
		this:SetTimer(117047, 10, false)	
	end	
end


--여인의 시체
function Field_117:OnSensorEnter_117219(Actor)
	if (AsPlayer(Actor):CheckCondition(1170171) == true ) and (AsPlayer(Actor):GetQuestVar(117017) ~= 1) then
	
		AsPlayer(Actor):UpdateQuestVar(117017, 1)			
	
	end	
end

--수상한 시체

-- function Field_117:OnSensorEnter_117228(Actor)	
	-- if (AsPlayer(Actor):CheckCondition(1170051) == true ) and (AsPlayer(Actor):GetQuestVar(117005) ~= 1) then		
		-- AsPlayer(Actor):UpdateQuestVar(117005, 1)				
	-- end
-- end


-- Portal to Ritz Sewer - for test
function Field_117:OnSensorEnter_1(Actor)
	-- Go to "Riode"
	AsPlayer(Actor):GateToMarker(101, 5);
end



--[[
function Field_117:OnSensorEnter_1546(Actor)	
	
	--수질검사
	if (AsPlayer(Actor):CheckCondition(1170461) == true ) and (AsPlayer(Actor):GetQuestVar(117046) ~= 1) then
		--랜덤하게 하나만 나오기 하면 됨.
		
		local dice = math.random(1,2)
		
		local cursed_water1 = this:GetSpawnNPC(7)
		local cursed_water2 = this:GetSpawnNPC(8)
		
		if (dice == 1) then
			GLog("1")
			cursed_water1:GainBuff(40904)
		end

		if (dice == 2 ) then
			GLog("2")
			cursed_water2:GainBuff(40904)
		end
	end	
	
	--오염에 노출된 리츠
	if (AsPlayer(Actor):CheckCondition(1170471) == true ) and (AsPlayer(Actor):GetQuestVar(117047) ~= 2) then
		this:SpawnByID(15147)		
	end
end

]]--

