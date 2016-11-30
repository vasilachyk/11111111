function NPC_101261:OnDialogExit(Player, DialogID, nExit)
	if (1010572 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101057, 1)	
		end
	end
end
