-- πÃµÈ≈œ
--[[
function NPC_109025:OnDialogExit(Player, DialogID, Exit)
	if (1090064 == DialogID) then
		if (1 == Exit) then
			Player:UpdateQuestVar(109006, 1)
		end
	end
end
--]]