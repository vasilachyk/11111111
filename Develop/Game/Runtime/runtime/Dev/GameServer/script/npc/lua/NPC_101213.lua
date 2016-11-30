function NPC_101213:OnDialogExit(Player, DialogID, nExit)

	-- 101060 한잔 쭉 들이키세요.[추가]
	
	-- if (1010601 == DialogID) and ( ) then
		-- if (1 == nExit) then
			-- Player:UpdateQuestVar(1010601, 1)
		-- end
	-- end


	
	--UseTalent
	
	--101037 위험천만 가디엘교
	if (1010372 == DialogID) then
		if (1 == nExit) then 
			Player:UpdateQuestVar(101037, 1)
		end
	end
	
	
	GLog("1".."/n")			
	
	--101059 밝혀진 메린샤의 정체
	if (1010592 == DialogID) and (1 == nExit) then		
		-- local Field = Player:GetField()
		-- Field:SpawnByID(127)		 
		
		-- local Session = Field:MakeSession("Merinsha", {Merinsha})
		
		
		-- GLog("1.5".."/n")			
		-- Player:UpdateQuestVar(101059, 1)	
		
		
		-- Field:SpawnByID(127) --메린샤
		-- Field:SpawnByID(128) --가디엘 교도 1
		-- Field:SpawnByID(129) --가디엘 교도 2
		-- Field:SpawnByID(130) --가디엘 교도 3
				

		-- local Gadiel1 = Field:GetSpawnNPC(101121)			
		-- local Gadiel2 = Field:GetSpawnNPC(101121)
		-- local Gadiel3 = Field:GetSpawnNPC(101121)
		
		-- local QuestProgress = Player:GetQuestVar(101059)
		
		
		-- Session:ChangeScene("Start")
	
		-- AsPlayer(Actor):Tip("뒤에 메린샤가 나타났습니다! 메린샤 앞에서 정화의 지팡이를 사용해야 합니다!")
		
		-- Field:EnableSensor(22)	
		
		-- GLog("2".."/n")
	
	end	
end

