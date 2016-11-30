-- 고대의 유물

function Quest_111041:OnBegin(Player, NPC)
	this:UpdateVar(1)
end

function Quest_111041:OnComplete(Player)
	local Field = Player:GetField()
	local Pos = Player:GetPos()
	Field:SpawnLimited(111303, Pos, 60)
	Player:Tip("방금 전의 충격으로 숨겨져있던 금속판이 떨어집니다!")
end