-- 렌델 순간이동술사

function NPC_110304:OnDialogExit(Player, DialogID, ExitID)
	if (1100002 == DialogID) and (1 == ExitID) then -- 인젠으로
		Player:GateToMarker(3, 2)
	end
	if (1100002 == DialogID) and (2 == ExitID) then -- 렌고트로
		Player:GateToMarker(110, 1)
	end
	if (1100002 == DialogID) and (3 == ExitID) then -- 영웅의 오솔길로
		Player:GateToMarker(113, 1)
	end	
end
