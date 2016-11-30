-- ¿Ã∑π¿Œ

--[[
function NPC_3030:OnDialogExit(Player, DialogID, Exit)
	if (30062 == DialogID) then
		if (2 == Exit) then
			Player:Tip("$$NPC_3030_7")
			Player:UpdateQuestVar(3006, 3)			
			Interaction(Player, 3030, "quest_end", 3001)
		end
		if (2 == nExit) then
			Player:UpdateQuestVar(3001, 2)
			Player:GateToInnRoom()
		end
	end
	if (30018 == nDialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(3001, 3)
			this:Balloon("$$NPC_3030_19")
			Interaction(Player, 3030, "quest_end", 3001)
		end
	end
end--]]
