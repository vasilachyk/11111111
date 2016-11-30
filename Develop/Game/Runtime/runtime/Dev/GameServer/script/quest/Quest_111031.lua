-- 암호 해독

function Quest_111031:OnEnd(Player, NPC)
	NPC:RunFieldEvent("Decode")
end
