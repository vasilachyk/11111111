function NPC_117333:OnDialogExit(Player, DialogID, nExit)
	if (9980273 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(998027, 2)				
		Player:Tip("$$NPC_117333_001")
	end
end
