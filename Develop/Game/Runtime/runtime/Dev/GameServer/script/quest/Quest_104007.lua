function Quest_104007:OnObjComplete(Player, ObjectiveID)
	local Field = Player:GetField()	
	
	local a_energy1 = Field:GetSpawnNPC(104282)
	local a_energy2 = Field:GetSpawnNPC(104283)
	local a_energy3 = Field:GetSpawnNPC(104284)
		
	
	if (1 == ObjectiveID) then				
	
		local spawn_pos1 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )	
		Field:Spawn(104160, spawn_pos1)
		
		local spawn_pos2 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), 200 )			
		Field:Spawn(104160, spawn_pos2)		
		
		a_energy1:UseTalentSelf(140610)
		a_energy1:RemoveBuff(111000)		
		Field:SetTimer(1040070, 10, false)
	end
	
	if (2 == ObjectiveID) then	
	
		local spawn_pos1 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )	
		Field:Spawn(104160, spawn_pos1)
		
		local spawn_pos2 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), 200 )			
		Field:Spawn(104160, spawn_pos2)		
		
		a_energy2:UseTalentSelf(140610)
		a_energy2:RemoveBuff(111000)		
		Field:SetTimer(1040070, 10, false)	
		
	end

	if (3 == ObjectiveID) then	
	
		local spawn_pos1 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )	
		Field:Spawn(104160, spawn_pos1)
		
		local spawn_pos2 = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), 200 )			
		Field:Spawn(104160, spawn_pos2)		
		
		a_energy3:UseTalentSelf(140610)
		a_energy3:RemoveBuff(111000)		
		Field:SetTimer(1040070, 10, false)
		
		
	end


end