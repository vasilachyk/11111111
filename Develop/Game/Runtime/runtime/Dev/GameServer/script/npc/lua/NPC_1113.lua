function NPC_1113:OnDialogExit(Player, DialogID, nExit)
	if (1010451 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101045, 1)
		end
	end
end
