function Quest_117048:OnBegin(Player, NPC)
	
	local Field = Player:GetField()			
	
	Field:EnableSensor(1170000)
	Field:EnableSensor(1170001)
	Field:EnableSensor(1170002)
	Field:EnableSensor(1170003)
	
	NPC:EnableInteraction(117600)
	
	this:UpdateVar(1)
end



function Quest_117058:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	GLog("a Line")
	local Field = Player:GetField()		
		
	if (ObjectiveID == 1)  then		
		-- GLog("1 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(110028)			
		Field:SetTimer(117058, 10, false)			
		
		for i = 1, 3 do 
			local dice = math.random(11710004, 11710025)									
			local dice2 = math.random(1, 5)	
			
			local monster = Field:GetSpawnNPC(dice)						
			
			-- GLog("dice ="..dice.."\n")
			-- GLog("dice ="..dice2.."\n")
			-- 임시 텍스트 
			
			if dice2 == 1 then						
				monster:SayNow("$$Quest_117058_001")	 --monster:Say("그만!!")	
				-- GLog("say1")				
			end
			
			if dice2 == 2 then			
				monster:SayNow("$$Quest_117058_002")			--monster:Say("여긴 외부인은 출입금지다!")			
				-- GLog("say2")
			end
			
			if dice2 == 3 then			
				monster:SayNow("$$Quest_117058_003")			 --monster:Say("안돼!! 우리 보급품을 불태우다니!!")			
				-- GLog("say3")
			end	
			
			if dice2 == 4 then			
				monster:SayNow("$$Quest_117058_004")			 --monster:Say("이 녀석들 그만두지 못해!!")			
				-- GLog("say4")
			end	
			
			if dice2 == 5 then			
				monster:SayNow("$$Quest_117058_005")			 --monster:Say("죽여버릴테다!!")			
				-- GLog("say5")
			end	
			
		end
		
	end
	
	if (ObjectiveID == 2)  then		
		GLog("2 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(110028)			
		Field:SetTimer(117058, 10, false)			
		
		
		for i = 1, 3 do 
			local dice = math.random(11710004, 11710025)									
			local dice2 = math.random(1, 5)	
			
			local monster = Field:GetSpawnNPC(dice)						
			
			-- GLog("dice ="..dice.."\n")
			-- GLog("dice ="..dice2.."\n")
			-- 임시 텍스트 
			
			if dice2 == 1 then						
				monster:SayNow("$$Quest_117058_001")	 --monster:Say("그만!!")	
				-- GLog("say1")				
			end
			
			if dice2 == 2 then			
				monster:SayNow("$$Quest_117058_002")			--monster:Say("여긴 외부인은 출입금지다!")			
				-- GLog("say2")
			end
			
			if dice2 == 3 then			
				monster:SayNow("$$Quest_117058_003")			 --monster:Say("안돼!! 우리 보급품을 불태우다니!!")			
				-- GLog("say3")
			end	
			
			if dice2 == 4 then			
				monster:SayNow("$$Quest_117058_004")			 --monster:Say("이 녀석들 그만두지 못해!!")			
				-- GLog("say4")
			end	
			
			if dice2 == 5 then			
				monster:SayNow("$$Quest_117058_005")			 --monster:Say("죽여버릴테다!!")			
				-- GLog("say5")
			end	
			
		end
		
		
	end
	
	if (ObjectiveID == 3)  then		
		GLog("3 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(110028)			
		Field:SetTimer(117058, 10, false)			
		
		for i = 1, 3 do 
			local dice = math.random(11710004, 11710025)									
			local dice2 = math.random(1, 5)	
			
			local monster = Field:GetSpawnNPC(dice)						
			
			-- GLog("dice ="..dice.."\n")
			-- GLog("dice ="..dice2.."\n")
			-- 임시 텍스트 
			
			if dice2 == 1 then						
				monster:SayNow("$$Quest_117058_001")	 --monster:Say("그만!!")	
				-- GLog("say1")				
			end
			
			if dice2 == 2 then			
				monster:SayNow("$$Quest_117058_002")			--monster:Say("여긴 외부인은 출입금지다!")			
				-- GLog("say2")
			end
			
			if dice2 == 3 then			
				monster:SayNow("$$Quest_117058_003")			 --monster:Say("안돼!! 우리 보급품을 불태우다니!!")			
				-- GLog("say3")
			end	
			
			if dice2 == 4 then			
				monster:SayNow("$$Quest_117058_004")			 --monster:Say("이 녀석들 그만두지 못해!!")			
				-- GLog("say4")
			end	
			
			if dice2 == 5 then			
				monster:SayNow("$$Quest_117058_005")			 --monster:Say("죽여버릴테다!!")			
				-- GLog("say5")
			end	
			
		end
		
		
	end
	
	if (ObjectiveID == 4)  then		
		GLog("4 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(110028)			
		Field:SetTimer(117058, 10, false)			
		
		
		for i = 1, 3 do 
			local dice = math.random(11710004, 11710025)
			local dice2 = math.random(1, 5)	
			
			local monster = Field:GetSpawnNPC(dice)						
			
			-- GLog("dice ="..dice.."\n")
			-- GLog("dice ="..dice2.."\n")
			-- 임시 텍스트 
			if dice2 == 1 then						
				monster:SayNow("$$Quest_117058_001")	 --monster:Say("그만!!")	
				-- GLog("say1")				
			end
			
			if dice2 == 2 then			
				monster:SayNow("$$Quest_117058_002")			--monster:Say("여긴 외부인은 출입금지다!")			
				-- GLog("say2")
			end
			
			if dice2 == 3 then			
				monster:SayNow("$$Quest_117058_003")			 --monster:Say("안돼!! 우리 보급품을 불태우다니!!")			
				-- GLog("say3")
			end	
			
			if dice2 == 4 then			
				monster:SayNow("$$Quest_117058_004")			 --monster:Say("이 녀석들 그만두지 못해!!")			
				-- GLog("say4")
			end	
			
			if dice2 == 5 then			
				monster:SayNow("$$Quest_117058_005")			 --monster:Say("죽여버릴테다!!")			
				-- GLog("say5")
			end	
			
		end
		
		
	end	
	
end


function Quest_117058:OnObjComplete(Player, ObjectiveID)	
	--모두 불을 붙이고 전투를 안하고 나갈경우 체크할수없기 때문에 변수가 필요
	this:UpdateVar(4) 
	
	local Field = Player:GetField()	
	
	if (1 == ObjectiveID) then		
		Player:Tip("$$Quest_117058_006") --Player:Tip("잠시 뒤에 맥기프가 나타날 것입니다!")
		Field:SetTimer(1170580, 10, false)			
	end
	
	if (2 == ObjectiveID) then					
		Player:Tip("$$Quest_117058_007")		--Player:Tip("멕기프를 처치하였습니다!")		
		this:UpdateVar(5) 
	end	
end


