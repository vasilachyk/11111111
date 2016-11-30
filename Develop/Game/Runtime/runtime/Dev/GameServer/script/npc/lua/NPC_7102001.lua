function NPC_7102001:OnDialogExit(Player, DialogID, nExit)
	if (1022139 == DialogID) then
		if (1 == nExit) then
			this:NonDelayBalloon("$$NPC_102300")
		end
	end
end
