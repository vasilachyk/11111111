function Quest_5000080:OnObjComplete(Player, ObjectiveID)
	if (1 == ObjectiveID) then
		NPC = Player:GetInteractNPC()
		NPC:Despawn(true)
	elseif (2 == ObjectiveID) then
		NPC = Player:GetInteractNPC()
		NPC:Despawn(true)
	end
end
