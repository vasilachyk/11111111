-- 조사단원 아리스

function NPC_102237:OnDialogExit(Player, DialogID, ExitID)
	if (1110044 == DialogID) and (1 == ExitID) then
		Player:UpdateQuestVar(111004, 4)
	end
end
