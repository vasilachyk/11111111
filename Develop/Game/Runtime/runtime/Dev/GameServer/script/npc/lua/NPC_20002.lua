function NPC_20002:OnDialogExit(Player, DialogID, ExitID)
	if (9999999 == DialogID) and (1 == ExitID) then
		this:AttachObserveDuel(Player)
	end
	if (9999999 == DialogID) and (2 == ExitID) then
		this:DetachObserveDuel(Player)
	end
end
