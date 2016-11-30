-- 베틀아레나 진행요원 루나

function NPC_190003:OnDialogExit(Player, DialogID, Exit)
	if (1900030 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(1, 5)
			
		end
	end		
end
