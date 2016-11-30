function NPC_117216:OnDialogExit(Player, DialogID, nExit)
	if (9980272 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(998027, 1)
	end
end