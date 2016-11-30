-- 할로윈이벤트 이동술사 앰버

function NPC_3315:OnDialogExit(Player, DialogID, ExitID)
	if (1212 == DialogID) then
		if (1 == ExitID) then
			Player:GateToMarker(3, 30606)			
		end	
	end
end



