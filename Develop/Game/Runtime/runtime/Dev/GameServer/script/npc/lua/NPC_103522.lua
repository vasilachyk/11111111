-- 코웬 늪지대 트라이얼 필드 : 부관 라이넥

function NPC_103522:OnDialogExit(Player, DialogID, ExitID)
	if (1030046 == DialogID) and (1 == ExitID) then
		Player:GateToMarker(1030042, 1)
	end
end
