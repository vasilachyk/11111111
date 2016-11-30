-- 코웬 늪지대

function Field_103:OnCreate()
	this:SetTimer(1, 300, false)
end

function Field_103:OnTimer(TimerID)
-- quest pvp 시작
	if (TimerID == 1) then	
		local QuestPVP = this:GetQuestPVP()
		QuestPVP:BeginEvent(103)
		this:SetTimer(17, 1800, false)--2400
		
	elseif (TimerID == 2) then -- 1거점 아케론 점령, 아케론 마법사
		this:SpawnByID(54)
		this:SpawnByID(55)
	elseif (TimerID == 3) then -- 1거점 토가트 점령, 토가트 마법사
		this:SpawnByID(56)
		this:SpawnByID(57)
	elseif (TimerID == 4) then -- 1거점
		local thisNpc = this:GetSpawnNPC(36)
		thisNpc:GainBuff(501052)
		
	elseif (TimerID == 5) then -- 2거점 아케론 점령, 아케론 마법사
		this:SpawnByID(67)
		this:SpawnByID(68)
	elseif (TimerID == 6) then -- 2거점 토가트 점령, 토가트 마법사
		this:SpawnByID(69)
		this:SpawnByID(70)
	elseif (TimerID == 7) then -- 2거점
		local thisNpc = this:GetSpawnNPC(58)
		thisNpc:GainBuff(501052)
		
	elseif (TimerID == 8) then -- 3거점 아케론 점령, 아케론 마법사
		this:SpawnByID(80)
		this:SpawnByID(81)
	elseif (TimerID == 9) then -- 3거점 토가트 점령, 토가트 마법사
		this:SpawnByID(82)
		this:SpawnByID(83)
	elseif (TimerID == 10) then -- 3거점
		local thisNpc = this:GetSpawnNPC(71)
		thisNpc:GainBuff(501052)
	
	elseif (TimerID == 11) then -- 4거점 아케론 점령, 아케론 마법사
		this:SpawnByID(93)
		this:SpawnByID(94)
	elseif (TimerID == 12) then -- 4거점 토가트 점령, 토가트 마법사
		this:SpawnByID(95)
		this:SpawnByID(96)
	elseif (TimerID == 13) then -- 4거점
		local thisNpc = this:GetSpawnNPC(84)
		thisNpc:GainBuff(501052)	
		
	elseif (TimerID == 14) then -- 5거점 아케론 점령, 아케론 마법사
		this:SpawnByID(143)
		this:SpawnByID(144)
	elseif (TimerID == 15) then -- 5거점 토가트 점령, 토가트 마법사
		this:SpawnByID(145)
		this:SpawnByID(146)
	elseif (TimerID == 16) then -- 5거점
		local thisNpc = this:GetSpawnNPC(147)
		thisNpc:GainBuff(501052)
		
	elseif (TimerID == 17) then -- Qpvp 종료
	-- 각 거점의 모드를 체크하여 알아낸다!
		
		local aTeamBaseCount = 0
		local tTeamBaseCount = 0
		
		local base1 = this:GetSpawnNPC(36)
		local base2 = this:GetSpawnNPC(58)
		local base3 = this:GetSpawnNPC(71)
		local base4 = this:GetSpawnNPC(84)
		local base5 = this:GetSpawnNPC(147)
		
		local base1_Mode = base1:GetMode()
		local base2_Mode = base2:GetMode()
		local base3_Mode = base3:GetMode()
		local base4_Mode = base4:GetMode()
		local base5_Mode = base5:GetMode()
		
		local QuestPVP = this:GetQuestPVP()
		
		local t = {base1_Mode, base2_Mode, base3_Mode, base4_Mode, base5_Mode}
		for i=1,  5, 1 do
			if t[i] == 1 then
				aTeamBaseCount = aTeamBaseCount+1
			elseif t[i] == 2 then
				tTeamBaseCount = tTeamBaseCount+1
			end
		end
		
		for i=2,  16, 1 do
			this:KillTimer(i)
		end
		
		
		if aTeamBaseCount < tTeamBaseCount then
			QuestPVP:EndEvent(103, 2)
		elseif aTeamBaseCount > tTeamBaseCount then
			QuestPVP:EndEvent(103, 1)
		else
			-- 비겼다 알림처리
			--QuestPVP:EndEvent(103, 3)
			-- 망할 qpevent.xml에서 winnerteam을 2개까지만 설정 할 수 있다. 비겼을 때 처리가 없어!
			-- this:Narration("비겼으나 비겼을 때 처리가 없으므로 아케론 부족 승리 -ㅅ-")
			QuestPVP:EndEvent(103, 1)
		end
		this:SetTimer(1, 120, false)--2400
	end
