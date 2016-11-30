function Quest_998027:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	
	if (Player:CheckCondition(9980271) == true) then
		NPC:SayNow("$$Quest_998027_001")	
	end
	
end
	