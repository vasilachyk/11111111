
function NPC_104280:OnDialogExit(Player, DialogID, Exit)
	if (1040142 == DialogID) and (1 == Exit) then 	
		Player:UpdateQuestVar(104014, 1)	
	end
end
