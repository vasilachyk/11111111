-- 세 번째 재료 - 봉인의 가지

function Quest_109016:OnEnd(Player, NPC)
	if (Player:CheckCondition(1090149) == true) and (Player:CheckCondition(1090159) == true) then
		if (Player:CheckBuff(110097) == true) then
			Player:RemoveBuff(110097)
		end
	end
end