function NPC_118201:OnDialogExit(Player, DialogID, nExit)
	if (1180111 == DialogID) and (2 == nExit) then
		-- Player:UpdateQuestVar(118011, 1)
		Player:GateToTrial(1180110, false)	
	
	-- 용의 출현 인던 입장 대화
	elseif (1180201 == DialogID) and (2 == nExit) then			
		Player:GateToTrial(1180200, false)			
	end
	
end