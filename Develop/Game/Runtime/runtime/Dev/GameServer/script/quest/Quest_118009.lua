function Quest_118009:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
		-- local Field = Player:GetField()		
		-- local injuredsoldier0 = Field:GetSpawnNPC(140)
		-- local injuredsoldier1 = Field:GetSpawnNPC(141)
		-- local injuredsoldier2 = Field:GetSpawnNPC(142)
		-- local injuredsoldier3 = Field:GetSpawnNPC(143)
		-- local injuredsoldier4 = Field:GetSpawnNPC(144)
		-- local injuredsoldier5 = Field:GetSpawnNPC(145)
		-- local injuredsoldier6 = Field:GetSpawnNPC(146)
		-- local injuredsoldier7 = Field:GetSpawnNPC(147)
	
	
		local TalkTable = {"$$Quest_118009_001","$$Quest_118009_002","$$Quest_118009_003","$$Quest_118009_004",
							"$$Quest_118009_005","$$Quest_118009_006","$$Quest_118009_007"}
		
	-- if (ObjectiveID == 1)  then		
		GLog("Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)
		
		-- NPC:Say("1")
		
		local dice = math.random(1, 7)
		
		for i, v in ipairs(TalkTable) do		
			if dice  == i then
				NPC:SayNow(TalkTable[i])
			end		
		end
end
	