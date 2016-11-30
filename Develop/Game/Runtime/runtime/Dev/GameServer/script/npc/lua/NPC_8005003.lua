-- 베틀아레나 진행요원 미젤란

function NPC_8005003:OnDialogExit(Player, DialogID, Exit)
	if (8005003 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(8005, 11)
			
		end
	end		
end
