

function Quest_5000090:OnObjUpdate(Player, ObjectiveID, Progress)
	if (1 == ObjectiveID) then		
		NPC = Player:GetInteractNPC();		
		if (70 >= math.random(0, 100)) then
			NPC:UseTalentSelf(300150090);
			this:UpdateVar(this:GetVar() + 1);
		else
			NPC:Die(Player);			
		end		
	end	
end
