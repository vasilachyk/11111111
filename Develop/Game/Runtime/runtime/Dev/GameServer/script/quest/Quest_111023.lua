-- 떠나지 못한 자의 슬픔

function Quest_111023:OnBegin(Player, NPC)
	local Field = Player:GetField()
	local Ghost = Field:GetSpawnNPC(111211)
	local Pos = Ghost:GetPos()
	Ghost:Balloon("$$Field_111_30",2.5)			-- 단장이 있는 곳까지 인도해 드리지요.
	Field:SpawnDelay(111212, Pos, 4)
	Ghost:Balloon("$$Field_111_28",2.0)			-- 이 불빛을 따라가십시오.
end
