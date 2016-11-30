-- ¸¶Á¨Å¸

function NPC_109023:OnDialogExit(Player, DialogID, Exit)
	if (1090911 == DialogID) then
		if (1 == Exit) then
			Player:UpdateQuestVar(109015, 2)
		end	
	end
end
