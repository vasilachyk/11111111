-- 아란바스 화산지대

function Field_8010:OnSensorEnter_116017(Actor) -- 묘지 : 기도문 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160171) == true) then
			AsPlayer(Actor):Tip("이곳에서 하프메인의 기도문을 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116017, 2)
		end
	end
end
function Field_8010:OnSensorLeave_116017(Actor) -- 묘지 : 멀어지면 기도문 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116017, 1)
	end
end
function Field_8010:OnSensorTalent_116017(Actor, TalentID) -- 기도문 사용시
	if (TalentID == 140552) then
		AsPlayer(Actor):UpdateQuestVar(116017, 3)
		if (this:GetNPCCount(116206) == 0) and (this:GetNPCCount(116504) == 0) then
			this:SpawnByID(116206, false)	
			this:SpawnByID(116504, false)
			local Rogue = this:GetSpawnNPC(116206)
			local Halfmain = this:GetSpawnNPC(116504)
			local Session = this:MakeSession("DrainRogue", {Rogue, Halfmain})			
		end
	end
end

function Field_8010:OnSensorEnter_116028(Actor) -- 온천 : 정령신주 재료 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160281) == true) then
			AsPlayer(Actor):Tip("이곳에서 정령신주 재료를 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116028, 2)
		end
	end
end
function Field_8010:OnSensorLeave_116028(Actor) -- 온천 : 멀어지면 정령신주 재료 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116028, 1)
	end
end
function Field_8010:OnSensorTalent_116028(Actor, TalentID) -- 온천 : 정령신주 재료 사용시
	if (TalentID == 140553) then
		AsPlayer(Actor):UpdateQuestVar(116028, 3)
		AsPlayer(Actor):Tip("정령신주가 완성되었습니다.")
		this:SpawnByID(116414, false)
	end
end

function Field_8010:OnSpawn(SpawnInfo) -- 정령신주 스폰시

	-- quest pvp 거점
	if (SpawnInfo.NPCID == 116603) then		
		QuestPVP = this:GetQuestPVP();
		QuestPVP:EnableMarkHP(116603);	
		Base = this:GetNPC(116603)
		Base:EnableMarkPos(116603)
	end	
	if (SpawnInfo.NPCID == 116604) then		
		QuestPVP = this:GetQuestPVP();
		QuestPVP:EnableMarkHP(116604);	
		Base = this:GetNPC(116604)
		Base:EnableMarkPos(116604)
	end	


	if (SpawnInfo.NPCID == 116414) then		
		SpawnInfo.NPC:GainBuff(110072)
	end		
	if (SpawnInfo.NPCID == 116416) then		
		SpawnInfo.NPC:GainBuff(110087)
	end			
	if (SpawnInfo.SpawnID == 1000) or (SpawnInfo.SpawnID == 1001) or (SpawnInfo.SpawnID == 1002) then		
		SpawnInfo.NPC:SetDecayTime(0)
		AsNPC(SpawnInfo.NPC):SetTimer(1, 60, false)
	end
	
	-- quest pvp 거점 수호자
	-- 수호자 생성시 거점에 걸린 디버프 삭제ㅋㅋ
	if (SpawnInfo.NPCID == 116613) then
		local Base = this:GetNPC(116603)
		if (Base:CheckBuff(501192) == true) then
			Base:RemoveBuff(501192)
		end
	elseif (SpawnInfo.NPCID == 116614) then
		local Base = this:GetNPC(116604)
		if (Base:CheckBuff(501192) == true) then
			Base:RemoveBuff(501192)
		end
	end
	
end

function Field_8010:OnSessionScene_DrainRogue_Begin(Session)
	local Rogue = this:GetSpawnNPC(116206)
	local Halfmain = this:GetSpawnNPC(116504)
		
	Session:Blocking()
		Rogue:Say("나의 잠을 깨운 자는 누구인가?")
		Halfmain:SetAlwaysRun(true)
		Halfmain:MoveToMarker(1061)			
		Halfmain:Say("{ani=positive}내가 지시한 것은 잘 한 모양이군. 자네 나를 알아보겠는가?", 3)
		Rogue:Say("하프메인 대장…… 그렇군. 이번에는 제 차례입니까?", 2)
		Rogue:Say("꼭 이렇게까지 할 필요가 있습니까?", 2)
		Halfmain:NonDelaySay("...... 미안하다고는 생각하네. 하지만 난 지금 자네의 은신 능력이 필요해. 미안하네.", 5)
		Halfmain:UseTalent(211650401, Rogue)
		Rogue:Say("{ani=MF_BT1}난 용 사냥을 위해 살아왔고 그로 인해 죽어 상관없지만......", 2)
		Rogue:Say("하지만 대장. 당신은 언젠가 그 힘에 침식당할 겁니다. 후회하지 마십시오.", 3)
	Session:ChangeScene("Drain")
end

function Field_8010:OnSessionScene_DrainRogue_Drain(Session)
	local Rogue = this:GetSpawnNPC(116206)
	local Halfmain = this:GetSpawnNPC(116504)
	
		Rogue:Die(Rogue)
	Session:RemoveNPC(Rogue)
		Halfmain:Say("이것으로 끝났군. 은신 능력은 앞으로 아레크를 사냥하는데 큰 도움이 될 거야.", 4)
		Halfmain:Say("난 다시 침식동으로 돌아가 죽은 전우들을 위해 명상에 들어가겠네.", 3)
		Halfmain:Say("자네는 캠프로 돌아가 베오그릴에게 그리 전해주게.", 2)
		Halfmain:Despawn(false)
	Session:EndSession()
end

function Field_8010_SelfDespawn(Self)
	Self:Despawn(false)
end

-- quest pvp 수호자 죽었을 때 진영에 디버프 걸기
function Field_8010:OnDie(DespawnInfo) -- 토가트 수호자 대장이 죽으면 포탈이 열린다.

	if (DespawnInfo.SpawnID == 116603) then
		QuestPVP = this:GetQuestPVP();
		QuestPVP:DisableMarkPos(116603);
	end
	if (DespawnInfo.SpawnID == 116604) then
		QuestPVP = this:GetQuestPVP();
		QuestPVP:DisableMarkPos(116604);
	end

	if (DespawnInfo.SpawnID == 22) then
		local Base = this:GetNPC(116603)
		Base:GainBuff(501192)
	elseif (DespawnInfo.SpawnID == 23) then
		local Base = this:GetNPC(116604)
		Base:GainBuff(501192)
	elseif (DespawnInfo.SpawnID == 30) or (DespawnInfo.SpawnID == 31) then
		-- 불의 진영 중간 거점이 죽으면 거점 보호막 삭제
		local Base = this:GetNPC(116603)
		Base:RemoveBuff(501206)
	elseif (DespawnInfo.SpawnID == 32) or (DespawnInfo.SpawnID == 33) then
		-- 물의 진영 중간 거점이 죽으면 거점 보호막 삭제
		local Base = this:GetNPC(116604)
		Base:RemoveBuff(501206)
	end
end













