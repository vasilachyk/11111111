-- Ã¹ ¹øÂ° Àç·á - ºÀ·Ú¼®

function Quest_109014:OnEnd(Player, NPC)
	if (Player:CheckCondition(1090159) == true) and (Player:CheckCondition(1090169) == true) then
		if (Player:CheckBuff(110097) == true) then
			Player:RemoveBuff(110097)
		end
	end
end