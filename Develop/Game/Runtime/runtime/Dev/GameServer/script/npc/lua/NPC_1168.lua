function NPC_1168:OnDialogExit(Player, DialogID, nExit)
	if (1170274 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117027, 3)		
	end
end