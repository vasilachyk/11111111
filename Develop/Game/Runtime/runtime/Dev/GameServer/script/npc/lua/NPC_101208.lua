function NPC_101208:OnDialogExit(Player, DialogID, nExit)
	if (1010201 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101020, 1)
		end
	end
end
