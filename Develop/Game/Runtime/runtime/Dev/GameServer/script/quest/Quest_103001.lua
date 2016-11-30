-- 배신자 처단

function Quest_103001:OnEnd(Player, NPC)	
	local Field = Player:GetField()
	Field:EnableSensor(103004)
end

