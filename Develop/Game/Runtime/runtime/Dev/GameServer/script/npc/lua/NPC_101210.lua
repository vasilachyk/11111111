function NPC_101210:OnDialogExit(Player, DialogID, nExit)
	if (1010162 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101016, 1)
		end
	end
end