end

function Field_103:OnEndCutscene(Player, CutsceneID)
	if (CutsceneID == 1030210) then
		Player:GainBuff(110058)
		local Chieftain = this:GetSpawnNPC(103251)
		Chieftain:Say("{ani=sleep}이런, 이 자도 환각 증세를 보이고 있군!")
		Chieftain:Say("{ani=atk_r}서둘러 치료 준비를 해라!")		
	end
end

function Field_103:OnSensorEnter_103004(Actor) -- 103004 구원... 봉봉의 포로(110059)버프 지우기 센서
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckBuff(110059) == true) then 
			AsPlayer(Actor):RemoveBuff(110059)
		end
		if (AsPlayer(Actor):CheckCondition(1030044) == true) then -- 완료 전, 나가기를 눌러 나갔다면 퀘스트를 실패시키고 포로 버프를 지운다.
			AsPlayer(Actor):RuinQuest(103004)			
		end
	end
end
function Field_103:OnSensorEnter_103021(Actor) -- 103021 당신이 잠든 사이... 검은 늪의 환각(110063)버프 지우기 센서
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckBuff(110063) == true) then 
			AsPlayer(Actor):RemoveBuff(110063)
			if (AsPlayer(Actor):CheckCondition(1030211) == true) then -- 완료 전, 나가기를 눌러 나갔다면 퀘스트를 실패시키고 환각 버프를 지운다.
				AsPlayer(Actor):RuinQuest(103021)
			end			
		end
	end
end

function Field_103:OnSensorEnter_1030071(Actor) -- 북쪽 탐침 설치구역 : 탐침 사용 가능해짐
	if (Actor:IsPlayer() == true) then	
		if (AsPlayer(Actor):CheckCondition(1030071) == true) then
			AsPlayer(Actor):Tip("이 주변에 탐침을 설치하십시오.")
			AsPlayer(Actor):UpdateQuestVar(103007, 2)
		end
	end
end
function Field_103:OnSensorEnter_1030072(Actor) -- 북쪽 탐침 설치구역 : 탐침 사용 가능해짐
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1030072) == true) then
			AsPlayer(Actor):Tip("이 주변에 탐침을 설치하십시오.")
			AsPlayer(Actor):UpdateQuestVar(103007, 3)
		end
	end
end

function Field_103:OnSensorLeave_1030071(Actor) -- 북쪽 탐침 설치구역에서 나가면 탐침 사용 불가능해짐
	if (Actor:IsPlayer() == true) then	
		--Actor:Narration("1로 변경")
		AsPlayer(Actor):UpdateQuestVar(103007, 1)
	end
end
function Field_103:OnSensorLeave_1030072(Actor) -- 북쪽 탐침 설치구역에서 나가면 탐침 사용 불가능해짐
	if (Actor:IsPlayer() == true) then	
		--Actor:Narration("1로 변경")
		AsPlayer(Actor):UpdateQuestVar(103007, 1)
	end
end

function Field_103:OnSensorTalent_1030071(Actor, TalentID)
	if (TalentID == 140502) then
		Actor:Narration("탐침을 설치했습니다.")
		AsPlayer(Actor):UpdateQuestVar(103007, 4)
	end
end
function Field_103:OnSensorTalent_1030072(Actor, TalentID)
	if (TalentID == 140502) then
		Actor:Narration("탐침을 설치했습니다.")
		AsPlayer(Actor):UpdateQuestVar(103007, 5)
	end
end

