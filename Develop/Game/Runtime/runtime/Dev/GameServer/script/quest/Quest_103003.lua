-- 놓지마 정신줄	

function Quest_103003:OnObjComplete(Player, ObjectiveID)	
	if (ObjectiveID == 2) then
		--GLog("5Line ObjComplete\n")
		local Pos = Player:GetPos()
		local Dir = Player:GetDir()
		local Point = Math_GetDistancePoint(Pos, Dir, 400)
		local Field = Player:GetField()
		Field:Spawn(103513, Point)
	end
end
