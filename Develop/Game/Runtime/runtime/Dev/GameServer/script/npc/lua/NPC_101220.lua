function NPC_101220:OnDialogExit(Player, DialogID, nExit)
	if (1010221 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101022, 1)
		end
	end
end
