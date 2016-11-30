-- 아케론 족장 포르나
function NPC_103251:OnDialogExit(Player, DialogID, nExit)
	if (1030162 == DialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(103016, 2)
		end
	end
end
