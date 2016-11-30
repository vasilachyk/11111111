function NPC_118208:OnDialogExit(Player, DialogID, nExit)
	if (1190074 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119007, 3)
	end
end