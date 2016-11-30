-- ∑Á∆€Ω∫
function NPC_3050:Init(NPCID)
	
end

function NPC_3050:OnDialogExit(Player, DialogID, Exit)
	if (30061 == DialogID) then
		if (1 == Exit) then
			Player:UpdateQuestVar(3006, 2)
		end
	end
end
