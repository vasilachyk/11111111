function NPC_101215:OnDialogExit(Player, nDialogID, nExit)	
	if (1010671 == nDialogID) and (2 == nExit) then					
		Player:GateToTrial(1010670, true)		
	end		
end
