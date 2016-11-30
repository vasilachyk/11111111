function NPC_101219:OnDialogExit(Player, DialogID, nExit)
	if (1010342 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101034, 1)
		end
	elseif (1010331 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101033, 1)
		end
	end
end
