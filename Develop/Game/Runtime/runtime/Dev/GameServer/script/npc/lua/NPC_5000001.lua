function NPC_5000001:OnDialogExit(Player, DialogID, nExit)
	if (5000001 == DialogID) then
		if (1 == nExit) then
			--Player:RemoveItem(5000000, 1)
			--Player:AddItem(5000001, 1)
			Player:UpdateQuestVar(5000000, 1)
		end
	end
end
