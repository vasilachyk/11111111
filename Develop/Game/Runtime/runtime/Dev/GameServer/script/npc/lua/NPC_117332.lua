function NPC_117332:OnDialogExit(Player, DialogID, nExit)
	if (9980272 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(998027, 1)		
		Player:Tip("$$NPC_117332_001")
	end
end
