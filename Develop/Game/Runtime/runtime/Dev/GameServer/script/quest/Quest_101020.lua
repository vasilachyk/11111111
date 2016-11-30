function Quest_101020:OnBegin(Player, NPC)

	-- local Field = Player:GetField()
	-- local Location = Player:GetPos()	
	
	-- local soldierTable = {145, 159, 144, 143, 188, 189}
	
	-- Player:Tip("가디엘 교도들이 들이닥칠 것입니다. 출입구를 확인해보세요!")
	
	-- for i=1, 6 do			
		-- Field:SpawnByID(soldierTable[i])				
	-- end
	
end


function Quest_101020:OnObjComplete(Player, ObjectiveID)
	
	-- local Field = Player:GetField()	
	-- local soldierTable = {145, 159, 144, 143, 188, 189}
	
	-- local soldier1 = Field:GetSpawnNPC(145)	
	-- local soldier2 = Field:GetSpawnNPC(159)	
	-- local soldier3 = Field:GetSpawnNPC(144)	
	-- local soldier4 = Field:GetSpawnNPC(143)	
	-- local soldier5 = Field:GetSpawnNPC(188)	
	-- local soldier6 = Field:GetSpawnNPC(189)	
	
	-- if (ObjectiveID == 1 ) then
		
		-- Player:Tip("가디엘 교도들의 습격을 막는데 성공하였습니다")
		
		-- soldier1:GainBuff(40904)			
		-- soldier2:GainBuff(40904)
		-- soldier3:GainBuff(40904)
		-- soldier4:GainBuff(40904)
		-- soldier5:GainBuff(40904)
		-- soldier6:GainBuff(40904)
		
		-- for i=1, 6 do			
			
			-- Field:DespawnByID(soldierTable[i], false)			
		-- end
		
	-- end

end


