-- 기사 바스틸

-- 110030 고블린 골렘 트라이얼 퀘스트 입장
function NPC_110210:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 1100301) then
		if (1 == ExitID) then
			Player:GateToTrial(1100300, false)
		end
	end
end


