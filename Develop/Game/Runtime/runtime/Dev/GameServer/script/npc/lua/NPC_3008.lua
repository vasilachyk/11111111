-- 탐험가 상점 : 탐험용품 상인

function NPC_3008:OnDialogExit(Player, DialogID, Exit)
	if (30201 == DialogID) then
		if (5 == Exit) then
			Player:UpdateQuestVar(3020, 5)	
		end
	end	
end
