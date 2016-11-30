--라드의 하인
function NPC_119205:OnDialogExit(Player, DialogID, nExit)
	if (1190232 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119023, 1)
	end
end