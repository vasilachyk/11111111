function NPC_7501224:OnDialogExit(Player, DialogID, Exit)
	if (5010003 == DialogID and 1 == Exit) then -- 집행인방으로 워프
		Player:GateToMarker(501101, 113101)
	end
end