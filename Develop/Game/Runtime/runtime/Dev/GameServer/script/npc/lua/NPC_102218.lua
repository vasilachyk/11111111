-- 용병 모집관 (일반 에다산)

function NPC_102218:OnDialogExit(Player, DialogID, ExitID)
	if (1020150 == DialogID) then
		if (1 == ExitID) then
			Player:SetAmity(115, 27001)
			Player:SetAmity(116, 27001)
			Player:GainBuff(110014)
		end	
	end
end



