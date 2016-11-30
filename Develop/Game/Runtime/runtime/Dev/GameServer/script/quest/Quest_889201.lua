-- PAX 디아고퀘스트

function Quest_889201:OnBegin(Player, NPC)
	if (Player:GetFieldID() == 8895) then
		Player:GateToTrial(8897, true)
	end
end

--function Quest_889201:OnComplete(Player, NPC)
--	if (Player:GetFieldID() == 8897) then
--		Player:GateToMarker(8895, 1)
--	end
--end