-- 베틀아레나 진행요원 미젤란

function NPC_190002:OnDialogExit(Player, DialogID, Exit)
	if (1900020 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(190, 11)
			
		end
	end		
end
