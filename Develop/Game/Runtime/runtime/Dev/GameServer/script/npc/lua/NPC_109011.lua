-- 실버 (공용필드)

function NPC_109011:OnDialogExit(Player, DialogID, Exit)
	if (1090181 == DialogID) then
		if (1 == Exit) then
			Player:GateToTrial(1091040, true)
		end
	end
end
