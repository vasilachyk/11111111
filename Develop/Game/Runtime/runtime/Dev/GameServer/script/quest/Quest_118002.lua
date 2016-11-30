function Quest_118002:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
		-- local Field = Player:GetField()		
		-- local soldierTable = {100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139
		
		-- local soldier = {}
		-- soldier['spawnid'] = {100, 101}
		-- soldier['talk'] = {'데헷', '데헷헷'}
		
		
		local TalkTable = {"$$Quest_118002_001","$$Quest_118002_002","$$Quest_118002_003","$$Quest_118002_004",
							"$$Quest_118002_005","$$Quest_118002_006","$$Quest_118002_007"}
		
		GLog("1 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111400)				
		
		local dice = math.random(1,7)
		
		for i, v in ipairs(TalkTable) do		
			if dice  == i then
				NPC:SayNow(TalkTable[i])				
			end		
		end
end


-- function Quest_118002:OnObjUpdate(Player, ObjectiveID, Progress)	
	-- if (6 >= ObjectiveID) then		
		-- Player:Tip("팔을 걷으세요 퀘스트가 업데이트 되었습니다.")				
	-- else 
		-- Player:Tip("팔을 걷으세요 퀘스트가 완료 되었습니다.")		
	-- end		
-- end
