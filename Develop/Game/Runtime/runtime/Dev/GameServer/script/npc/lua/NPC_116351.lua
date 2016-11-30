-- 물의 군주 대리 이아시

function NPC_116351:OnDialogExit(Player, DialogID, ExitID) 
	if (DialogID == 1160252) and (1 == ExitID) then
		Player:UpdateQuestVar(116025, 3)
	end
end

