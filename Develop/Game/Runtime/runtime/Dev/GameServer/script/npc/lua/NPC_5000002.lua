function NPC_5000002:OnDialogExit(Player, DialogID, nExit)
	if (5000002 == DialogID) then
		if (1 == nExit) then
			--Player:RemoveItem(5000001, 1)
			Player:UpdateQuestVar(5000000, 2)
		end
	end
end
