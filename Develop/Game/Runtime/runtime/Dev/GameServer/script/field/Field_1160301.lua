-- 아레크의 둥지 (정령신주를 불의 군주에게)

function Field_1160301:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116308) then		
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:GainBuff(110075)			
	end	
	if (SpawnInfo.NPCID == 116510) then		
		SpawnInfo.NPC:DisableInteraction()
		SpawnInfo.NPC:GainBuff(110074)	
		SpawnInfo.NPC:SetAlwaysRun(true)
	end		
end

function Field_1160301:OnSensorEnter_116030(Actor) -- 결계 앞에서 : 정령신주 사용 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1160301) == true) then
			AsPlayer(Actor):Tip("이곳에서 정령신주를 사용하십시오.")
			AsPlayer(Actor):UpdateQuestVar(116030, 2)
		end
	end
end

function Field_1160301:OnSensorLeave_116030(Actor) -- 묘지 : 멀어지면 정령신주 사용 불가
	if (Actor:IsPlayer() == true) then	
		AsPlayer(Actor):UpdateQuestVar(116030, 1)
	end
end

function Field_1160301:OnSensorTalent_116030(Actor, TalentID) -- 정령신주 사용시
	if (TalentID == 140554) then
		AsPlayer(Actor):UpdateQuestVar(116030, 3)
		AsPlayer(Actor):Tip("불의 군주가 다가오고 있습니다.")
		local FireLord = this:GetSpawnNPC(116308)
		local Halfmain = this:GetSpawnNPC(116510)
		local Session = this:MakeSession("Nectar", {Halfmain, FireLord})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1160301:OnSessionScene_Nectar_Begin(Session)
		local FireLord = this:GetSpawnNPC(116308)
		local Halfmain = this:GetSpawnNPC(116510)
	
	Session:Blocking()
		FireLord:Patrol({31,32,33}, PT_ONCE)
		FireLord:Say("{sound=scene14_firelord_1}드디어 정령신주가 완성되었나 보군.", 2.9)		
		FireLord:Say("{sound=scene14_firelord_2}불칸이 말한 이가 그대였군. 그대가 정령신주를 만드는데 큰 공헌을 했다고 들었다.", 7.9)
		FireLord:Say("{sound=scene14_firelord_3}그대가 만든 이 정령신주를 사용하면 아레크는 드디어 악몽에서 깨어날 수 있을 것이다. 고맙도다. 인간이여.", 8.5)
		FireLord:Say("{sound=scene14_firelord_4}이제 그 정령신주를 나에게 다오.", 3.0)
	Session:ChangeScene("Sneak")		
end

function Field_1160301:OnSessionScene_Nectar_Sneak(Session)
		local FireLord = this:GetSpawnNPC(116308)
		local Halfmain = this:GetSpawnNPC(116510)
		
		Halfmain:RemoveBuff(110074)
		Halfmain:NonDelaySay("{sound=scene14_halfmain_1}그렇게는 안되지.", 1.5)
		Halfmain:UseTalentSelf(211651001)		
		FireLord:FaceTo(Halfmain)
		FireLord:NonDelaySay("{sound=scene14_firelord_5}너는......!", 3.6)	
		Halfmain:FaceTo(FireLord)		
		Halfmain:UseTalentSelf(211651002)			
	Session:ChangeScene("Drain")	
end

function Field_1160301:OnSessionScene_Nectar_Drain(Session)
		local FireLord = this:GetSpawnNPC(116308)
		local Halfmain = this:GetSpawnNPC(116510)
		
		FireLord:GainBuff(110018)	
		Halfmain:UseTalentSelf(211651003)
	Session:ChangeScene("End")
end

function Field_1160301:OnSessionScene_Nectar_End(Session)
		local FireLord = this:GetSpawnNPC(116308)
		local Halfmain = this:GetSpawnNPC(116510)
		
		FireLord:Die(FireLord)
		Halfmain:Wait(5)
		Halfmain:Say("{sound=scene14_halfmain_2}{ani=laugh}이것이 불의 군주의 힘인가! 엄청난 힘이군! 하하, 하하하!", 5.8)			
		Halfmain:Say("{sound=scene14_halfmain_3}{ani=cheer}이 정도 힘이라면 아레크 따윈 아무것도 아니야!", 3.5)
	Session:ChangeScene("Interaction")
end

function Field_1160301:OnSessionScene_Nectar_Interaction(Session)
		local Halfmain = this:GetSpawnNPC(116510)
		
		Halfmain:EnableInteraction()		
	Session:EndSession()
end