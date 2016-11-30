-- 베틀아레나 진행요원 먼지

function NPC_190004:OnDialogExit(Player, DialogID, Exit)
	if (1900040 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(190, 10)
			
		end
	end		
end
