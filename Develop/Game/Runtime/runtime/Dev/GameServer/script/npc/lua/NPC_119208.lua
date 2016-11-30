function NPC_119208:OnDialogExit(Player, DialogID, nExit)
	if (1190023 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119002, 2)
	end
end