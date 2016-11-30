function NPC_119207:OnDialogExit(Player, DialogID, nExit)
	if (1190022 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119002, 1)
	end
end