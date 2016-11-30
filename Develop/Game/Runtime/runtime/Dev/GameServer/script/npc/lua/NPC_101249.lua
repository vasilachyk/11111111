function NPC_101249:OnDialogExit(Player, DialogID, nExit)
	if (1010332 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101033, 2)
		end
	end
end
