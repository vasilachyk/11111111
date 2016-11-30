--[[

function Quest_118008:OnBegin(Player, NPC)
	Player:UpdateQuestVar(118008, 1)
end
	
	
	]]--
	
function Quest_118008:OnComplete(Player)
	Player:Tip("$$Quest_118008_002")	
end