
function NPC_117219:OnDialogExit(Player, DialogID, Exit)
	if (1170172 == DialogID) and (1 == Exit) then
		
		Player:UpdateQuestVar(117017, 1)
		
	end		

end
