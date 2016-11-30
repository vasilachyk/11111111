-- 아케론 족장 포르나
function NPC_103213:OnDialogExit(Player, DialogID, nExit)
	if (1030362 == DialogID) then
		if (1 == nExit) then
			Player:GateToMarker(103, 6)
		end
	end
end
