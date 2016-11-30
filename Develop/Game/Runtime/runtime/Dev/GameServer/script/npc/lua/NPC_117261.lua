function NPC_117261:OnDialogExit(Player, DialogID, nExit)
	if (1170681	== DialogID) then
		if (2 == nExit) then
			-- Player:UpdateQuestVar(117068, 1)
			Player:GateToTrial(1170680,false)			
		end
	end
end
