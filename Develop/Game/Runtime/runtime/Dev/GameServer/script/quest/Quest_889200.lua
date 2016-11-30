-- PAX ¿¤·ç°¡Äù½ºÆ®

function Quest_889200:OnBegin(Player, NPC)
	if (Player:GetFieldID() == 8895) then
		Player:GateToTrial(8896, true)
	end
end

--function Quest_889200:OnComplete(Player, NPC)
--	if (Player:GetFieldID() == 8896) then
		--Player:GateToMarker(8895, 1)
	--end
--end