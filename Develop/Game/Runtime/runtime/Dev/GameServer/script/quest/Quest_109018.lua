-- 결사의 방어

function Quest_109018:OnBegin(Player, NPC)
	if (Player:GetFieldID() == 109001) then
		Player:GateToTrial(1091040, true)
	end
	if (Player:GetFieldID() == 109) then
		Player:GateToMarker(109001, 109059)
	end	
end

function Quest_109018:OnEnd(Player, NPC)
	if (Player:GetFieldID() == 109001) then
		Player:GateToMarker(109, 1090189)
	end
end