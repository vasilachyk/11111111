-- 마력의 정체

function Quest_111021:OnBegin(Player, NPC)
	local Field = Player:GetField()

	Field:SpawnByID(1112591)
	Field:SpawnByID(1112592)
	Field:SpawnByID(1112593)	
end
