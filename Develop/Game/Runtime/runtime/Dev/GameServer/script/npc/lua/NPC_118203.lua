function NPC_118203:OnDialogExit(Player, DialogID, nExit)
	if (1180033 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(118003, 2)
	end
end