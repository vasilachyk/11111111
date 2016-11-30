-- 아란바스 화산지대

function Field_116:OnSensorEnter_116017(Actor) -- 묘지 : 기도문 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160171) == true) then
			AsPlayer(Actor):Tip("이곳에서 하프메인의 기도문을 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116017, 2)
		end
	end
end
function Field_116:OnSensorLeave_116017(Actor) -- 묘지 : 멀어지면 기도문 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116017, 1)
	end
end
function Field_116:OnSensorTalent_116017(Actor, TalentID) -- 기도문 사용시
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

function Field_116:OnSensorEnter_116028(Actor) -- 온천 : 정령신주 재료 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160281) == true) then
			AsPlayer(Actor):Tip("이곳에서 정령신주 재료를 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116028, 2)
		end
	end
end
function Field_116:OnSensorLeave_116028(Actor) -- 온천 : 멀어지면 정령신주 재료 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116028, 1)
	end
end
function Field_116:OnSensorTalent_116028(Actor, TalentID) -- 온천 : 정령신주 재료 사용시
	if (TalentID == 140553) then
		AsPlayer(Actor):UpdateQuestVar(116028, 3)
		AsPlayer(Actor):Tip("정령신주가 완성되었습니다.")
		this:SpawnByID(116414, false)
	end
end

function Field_116:OnSpawn(SpawnInfo) -- 정령신주 스폰시
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
end

function Field_116:OnSessionScene_DrainRogue_Begin(Session)
	local Rogue = this:GetSpawnNPC(116206)
	local Halfmain = this:GetSpawnNPC(116504)
		
	Session:Blocking()
		Rogue:Say("{sound=scene11_ghost_1}나의 잠을 깨운 자는 누구인가?",2.6)
		Halfmain:SetAlwaysRun(true)
		Halfmain:MoveToMarker(1061)			
		Halfmain:Say("{sound=scene11_halfmain_1}{ani=positive}내가 지시한 것은 잘한 모양이군. 자네 나를 알아보겠는가?", 4.3)
		Rogue:Say("{sound=scene11_ghost_2}하프메인 대장…… 그렇군. 이번에는 제 차례입니까?", 3.7)
		Rogue:Say("{sound=scene11_ghost_3}꼭 이렇게까지 할 필요가 있습니까?", 2.5)
		Halfmain:NonDelaySay("{sound=scene11_halfmain_2}...... 미안하다고는 생각하네. 하지만 난 지금 자네의 은신 능력이 필요해. 미안하네.", 5.5)
		Halfmain:UseTalent(211650401, Rogue)
		Rogue:Say("{sound=scene11_ghost_4}{ani=MF_BT1}전 용사냥을 위해 살아왔고 그 덕분에 죽게 되었지만, 후회는 하지 않습니다.", 5.0)
		Rogue:Say("{sound=scene11_ghost_5}하지만 대장. 당신은 언젠가 그 힘에 침식당하고 말 겁니다. 제 말 유념하십시오.", 6.2)
	Session:ChangeScene("Drain")
end

function Field_116:OnSessionScene_DrainRogue_Drain(Session)
	local Rogue = this:GetSpawnNPC(116206)
	local Halfmain = this:GetSpawnNPC(116504)
	
		Rogue:Die(Rogue)
	Session:RemoveNPC(Rogue)
		Halfmain:Say("{sound=scene11_halfmain_3}이것으로 끝났군. 은신 능력은 앞으로 아레크를 사냥하는데 큰 도움이 될 거야.", 6.0)
		Halfmain:Say("{sound=scene11_halfmain_4}난 다시 침식동으로 돌아가 죽은 전우들을 위해 명상에 들어가겠네.", 4.7)
		Halfmain:Say("{sound=scene11_halfmain_5}자네는 캠프로 돌아가 베오그릴에게 그리 전해주게.", 3.2)
		Halfmain:Despawn(false)
	Session:EndSession()
end

function Field_116_SelfDespawn(Self)
	Self:Despawn(false)
end
