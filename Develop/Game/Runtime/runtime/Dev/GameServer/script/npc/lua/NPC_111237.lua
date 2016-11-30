-- 조사단원 아리스와 대화

function NPC_111237:OnDialogExit(Player, DialogID, ExitID) -- 지겨운 녀석들. 베스피오단 상징을 하고 대화시
	if (DialogID == 1110044) and (1 == ExitID) then
		Player:UpdateQuestVar(111004, 3)
	end
end


