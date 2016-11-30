function NPC_101216:OnDialogExit(Player, DialogID, nExit)
	if (1010573 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(101057, 2)
	end
	
	if (1010231 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(101023, 1)		
	end
end
