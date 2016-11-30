-- 용병 모집관 (에픽 에다산)

function NPC_7102211:OnDialogExit(Player, DialogID, ExitID)
	if (1022120 == DialogID) then
		if (1 == ExitID) then
			Player:SetAmity(7115, 27001)
			Player:SetAmity(7116, 27001)
			Player:GainBuff(110014)
		end	
	end
end



