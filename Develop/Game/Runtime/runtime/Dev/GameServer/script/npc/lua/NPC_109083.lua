-- 보트 (북쪽에 있는)

function NPC_109083:OnDialogExit(Player, DialogID, Exit)
	if (1091015 == DialogID) then
		if (1 == Exit) then
			Player:Cutscene(109036)
		end
	end
end
