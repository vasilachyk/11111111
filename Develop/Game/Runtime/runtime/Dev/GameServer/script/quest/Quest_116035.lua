-- 통제불가능한 힘

function Quest_116035:OnComplete(Player)
	local Field = Player:GetField()

	Field:SpawnByID(1000)
	Field:SpawnByID(1001)
	Field:SpawnByID(1002)	
end


