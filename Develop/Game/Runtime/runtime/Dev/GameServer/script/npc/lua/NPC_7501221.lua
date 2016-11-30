-- ¿µ¿õ ¼öµµ¿ø »õ³¢ ´Á´ë

function NPC_7501221:OnDialogExit(Player, DialogID, Exit)
	if (9920080 == DialogID and 1 == Exit) then 
		local Field = this:GetField()
		local Pos = vec3(3850.5, -3199.7, 3.3)
		if (Field:GetNPCCount(7501222) == 0) then
			Field:SpawnLimited(7501222, Pos, 300)
		end
		this:Despawn(true)
	end
end

