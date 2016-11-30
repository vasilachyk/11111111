-- 밀수선 함장 제너리

function NPC_109052:OnDialogExit(Player, DialogID, ExitID)
	if (109052 == DialogID) then
		if (1 == ExitID) then
			if (Player:GetSilver() >= 100) then
				Player:RemoveSilver(100)
				Player:GateToMarker(3,1)
			else
				this:Balloon("$$NPC_109052_10")
			end
		end	
	end
end



