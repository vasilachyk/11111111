-- 미라지 

-- 107063 플릿풋 트라이얼 퀘스트 입장
function NPC_107223:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 1070631) then
		if (1 == ExitID) then
			Player:GateToTrial(1070530, false)
		end
	end
end


