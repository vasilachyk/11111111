-- 영혼의 구슬(A)로 소환된 아이젠트 트리어

function NPC_113215:OnSpawn(SpawnInfo) -- 소환됨
	SpawnInfo.NPC:GainBuff(110090)
	local Pos = SpawnInfo.NPC:GetPos()
	local Dir = SpawnInfo.NPC:GetDir()
	local Point = Math_GetDistancePoint(Pos, Dir, 300)
	SpawnInfo.NPC:Move(Point)
end


