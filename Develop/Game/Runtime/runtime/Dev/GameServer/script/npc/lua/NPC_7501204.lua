function NPC_7501204:OnDialogExit(Player, DialogID, Exit)
	if (5012040 == DialogID and 1 == Exit) then 
		Player:Tip("$$NPC_7501204_001")	
	end
end
