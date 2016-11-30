function Field_119:OnTimer(TimerID) 		
	--지친 병사들
	if (TimerID == 119002) then		
		local InjuredSoldier0 = this:GetSpawnNPC(140)
		local InjuredSoldier1 = this:GetSpawnNPC(141)
		local InjuredSoldier2 = this:GetSpawnNPC(142)
		local InjuredSoldier3 = this:GetSpawnNPC(143)
		local InjuredSoldier4 = this:GetSpawnNPC(144)
		local InjuredSoldier5 = this:GetSpawnNPC(145)
		local InjuredSoldier6 = this:GetSpawnNPC(146)
		local InjuredSoldier7 = this:GetSpawnNPC(147)
		
		if  InjuredSoldier0:CheckBuff(111401) == true then
			InjuredSoldier0:EnableInteraction()			
		end
		
		if  InjuredSoldier1:CheckBuff(111401) == true then
			InjuredSoldier1:EnableInteraction()			
		end
		
		if  InjuredSoldier2:CheckBuff(111401) == true then
			InjuredSoldier2:EnableInteraction()			
		end
		
		if  InjuredSoldier3:CheckBuff(111401) == true then
			InjuredSoldier3:EnableInteraction()			
		end
		
		if  InjuredSoldier4:CheckBuff(111401) == true then
			InjuredSoldier4:EnableInteraction()			
		end
		
		if  InjuredSoldier5:CheckBuff(111401) == true then
			InjuredSoldier5:EnableInteraction()			
		end
		
		if  InjuredSoldier6:CheckBuff(111401) == true then
			InjuredSoldier6:EnableInteraction()			
		end		
		
		if  InjuredSoldier0:CheckBuff(111401) == true then
			InjuredSoldier7:EnableInteraction()			
		end		
	end
	
	-- if (TimerID == 118252) then						
		-- GLog("Despawn 118252")
		
		-- this:Despawn(118252,false)
	-- end
	
	-- if (TimerID == 118253) then						
		-- GLog("Despawn 118253")
		-- this:DespawnNow(118253,false)
	-- end
		
		
	
	-- if (TimerID == 119017) then		
		-- local flyingmossTable1 = {90030000,90030001,90030002,90030003,90030004,90030005,90030006,90030007,90030008,90030009,90030010,90030011,90030012,90030013,90030014}
		-- local flyingmossTable2 = {90030015,90030016,90030017,90030018,90030019,90030020,90030021,90030022,90030023,90030024,90030025,90030026,90030027,90030028}
		
		-- for i = 1, 15 do		
			-- for j = 16, 29 do			
				
				-- local flyingmoss1 = this:GetSpawnNPC(flyingmossTable1[i-1])						
				-- local flyingmoss2 = this:GetSpawnNPC(flyingmossTable2[j])

				-- if  flyingmoss1:CheckBuff(111403) == true then
					-- this:DespawnbyID(flyingmoss1, true)
				-- end
				
				-- if  flyingmoss2:CheckBuff(111403) == true then
					-- this:DespawnbyID(flyingmoss2, true)
				-- end
			-- end			
		-- end		
	-- end	
end

-- 119006 일어나세요 용사여
-- function Field_119:OnSensorTalent_11800400(Actor, TalentID) 	
	-- if (AsPlayer(Actor):CheckCondition(1190061) == true ) and (TalentID == 140802) then	
		-- AsPlayer(Actor):UpdateQuestVar(119006,1)			
	-- end
-- end

-- 불타는 부유체에 이펙트 심어주기
function Field_119:OnDie(DespawnInfo)		
	-- GLog("Ondie")
	if DespawnInfo.NPCID == 119003 then				
		GLog("Spawn 118252")		 
		-- pos좌표를 기억해주는 NPC를 생성		
		local NpcPos = Math_GetDistancePoint( DespawnInfo.NPC:GetPos(), DespawnInfo.NPC:GetDir(), 0 )
		this:Spawn(118252,NpcPos)		
		
		-- local mossEffector = this:Spawn(118252,NpcPos)		
		-- GLog("Timer")		 
	end	
	
	-- pos을 기억한 NPC가 죽으면서 또 다른 NPC를 생성
	-- if DespawnInfo.NPCID == 118252 then
		-- GLog("Despawn 118252 info")		
		-- local NpcPos = Math_GetDistancePoint( DespawnInfo.NPC:GetPos(), DespawnInfo.NPC:GetDir(), 0 )
		-- this:Spawn(118253,NpcPos)					
		-- DespawnInfo.NPC:SetDecayTime(0)
	-- end
	
	-- if DespawnInfo.NPCID == 118253 then						
		-- GLog("Despawn 118253 info")		
		-- DespawnInfo.NPC:SetDecayTime(0)
	-- end	
	-- end
end

function Field_119:OnSpawn(SpawnInfo)			
	--Pos 좌표를 기억해주는 NPC에 이펙트를 붙인다	
	-- if SpawnInfo.NPCID == 118253 then			
		-- GLog("Spawn 118253")			
		-- SpawnInfo.NPC:GainBuff(111403)
		-- gametime 5초 뒤에 타이머 발동
		-- this:SetTimer(118253, 5, false)
	-- end
	if SpawnInfo.NPCID == 119003 then				
		SpawnInfo.NPC:SetDecayTime(20)		
	end
	
	if SpawnInfo.NPCID == 118252 then		
		SpawnInfo.NPC:SetDecayTime(18)
		GLog("GainBuff_S")
		SpawnInfo.NPC:GainBuff(111406)
		GLog("GainBuff_E")
		--인스턴스로 생성된 NPC들을 처리할 수 없다		-- 전역으로 
		-- this:SetTimer(118252, 30, false)
	end
end
