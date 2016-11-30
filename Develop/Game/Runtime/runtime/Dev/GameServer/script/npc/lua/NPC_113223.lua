-- 보안관 라즈

function NPC_113223:OnDialogExit(Player, DialogID, ExitID) -- 지겨운 녀석들. 베스피오단 상징을 하고 대화시
	if (DialogID == 1130904) and (1 == ExitID) then
		Player:UpdateQuestVar(113090, 3)
	end
end


