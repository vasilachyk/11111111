-- 마력의 토템

function NPC_111302:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 1110212) then
		if (ExitID == 1) then
			Player:Tip("$$NPC_111302",4.0)			-- 토템의 마력으로 코볼드란의 내용이 보이게 되었습니다.
			Player:UpdateQuestVar(111021, 2)
		end
	end
end