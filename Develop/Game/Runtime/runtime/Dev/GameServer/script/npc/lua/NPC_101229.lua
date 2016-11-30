function NPC_101229:OnDialogExit(Player, DialogID, nExit)
	if (1010462 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101046, 3)
		end
	end
end
