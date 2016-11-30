-- 보트 (북쪽에 있는)

function NPC_109034:OnDialogExit(Player, DialogID, Exit)
	if (1091013 == DialogID) then
		if (1 == Exit) then
			Player:Cutscene(109034)
		end
	end
	if (1091014 == DialogID) then
		if (1 == Exit) then
			Player:Cutscene(109035)
		end
	end
	if (1091041 == DialogID) then
		if (2 == Exit) then
			Player:GateToTrial(1091040, false)
		end
	end		
end
