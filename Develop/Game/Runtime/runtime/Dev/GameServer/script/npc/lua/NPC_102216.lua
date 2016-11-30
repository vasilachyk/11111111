-- ÀºÀÚ 

function NPC_102216:OnDialogExit(Player, DialogID, ExitID)
	if (1020221 == DialogID) and (1 == ExitID) then
		Player:UpdateQuestVar(102022, 2)
	end
end
