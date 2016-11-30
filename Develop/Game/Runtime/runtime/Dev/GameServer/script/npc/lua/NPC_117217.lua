
function NPC_117217:OnDialogExit(Player, DialogID, Exit)
	if (1170142 == DialogID) and (1 == Exit) then
		
		Player:UpdateQuestVar(117014, 1)
		
	end		

end
