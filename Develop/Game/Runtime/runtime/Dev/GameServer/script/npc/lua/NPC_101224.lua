function NPC_101224:OnDialogExit(Player, DialogID, nExit)
	if (1010573 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(101057, 2)		
	end
end
