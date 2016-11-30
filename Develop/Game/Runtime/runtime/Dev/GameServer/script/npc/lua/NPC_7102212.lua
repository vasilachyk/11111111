-- 이동술사 케이트

function NPC_7102212:OnDialogExit(Player, DialogID, ExitID)
	if (7102212 == DialogID) then
		if (1 == ExitID) then
			Player:GateToMarker(1, 1210)
			this:Balloon("$$NPC_1210_1")
		end	
	end
end



