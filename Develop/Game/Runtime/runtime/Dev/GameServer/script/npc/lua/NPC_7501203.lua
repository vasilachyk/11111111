function NPC_7501203:OnDialogExit(Player, DialogID, Exit)
	if (5010001 == DialogID and 1 == Exit) then -- 집행인방으로 워프
		Player:GateToMarker(501101, 109101)
	end
end
