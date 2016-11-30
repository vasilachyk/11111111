function NPC_113207:OnDialogExit(Player, DialogID, nExit)
	if (1131581 == DialogID) and (2 == nExit) then
		-- Player:UpdateQuestVar(118011, 1)
		Player:GateToTrial(1131580, false)	
	end	
end