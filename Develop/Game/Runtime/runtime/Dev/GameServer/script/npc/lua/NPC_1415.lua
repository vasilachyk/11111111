function NPC_1415:OnDialogExit(Player, DialogID, nExit)
	if (9980252 == DialogID) and (1 == nExit) then			
		Player:UpdateQuestVar(998025, 1)		
	end
end
