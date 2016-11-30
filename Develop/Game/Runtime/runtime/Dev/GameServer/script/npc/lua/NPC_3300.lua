function NPC_3300:OnDialogExit(Player, DialogID, nExit)
	if (3300 == DialogID) then
		if (1 == nExit) then
			Player:ArenaRegister("1vs1");
		elseif (2 == nExit) then
			Player:ArenaRegister("3vs3");
		elseif (3 == nExit) then
			Player:ArenaRegister("5vs5");
		end
	end
end
