function NPC_101205:OnDialogExit(Player, DialogID, nExit)
	if (1010052 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101005, 2)
		end
	end
end
