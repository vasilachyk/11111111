
function NPC_117232:OnDialogExit(Player, DialogID, Exit)
	if (1170062 == DialogID) and (1 == Exit) then
		
		Player:UpdateQuestVar(117006, 1)
		
	end		

end
