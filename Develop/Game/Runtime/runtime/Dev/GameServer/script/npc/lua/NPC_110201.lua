-- 렌고트 부락 : 상급기사 세네스

function NPC_110201:OnDialogExit(Player, DialogID, ExitID)
	if (1100181 == DialogID) and (1 == ExitID) then
		Player:GateToTrial(1100180, true)
		--Player:UpdateQuestVar(110018, 2)
	end
end
