-- 나의 재능이 두려워

function Quest_992001:OnBegin(Player, NPC)
	Player:GainBuff(111506)
	--Player:UpdateVar(3)
end
function Quest_992001:OnEnd(Player, NPC)
	Player:RemoveBuff(111506)
end


