-- ¥Î¿Â¿Â¿Ã ∏∆µµ≥⁄

function NPC_107221:OnDialogExit(Player, DialogID, Exit)
	--GLog0("NPC_0107221:OnDialogExit\n")
	
	if (1070481 == DialogID) then
		if (2 == Exit) then
			Player:UpdateQuestVar(107048, 2)	
		end
	end
end
