-- 사무원 마이어

function NPC_3028:OnDialogExit(Player, DialogID, ExitID)
	if (3028 == DialogID) then
		if (1 == ExitID) then
			if (Player:GetSilver() >= 600) then
				Player:RemoveSilver(600)
				Player:GateToMarker(109,30)
			else
				Player:Tip("$$NPC_3028_10")
			end
		end	
	end
end



