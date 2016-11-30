-- 조사단원 로렌스의 글

function NPC_111236:OnDialogExit(Player, DialogID, ExitID) -- 지겨운 녀석들. 베스피오단 상징을 하고 대화시
	if (DialogID == 1110043) and (1 == ExitID) then
		Player:UpdateQuestVar(111004, 2)
	end
end


