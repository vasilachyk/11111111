-- 함장 레온

function NPC_109002:OnDialogExit(Player, DialogID, Exit)
	if (30021 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(3, 1) -- 인젠으로 보내고 소울 바인드
			Player:BindSoul(7)
		end
	end
	if (30023 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(3, 1)
			Player:BindSoul(7)
		end
	end	
end
