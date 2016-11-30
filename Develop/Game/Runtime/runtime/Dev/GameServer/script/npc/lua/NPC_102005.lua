-- 트롤 광기의 눈 부족 족장 발로르

function NPC_102005:OnDialogExit(Player, DialogID, Exit)
	if (1020162 == DialogID) then
		if (1 == Exit) then
			Player:Tip("$$NPC_102005_6")
			Player:UpdateQuestVar(102016, 2)	
			Player:GainBuff(110029)
		end
	end
	if (1020163 == DialogID) then
		if (1 == Exit) then
			Player:GainBuff(110029)
		end
	end	
end
