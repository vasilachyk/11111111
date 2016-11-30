-- 길들인 모아

function NPC_1234:OnDialogExit(Player, DialogID, ExitID)
	if (9920061 == DialogID) then
		if (1 == ExitID) then
			this:Balloon("$$Field_1_27")
			Player:GainBuff(111611)
		end
	end
	if (9920062 == DialogID) then
		if (1 == ExitID) then
			this:Balloon("$$Field_1_25")
			Player:GainBuff(111609)
		end
		if (2 == ExitID) then
			this:Balloon("$$Field_1_26")
			Player:GainBuff(111610)
		end
	end
end