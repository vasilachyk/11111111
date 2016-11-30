function NPC_118202:OnDialogExit(Player, DialogID, nExit)
	if (1180032 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(118003, 1)
	end
end