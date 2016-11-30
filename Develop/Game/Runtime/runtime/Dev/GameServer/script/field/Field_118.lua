--[[
function Field_118:OnEndCutscene(Player, CutsceneID)
	if (CutsceneID == 118001) then
		Player:GateToTrial(1180080, true)
	end
end
--]]


function Field_118:OnTimer(TimerID) 
	
	--118002 팔을 걷으세요 
	if (TimerID == 118002) then
		
		local tiredsoldier0 = Field:GetSpawnNPC(11821000)
		local tiredsoldier1 = Field:GetSpawnNPC(11821001)
		local tiredsoldier2 = Field:GetSpawnNPC(11821002)
		local tiredsoldier3 = Field:GetSpawnNPC(11821003)
		local tiredsoldier4 = Field:GetSpawnNPC(11821004)
		local tiredsoldier5 = Field:GetSpawnNPC(11821005)
		local tiredsoldier6 = Field:GetSpawnNPC(11821006)
		local tiredsoldier7 = Field:GetSpawnNPC(11821007)
		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end				
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end		
		if tiredsoldier0:CheckBuff(111400) == false then
			tiredsoldier0:EnableInteraction()			
		end
	end
	
	--창공의 괴음
	
	if (TimerID == 118008) then			
	end
	
	
	-- if (TimerID == 118009) then	
		
	-- end
		-- 지쳐 있는 병사
		-- local injuredsoldier0 = this:GetSpawnNPC(140)
		-- local injuredsoldier1 = this:GetSpawnNPC(141)
		-- local injuredsoldier2 = this:GetSpawnNPC(142)
		-- local injuredsoldier3 = this:GetSpawnNPC(143)
		-- local injuredsoldier4 = this:GetSpawnNPC(144)
		-- local injuredsoldier5 = this:GetSpawnNPC(145)
		-- local injuredsoldier6 = this:GetSpawnNPC(146)
		-- local injuredsoldier7 = this:GetSpawnNPC(147)
		
		
		-- if (injuredsoldier0:CheckBuff(111401) == false) then
			-- injuredsoldier0:EnableInteraction()			
			
		-- end		
		
		-- if (injuredsoldier1:CheckBuff(111401) == false) then
			-- injuredsoldier1:EnableInteraction()						
			
		-- end
		
		-- if (injuredsoldier2:CheckBuff(111401) == false) then
			-- injuredsoldier2:EnableInteraction()		
			
		-- end
		
		-- if (injuredsoldier3:CheckBuff(111401) == false) then
			-- injuredsoldier3:EnableInteraction()		
			
		-- end
		
		-- if (injuredsoldier4:CheckBuff(111401) == false) then
			-- injuredsoldier4:EnableInteraction()			
			
		-- end
		
		-- if (injuredsoldier5:CheckBuff(111401) == false) then
			-- injuredsoldier5:EnableInteraction()	
			
		-- end
		
		-- if (injuredsoldier6:CheckBuff(111401) == false) then
			-- injuredsoldier6:EnableInteraction()			
			
		-- end
		
		-- if (injuredsoldier7:CheckBuff(111401) == false) then
			-- injuredsoldier7:EnableInteraction()			
			
		-- end
	-- end
end

-- 퀘스트 변수를 안 쓰는 것으로 변경
-- function Field_118:OnSensorEnter_118008(Actor)	
	-- -- if (AsPlayer(Actor):CheckCondition(1180082) == true) or (AsPlayer(Actor):CheckCondition(1180083) == true) then
		-- -- if (AsPlayer(Actor):GetQuestVar(118008) == 1) then
			-- -- AsPlayer(Actor):UpdateQuestVar(118008, 2)
			-- --AsPlayer(Actor):Cutscene(118001) 코웬 늪지대 오픈 시 대체
			-- -- AsPlayer(Actor):GateToTrial(1180080, true)
		-- -- end
	-- -- end

	-- -- if (AsPlayer(Actor):CheckCondition(1180081) == true) then
		-- -- local Player = AsPlayer(Actor)
		-- -- Player:Tip("$$Field_118_001")						--Player:Tip("소음을 제거하는 지팡이를 사용하세요.")						
	-- -- -- end
	
	-- -- if (AsPlayer(Actor):CheckCondition(1180081) == true) and  (AsPlayer(Actor):GetQuestVar(118008) ~= 1) then						
		-- -- --더미 NPC에 연결하여						
		-- -- --이펙트를 뿌려준다		
		-- -- -- GLog("UseTalent")				
		
		-- -- local Player = AsPlayer(Actor)
		-- -- Player:UpdateQuestVar(118008, 1)				
		
		-- -- -- GLog("DoneUseTalent")
		-- -- -- this:SetTimer(118008, 10, false)			
	-- -- end 

	-- -- --반복퀘스트용
	-- -- if (AsPlayer(Actor):CheckCondition(1180111) == true) and  (AsPlayer(Actor):GetQuestVar(118011) ~= 1) then
		-- -- local Player = AsPlayer(Actor)
		-- -- Player:UpdateQuestVar(118011, 1)				
	-- -- end 
-- end

-- function Field_118:OnCreate()
	-- -- local effector = this:GetNPC(118250)
	-- -- effector:UseTalentSelf(140800)		
-- end

--[[
function Field_118:OnSensorTalent_118008(Actor, TalentID) 
	--보상받기가 가능해질 때 탤런트를 쓰면 맵이동
	if (AsPlayer(Actor):CheckCondition(1180081) == true) and (TalentID == 140803 ) then					
		--컷씬이 있다면 컷씬이 나오는 이벤트 추가해야함		
		AsPlayer(Actor):GateToMarker(119, 11800800)
	end
end
--]]
--헤이든의 어려운임무완료조건 처리
function Field_118:OnSensorEnter_118201(Actor)	
	if (AsPlayer(Actor):CheckCondition(1180039) == true) then					
		AsPlayer(Actor):UpdateQuestVar(118003,1)		
	end
end