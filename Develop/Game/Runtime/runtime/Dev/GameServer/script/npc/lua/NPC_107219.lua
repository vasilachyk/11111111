-- ∂Û∆»

function NPC_107219:OnDialogExit(Player, DialogID, Exit)	
	if (1070512 == DialogID) then
		if (2 == Exit) then
			Player:UpdateQuestVar(107051, 3)	
		end
	end
end
