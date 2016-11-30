--«Ï¿ÃµÁ
function NPC_119201:OnDialogExit(Player, DialogID, nExit)
	if (1190222 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119022, 1)
	end
end