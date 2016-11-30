-- 정령신주

function Quest_116030:OnEnd(Player, NPC) -- 퀘스트를 완료할 때 트라이얼 필드에 있다면 공용 필드로 보내준다.
	if (Player:GetFieldID() == 1160301) then
		Player:GateToMarker(116004, 2)
	end
end

