-- 베틀아레나 관리인 카를로스

function NPC_190001:OnDialogExit(Player, DialogID, Exit)
	if (1900010 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(190, 1)
			
		end
	end		
end
