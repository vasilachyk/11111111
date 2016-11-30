-- 그냥 고양이를 사라고...

function Quest_991101:OnBegin(Player, NPC)
	Player:GainBuff(700007)
end
function Quest_991101:OnEnd(Player, NPC)
	Player:RemoveBuff(700007)
end


