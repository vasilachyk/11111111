function NPC_1166:OnDialogExit(Player, DialogID, nExit)
	if (1170272 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117027, 1)		
	end
end
