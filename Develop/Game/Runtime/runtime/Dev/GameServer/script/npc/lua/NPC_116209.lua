-- 하프메인 (침식동)

function NPC_116209:OnDialogExit(Player, DialogID, ExitID) 
	if (DialogID == 1160291) and (1 == ExitID) then
		Player:UpdateQuestVar(116029, 2)
	end
	if (DialogID == 1160211) and (1 == ExitID) then
		Player:GateToTrial(1160210,true)
	end	
end

