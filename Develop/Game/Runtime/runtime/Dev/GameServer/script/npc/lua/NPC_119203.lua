function NPC_119203:OnDialogExit(Player, DialogID, nExit)
	if (1190072 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119007, 1)
	end
end