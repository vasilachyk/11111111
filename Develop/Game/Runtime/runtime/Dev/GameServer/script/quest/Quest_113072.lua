function Quest_113072:OnObjComplete(Player, ObjectiveID, Trigger)
	local Field = Player:GetField()
	
	if (Trigger == true) then
		if (1 == ObjectiveID) then	
				Player:Tip("$$Quest_113072_6")
				Field:SpawnByID(113097); --  늑대 소환
				local enemy1 = Field:GetSpawnNPC(113097)
				enemy1:Attack(Player)
		elseif (2 == ObjectiveID) then	
				Player:Tip("$$Quest_113072_11")
				Field:SpawnByID(113098); --  늑대 소환
				local enemy1 = Field:GetSpawnNPC(113098)
				enemy1:Attack(Player)
		elseif (3 == ObjectiveID) then	
				Player:Tip("$$Quest_113072_16")
				Field:SpawnByID(113099); --  늑대 소환
				local enemy1 = Field:GetSpawnNPC(113099)
				enemy1:Attack(Player)
		elseif (4 == ObjectiveID) then	
				Player:Tip("$$Quest_113072_21")
				Field:SpawnByID(113100); --  구울 버서커 소환
				local enemy1 = Field:GetSpawnNPC(113100)
				enemy1:Attack(Player)
		end
	end
end


