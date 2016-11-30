-- 오우거 흰색 예티 부족 족장 락크러셔

function NPC_102006:OnDialogExit(Player, DialogID, Exit)
	if (1020172 == DialogID) then
		if (1 == Exit) then
			Player:Tip("$$NPC_102006_6")
			Player:UpdateQuestVar(102017, 2)	
			Player:GainBuff(110030)			
		end
	end
	if (1020173 == DialogID) then
		if (1 == Exit) then	
			Player:GainBuff(110030)			
		end
	end	
end
