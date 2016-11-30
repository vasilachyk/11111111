-- 보트 (남쪽에 있는)

function NPC_109033:OnDialogExit(Player, DialogID, Exit)
	if (1091012 == DialogID) then
		if (1 == Exit) then
			Player:Cutscene(109033)
		end
	end
end
