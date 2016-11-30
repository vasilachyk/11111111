-- 의무병 루미노르

function NPC_110202:OnDialogExit(Player, DialogID, ExitID)
	if (1100409 == DialogID) and (1 == ExitID) then
		this:NonDelayBalloon("$$NPC_110202_5")
	end
end
