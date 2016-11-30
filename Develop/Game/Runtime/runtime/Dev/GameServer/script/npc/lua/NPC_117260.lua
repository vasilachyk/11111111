function NPC_117260:OnDialogExit(Player, DialogID, nExit)
	if (1170671	== DialogID) then
		if (2 == nExit) then
			Player:GateToTrial(1170670, false)
			-- Player:UpdateQuestVar(117067,1)
		end
	end
end
