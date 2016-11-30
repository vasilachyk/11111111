-- 미스텔(마이 스위트 홈)

function NPC_107237:OnDialogExit(Player, DialogID, ExitID)
	--GLog0("NPC_0107237:OnDialogExit\n")
	
	if (1070543 == DialogID) then
		if (2 == ExitID) then
			Player:GateToMarker(107, 107054)	
		end
	end
end
