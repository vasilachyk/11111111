-- 코웬 늪지대 트라이얼 필드 : 상급기사 세네스

function NPC_103520:OnDialogExit(Player, DialogID, ExitID)
	if (1030045 == DialogID) and (1 == ExitID) then
		Player:GateToMarker(103, 7)
	end
end
