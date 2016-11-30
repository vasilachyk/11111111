-- 촌장 로메로

function NPC_113225:OnDialogExit(Player, DialogID, ExitID) -- 지겨운 녀석들. 베스피오단 상징을 하고 대화시
	if (DialogID == 1130902) and (1 == ExitID) then
		Player:UpdateQuestVar(113090, 1)
	end
end


