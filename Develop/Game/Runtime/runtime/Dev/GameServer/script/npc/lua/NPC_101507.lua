function NPC_101507:OnDialogExit(Player, DialogID, nExit)
	if (1010579 == DialogID) and (1 == nExit) then						
		this:UseTalent()		
	end
end