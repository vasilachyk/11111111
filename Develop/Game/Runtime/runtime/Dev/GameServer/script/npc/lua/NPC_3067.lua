-- 렌고트 부락 전투 모집병

function NPC_3067:OnDialogExit(Player, DialogID, ExitID)		
	if (1100001 == DialogID) and (1 == ExitID) then
		Player:GateToTrial(1100000, false)			
	end
end
