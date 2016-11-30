--집정관 코린스트
function NPC_1161:OnDialogExit(Player, DialogID, nExit)
	if (1190092 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(119009, 1)		
	end		
end
