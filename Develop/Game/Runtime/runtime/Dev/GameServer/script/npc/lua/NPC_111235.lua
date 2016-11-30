-- 조사단원 클레오의 시체

function NPC_111235:OnDialogExit(Player, DialogID, ExitID) -- 지겨운 녀석들. 베스피오단 상징을 하고 대화시
	if (DialogID == 1110042) and (1 == ExitID) then
		Player:UpdateQuestVar(111004, 1)
	end
end


