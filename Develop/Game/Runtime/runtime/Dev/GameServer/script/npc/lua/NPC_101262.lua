function NPC_101262:OnDialogExit(Player, DialogID, nExit)
	if (1010574 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(101057, 3)	
		end
	end
end
