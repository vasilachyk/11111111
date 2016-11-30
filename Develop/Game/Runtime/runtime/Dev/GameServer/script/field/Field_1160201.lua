-- 침식동 : 트라이얼 (지켜보던 자)

function Field_1160201:OnSpawn(SpawnInfo) -- 하프메인 스폰시 설정
	if (SpawnInfo.NPCID == 116209) then		
		SpawnInfo.NPC:DisableInteraction()
	end		
end

function Field_1160201:OnSensorEnter_116020(Actor) -- 대화 시작 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(116020)	
		local Sage = this:GetSpawnNPC(116207)		
		local Halfmain = this:GetSpawnNPC(116209)
		local Session = this:MakeSession("Talking", {Halfmain, Sage})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160201:OnSessionScene_Talking_Begin(Session)
		local Sage = this:GetSpawnNPC(116207)		
		local Halfmain = this:GetSpawnNPC(116209)
	
	Session:Blocking()
		Halfmain:Say("{sound=scene12_halfmain_1}{ani=talk1}항상 약속한 때는 잘 지키는군.", 2.5)
		Sage:Say("{sound=scene12_redsage_1}{ani=talk1}약속이란 그런 것이니까요. 아레크의 습격으로 피해가 커 보입니다.", 4.6)	
		Halfmain:Say("{sound=scene12_halfmain_2}{ani=talk1}피해는 크지만, 계획엔 변동은 없다네. 자네가 내게 입힌 갑옷이 제대로 기능하고 있으니까.", 6.6)		
		Sage:Say("{sound=scene12_redsage_2}{ani=talk1}확실히 슈나크의 갑옷과 망가진 육체가 거의 융합이 완료된 것 같군요.", 4.9)
		Halfmain:Say("{sound=scene12_halfmain_3}{ani=ignore}하지만 이런 것에 의존하고 싶지 않았네.", 2.7)
		Sage:Say("{sound=scene12_redsage_3}{ani=talk1}어련하시겠지요. 하지만 슈나크의 갑옷이 없었으면 당신은 죽었습니다.", 4.8)
		Sage:Say("{sound=scene12_redsage_4}{ani=talk1}육체의 반 이상을 아레크의 화염에 불타 손상되거나…… 사라졌으니까요.", 5.9)
		Sage:Say("{sound=scene12_redsage_5}{ani=talk1}그러니 그 힘을 부정해서는 안 됩니다.", 2.3)
		Halfmain:Say("{sound=scene12_halfmain_4}{ani=talk1}전부터 궁금했는데, 자네가 날 돕는 이유는 뭔가?", 3.8)
		Halfmain:Say("{sound=scene12_halfmain_5}{ani=talk1}딱히 다른 목적이 있는 것 같은데?", 2.3)
		Sage:Say("{sound=scene12_redsage_6}{ani=talk1}훗...... 전에도 말씀드렸지만, 그저 당신과 같이 용을 증오한다고만 해두죠. 지금 서로 의심하기엔 시기가 좋지 않습니다.", 9.7)
		Sage:Say("{sound=scene12_redsage_7}{ani=talk1}그리고 제가 드린 힘으로 당신이 어디까지 도달하는지 보고 싶을 뿐이죠.", 4.8)
		Halfmain:Say("{sound=scene12_halfmain_6}{ani=positive}하! 뭐 그것도 나쁘지 않지. 자네가 말해서 일이 그릇된 적이 있던가.", 5.5)
		Sage:Say("{sound=scene12_redsage_8}{ani=talk1}당신의 상태를 확인했으니 이만 가보도록 하죠.", 2.8)
		Sage:Say("{sound=scene12_redsage_9}{ani=talk1}달이 세 번 지고 아란바스의 열기가 더욱 강렬해질 때 찾아오도록 하겠습니다.", 5.4)
		Sage:Say("{sound=scene12_redsage_10}{ani=talk1}슬슬 아란바스의 활화산도 잠에서 깨어날 때가 되었군요.", 4.2)
		Halfmain:Say("{sound=scene12_halfmain_7}{ani=negative}뭐라고? 아란바스 화산이 다시 깨어난다니?", 3.0)	
		Sage:UseTalentSelf(211620701)			
	Session:ChangeScene("End")	
end

function Field_1160201:OnSessionScene_Talking_End(Session)
		local Sage = this:GetSpawnNPC(116207)
		local Halfmain = this:GetSpawnNPC(116209)		
		Sage:Despawn(false)
		Halfmain:Say("{sound=scene12_halfmain_8}{ani=talk1}또 의미심장한 말을 남기고 가는군.",2.5)			
	Session:EndSession()
end

function Field_1160201:OnSensorEnter_10(Actor) -- 발각 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(10)
		local Sage = this:GetSpawnNPC(116207)		
		local Halfmain = this:GetSpawnNPC(116209)
		local Session = this:MakeSession("Cancel", {Halfmain, Sage})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1160201:OnSessionScene_Cancel_Begin(Session)
		local Sage = this:GetSpawnNPC(116207)		
		local Halfmain = this:GetSpawnNPC(116209)
		
	Session:NonBlocking()
		Sage:ClearJob()		
		Halfmain:ClearJob()	
	Session:Blocking()
		Halfmain:FaceTo(Session:FindBookmark("Player"))	
		Sage:FaceTo(Session:FindBookmark("Player"))				
		Halfmain:NonDelaySay("{sound=scene12_halfmain_9}거기 숨어 있는 놈이 누구냐?",1.7)	
		Sage:UseTalentSelf(211620701)				
	Session:ChangeScene("End")	
end

function Field_1160201:OnSessionScene_Cancel_End(Session)
		local Sage = this:GetSpawnNPC(116207)
		Sage:Despawn(false)
	Session:EndSession()
end

function Field_1160201:OnSensorEnter_11(Actor) -- 인터렉션 ON 센서
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(11)	
		local Halfmain = this:GetSpawnNPC(116209)
		local Session = this:MakeSession("Spot", {Halfmain})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1160201:OnSessionScene_Spot_Begin(Session)
		local Halfmain = this:GetSpawnNPC(116209)
	Session:Blocking()	
		Halfmain:FaceTo(Session:FindBookmark("Player"))		
		Halfmain:Say("{sound=scene12_halfmain_10}{ani=talk1}아아, 자네로군. 그래 무슨 일로 온 건가?",3.5)
		Halfmain:EnableInteraction()
	Session:EndSession()
end

