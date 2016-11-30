-- 하프메인 : 트라이얼 필드 -> 침식동으로

function NPC_116504:OnDialogExit(Player, DialogID, Exit)
	if (1160212 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(116001,20)
		end
	end
end




