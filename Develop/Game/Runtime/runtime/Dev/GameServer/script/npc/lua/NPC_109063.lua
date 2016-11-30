-- 목장 주인 에슈리카

function NPC_109063:OnDialogExit(Player, DialogID, ExitID)
	if (1090132 == DialogID) then
		if (1 == ExitID) then
			if (Player:GetSilver() >= 60) then
				Player:RemoveSilver(60)
				Player:GainBuff(110096)
				Player:UpdateQuestVar(109013, 2)
			else
				this:Balloon("$$NPC_109063_11")
			end
		end	
	end
end



