function NPC_1419:OnDialogExit(Player, DialogID, nExit)
	if (9980262 == DialogID) and (1 == nExit) then			
		Player:UpdateQuestVar(998026, 1)	
	end
end