function Field_103:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 1031041) or (SpawnInfo.SpawnID == 1031042) or (SpawnInfo.SpawnID == 1031043) or (SpawnInfo.SpawnID == 1031044)then -- 아케론 정찰병
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:Patrol({103028}, PT_ONCE)
	end	
	if (SpawnInfo.SpawnID == 1031541) or (SpawnInfo.SpawnID == 1031542) or (SpawnInfo.SpawnID == 1031543) or (SpawnInfo.SpawnID == 1031544)then -- 토가트 정찰병
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:Patrol({103028}, PT_ONCE)
	end		
	if (SpawnInfo.NPCID == 103128) then -- 103128 재빠른 어인 스폰 패트롤
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:Patrol({101,102,103,104,105,106,107,108}, PT_LOOP)
	end
	if (SpawnInfo.NPCID == 103513) then -- 103002 흑연곷 채집 끝나면 나오는 봉봉
		SpawnInfo.NPC:SetAlwaysRun(true)		
		SpawnInfo.NPC:UseTalentSelf(210351301)
		SpawnInfo.NPC:Say("인간! 또 다른 인간이다!")
		SpawnInfo.NPC:Say("어서 부족에 알려야지!")
		--SpawnInfo.NPC:FleeFromEnemy(2)
		--SpawnInfo.NPC:MoveRandom(SpawnInfo.NPC, 500)
		SpawnInfo.NPC:ScriptSelf("Field_103_SelfDespawn")	
	end	
	
	
	-- -- quest pvp 거점 Mark 등록
	-- if (SpawnInfo.NPCID == 103603) then		
		-- QuestPVP = this:GetQuestPVP()
		-- QuestPVP:EnableMarkHP(103603)
		  --Base = this:GetNPC(103603)
		  --Base:EnableMarkPos(103603)
	-- elseif (SpawnInfo.NPCID == 103604) then		
		-- QuestPVP = this:GetQuestPVP()
		-- QuestPVP:EnableMarkHP(103604)
		  --Base = this:GetNPC(103604)
		  --Base:EnableMarkPos(103604)
	-- end	
end

function Field_103_SelfDespawn(Self)
	Self:Despawn(false)
end



-- -- quest pvp 수호자 죽었을 때 진영에 디버프 걸기
-- function Field_103:OnDie(DespawnInfo)

	-- if (DespawnInfo.SpawnID == 103603) then
		-- QuestPVP = this:GetQuestPVP();
		-- QuestPVP:DisableMarkPos(103603);
	-- elseif (DespawnInfo.SpawnID == 103604) then
		-- QuestPVP = this:GetQuestPVP();
		-- QuestPVP:DisableMarkPos(103604);
	-- end

	-- if (DespawnInfo.SpawnID == 103613) then
		-- -- 아케론 부족 수호자 죽으면 거점에 디버프 걸림
		-- local Base = this:GetNPC(103603)
		-- Base:GainBuff(501192)
	-- elseif (DespawnInfo.SpawnID == 103614) then
		-- -- 토가트 부족 수호자 죽으면 거점에 디버프 걸림
		-- local Base = this:GetNPC(103604)
		-- Base:GainBuff(501192)
	-- elseif (DespawnInfo.SpawnID == 35) or (DespawnInfo.SpawnID == 36) then
		-- -- 아케론 부족 중간 거점이 죽으면 거점 보호막 삭제
		-- local Base = this:GetNPC(103603)
		-- Base:RemoveBuff(501206)
	-- elseif (DespawnInfo.SpawnID == 37) or (DespawnInfo.SpawnID == 38) then
		-- -- 토가트 부족 중간 거점이 죽으면 거점 보호막 삭제
		-- local Base = this:GetNPC(103604)
		-- Base:RemoveBuff(501206)
	-- elseif (DespawnInfo.SpawnID == 103603) or (DespawnInfo.SpawnID == 103604) then
		-- -- quest pvp가 끝나고 나면 30분 뒤에 다시 시작한다.
		-- this:SetTimer(1, 15, false) -- 1800
	-- end
-- end


