-- 베틀아레나 진행요원 루나

function NPC_8005004:OnDialogExit(Player, DialogID, Exit)
	if (8005004 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(107, 107242)
			
		end
	end		
end
