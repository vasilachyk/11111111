function NPC_7102002:OnDialogExit(Player, DialogID, nExit)
	if (1022149 == DialogID) then
		if (1 == nExit) then
			this:NonDelayBalloon("$$NPC_102301")
		end
	end
end