-- 인터랙션을 이용한 거점 점령
function Field_103:OnSensorTalent_4(Actor, TalentID)
-- 1거점
	
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() ~= 1) and (AsPlayer(Actor):GetQPVPTeam() ~= 2) then
		return
	end
	
	local thisNpc = this:GetSpawnNPC(36)
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 1 ) then
		thisNpc:UseTalentSelf(140543)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(3)
		this:KillTimer(4)
		
		Actor:Narration("$$KOWEN_QuestPVP_AhKheron_capture_1")
		
		this:DespawnByID(50)
		this:DespawnByID(51)
		this:DespawnByID(52)
		this:DespawnByID(53)
		this:DespawnByID(56)
		this:DespawnByID(57)
		this:SpawnByID(46)
		this:SpawnByID(47)
		this:SpawnByID(48)
		this:SpawnByID(49)
		
		-- 일정 시간이 지나면 지킴이 강화 // 마법사
		this:SetTimer(2, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 540
		this:SetTimer(4, 540, false)
		
	elseif (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 2 ) then
		thisNpc:UseTalentSelf(140544)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(2)
		this:KillTimer(4)
		
		Actor:Narration("$$KOWEN_QuestPVP_ToGat_capture_1")
		
		this:DespawnByID(46)
		this:DespawnByID(47)
		this:DespawnByID(48)
		this:DespawnByID(49)
		this:DespawnByID(54)
		this:DespawnByID(55)
		this:SpawnByID(50)
		this:SpawnByID(51)
		this:SpawnByID(52)
		this:SpawnByID(53)
		
		-- 일정 시간이 지나면 지킴이 추가 // 마법사
		this:SetTimer(3, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(4, 540, false)
		
	end
end

function Field_103:OnSensorTalent_5(Actor, TalentID)
-- 2거점
	
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() ~= 1) and (AsPlayer(Actor):GetQPVPTeam() ~= 2) then
		return
	end
	
	local thisNpc = this:GetSpawnNPC(58)
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 1 ) then
		thisNpc:UseTalentSelf(140543)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(6)
		this:KillTimer(7)
		
		Actor:Narration("$$KOWEN_QuestPVP_AhKheron_capture_2")
		
		this:DespawnByID(63)
		this:DespawnByID(64)
		this:DespawnByID(65)
		this:DespawnByID(66)
		this:DespawnByID(69)
		this:DespawnByID(70)
		this:SpawnByID(59)
		this:SpawnByID(60)
		this:SpawnByID(61)
		this:SpawnByID(62)
		
		-- 일정 시간이 지나면 지킴이 강화 // 마법사
		this:SetTimer(5, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(7, 540, false)
		
	elseif (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 2 ) then
		thisNpc:UseTalentSelf(140544)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(5)
		this:KillTimer(7)
		
		Actor:Narration("$$KOWEN_QuestPVP_ToGat_capture_2")
		
		this:DespawnByID(59)
		this:DespawnByID(60)
		this:DespawnByID(61)
		this:DespawnByID(62)
		this:DespawnByID(67)
		this:DespawnByID(68)
		this:SpawnByID(63)
		this:SpawnByID(64)
		this:SpawnByID(65)
		this:SpawnByID(66)
		
		-- 일정 시간이 지나면 지킴이 추가 // 마법사
		this:SetTimer(6, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(7, 540, false)
		
	end
end

function Field_103:OnSensorTalent_7(Actor, TalentID)
-- 3거점
	
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() ~= 1) and (AsPlayer(Actor):GetQPVPTeam() ~= 2) then
		return
	end
	
	local thisNpc = this:GetSpawnNPC(71)
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 1 ) then
		thisNpc:UseTalentSelf(140543)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(9)
		this:KillTimer(10)
		
		Actor:Narration("$$KOWEN_QuestPVP_AhKheron_capture_3")
		
		this:DespawnByID(76)
		this:DespawnByID(77)
		this:DespawnByID(78)
		this:DespawnByID(79)
		this:DespawnByID(82)
		this:DespawnByID(83)
		this:SpawnByID(72)
		this:SpawnByID(73)
		this:SpawnByID(74)
		this:SpawnByID(75)
		
		-- 일정 시간이 지나면 지킴이 강화 // 마법사
		this:SetTimer(8, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(10, 540, false)
		
	elseif (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 2 ) then
		thisNpc:UseTalentSelf(140544)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(8)
		this:KillTimer(10)
		
		Actor:Narration("$$KOWEN_QuestPVP_ToGat_capture_3")
		
		this:DespawnByID(72)
		this:DespawnByID(73)
		this:DespawnByID(74)
		this:DespawnByID(75)
		this:DespawnByID(80)
		this:DespawnByID(81)
		this:SpawnByID(76)
		this:SpawnByID(77)
		this:SpawnByID(78)
		this:SpawnByID(79)
		
		-- 일정 시간이 지나면 지킴이 추가 // 마법사
		this:SetTimer(9, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(10, 540, false)
		
	end
end

function Field_103:OnSensorTalent_8(Actor, TalentID)
-- 4거점
	
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() ~= 1) and (AsPlayer(Actor):GetQPVPTeam() ~= 2) then
		return
	end
	
	local thisNpc = this:GetSpawnNPC(84)
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 1 ) then
		thisNpc:UseTalentSelf(140543)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(12)
		this:KillTimer(13)
		
		Actor:Narration("$$KOWEN_QuestPVP_AhKheron_capture_4")
		
		this:DespawnByID(89)
		this:DespawnByID(90)
		this:DespawnByID(91)
		this:DespawnByID(92)
		this:DespawnByID(95)
		this:DespawnByID(96)
		this:SpawnByID(85)
		this:SpawnByID(86)
		this:SpawnByID(87)
		this:SpawnByID(88)
		
		-- 일정 시간이 지나면 지킴이 강화 // 마법사
		this:SetTimer(11, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(13, 540, false)
		
	elseif (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 2 ) then
		thisNpc:UseTalentSelf(140544)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(11)
		this:KillTimer(13)
		
		Actor:Narration("$$KOWEN_QuestPVP_ToGat_capture_4")
		
		this:DespawnByID(85)
		this:DespawnByID(86)
		this:DespawnByID(87)
		this:DespawnByID(88)
		this:DespawnByID(93)
		this:DespawnByID(94)
		this:SpawnByID(89)
		this:SpawnByID(90)
		this:SpawnByID(91)
		this:SpawnByID(92)
		
		-- 일정 시간이 지나면 지킴이 추가 // 마법사
		this:SetTimer(12, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(13, 540, false)
		
	end
end

function Field_103:OnSensorTalent_9(Actor, TalentID)
-- 5거점
	
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() ~= 1) and (AsPlayer(Actor):GetQPVPTeam() ~= 2) then
		return
	end
	
	local thisNpc = this:GetSpawnNPC(147)
	if (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 1 ) then
		thisNpc:UseTalentSelf(140543)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(15)
		this:KillTimer(16)
		
		Actor:Narration("$$KOWEN_QuestPVP_AhKheron_capture_5")
		
		this:DespawnByID(139)
		this:DespawnByID(140)
		this:DespawnByID(141)
		this:DespawnByID(142)
		this:DespawnByID(145)
		this:DespawnByID(146)
		this:SpawnByID(97)
		this:SpawnByID(98)
		this:SpawnByID(99)
		this:SpawnByID(138)
		
		-- 일정 시간이 지나면 지킴이 강화 // 마법사
		this:SetTimer(14, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(16, 540, false)
		
	elseif (TalentID == 140541) and (AsPlayer(Actor):GetQPVPTeam() == 2 ) then
		thisNpc:UseTalentSelf(140544)
		
		-- 상대편 부족이 점령했을 때 발동된 타이머 삭제
		this:KillTimer(14)
		this:KillTimer(16)
		
		Actor:Narration("$$KOWEN_QuestPVP_ToGat_capture_5")
		
		this:DespawnByID(97)
		this:DespawnByID(98)
		this:DespawnByID(99)
		this:DespawnByID(138)
		this:DespawnByID(143)
		this:DespawnByID(144)
		this:SpawnByID(139)
		this:SpawnByID(140)
		this:SpawnByID(141)
		this:SpawnByID(142)
		
		-- 일정 시간이 지나면 지킴이 추가 // 마법사
		this:SetTimer(15, 300, false)
		
		-- 일정 시간이 지나면 범위형 강화버프 // 420
		this:SetTimer(16, 540, false)
		
	end
end