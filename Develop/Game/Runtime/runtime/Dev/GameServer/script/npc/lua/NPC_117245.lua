function NPC_117245:OnDialogExit(Player, DialogID, nExit)
	if (1170222 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117022, 1)		
	end
end
