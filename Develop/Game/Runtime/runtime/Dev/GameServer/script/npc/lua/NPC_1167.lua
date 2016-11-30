function NPC_1167:OnDialogExit(Player, DialogID, nExit)
	if (1170273 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117027, 2)		
	end
end