-- 의식의 돌

function NPC_109106:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 109112) then
		if (ExitID == 1) then
			Player:GainBuff(110097)
		end
	end
end

