-- ¼Ò¸¦ À§ÇÑ ´Á´ëÀÇ Èñ»ý

function Quest_107052:OnBegin(Player, NPC)
	Player:Tip("$$Quest_107052_1")
	Player:GainBuff(110105)
end
function Quest_107052:OnEnd(Player, NPC)
	Player:RemoveBuff(110105)
end