function NPC_118209:OnDialogExit(Player, DialogID, nExit)
	if (1190073 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119007, 2)
	end
end