function NPC_101221:OnDialogExit(Player, DialogID, nExit)
	if (1010222 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101022, 2)
		end
	end
end
