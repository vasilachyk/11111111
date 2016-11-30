-- 티안 (트라이얼용)

function NPC_109020:OnDialogExit(Player, DialogID, Exit)
	if (1091042 == DialogID) then
		if (1 == Exit) then
			if (Player:CheckCondition(1090189) == true) then
				Player:GateToMarker(109, 1090189)
			end
			if (Player:CheckCondition(1090189) == false) then
				Player:GateToMarker(109001, 109059)
			end			
		end
	end
end
