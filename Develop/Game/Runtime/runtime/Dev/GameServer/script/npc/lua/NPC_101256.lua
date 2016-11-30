function NPC_101256:OnDialogExit(Player, DialogID, nExit)
	if (1010522 == DialogID) then
		if (1 == nExit) then
			local Pos = vec3(54410.0, 8496.7, 4097.5)
			Player:Warp(Pos)
		end
	end
end
