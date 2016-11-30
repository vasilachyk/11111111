-- 리그 도우미

function NPC_5200020:OnDialogExit(Player, DialogID, Exit)
	if (5200040 == DialogID) then
		if (1 == Exit) then
			Player:SetAmity(125, 60000)
			Player:SetAmity(126, 5000)
			Player:GateToMarker(8010, 30)
		end
	end
	
	if (5200041 == DialogID) then
		if (1 == Exit) then
			Player:SetAmity(125, 5000)
			Player:SetAmity(126, 60000)
			Player:GateToMarker(8010, 31)
		end
	end

end

