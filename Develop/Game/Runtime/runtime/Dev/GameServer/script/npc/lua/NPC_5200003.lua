-- 도전퀘 테스트 : 슈터 란도 

function NPC_5200003:OnDialogExit(Player, DialogID, ExitID)
 	if (1 == ExitID) then
		local GateDestTable = {}
		GateDestTable[9990023] = 107091
		GateDestTable[9990033] = 107090
		GateDestTable[9990043] = 107092
		GateDestTable[9990053] = 107093
		GateDestTable[9990063] = 107094
		Player:GateToTrial(GateDestTable[DialogID])
	end
end


