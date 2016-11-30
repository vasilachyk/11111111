-- 지스타 : 상급기사 세네스

function NPC_131006:OnDialogExit(Player, DialogID, ExitID)
	if (8891011 == DialogID) and (1 == ExitID) then
		Player:GateToMarker(8891, 1)
	end
end
