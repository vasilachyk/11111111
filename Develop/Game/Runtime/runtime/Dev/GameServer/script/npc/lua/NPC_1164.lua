--수석 사제 바르디
function NPC_1164:OnDialogExit(Player, DialogID, nExit)
	if (1170223 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117022, 2)		
	end	
	if (1170472 == DialogID) and (1 == nExit) then
		Player:UpdateQuestVar(117047, 1)		
	end	
	if (1170080 == DialogID) and (2 == nExit) then
		GLog("Come")
		this:GainBuff(111106)
	end
end
