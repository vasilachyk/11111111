function NPC_101233:OnDialogExit(Player, DialogID, nExit)
	--반복 이리스처치 퀘 101079
	if (1010791	== DialogID) and (2 == nExit) then		
		Player:GateToTrial(1010790, false)
	end	
end

