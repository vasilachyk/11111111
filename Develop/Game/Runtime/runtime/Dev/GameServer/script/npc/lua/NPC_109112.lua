-- ¿µ¿õÀÇ µ¹

function NPC_109112:OnSpawn(SpawnInfo)
	this:GainBuff(110010)
end

function NPC_109112:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 109112) then
		if (ExitID == 1) then
			Player:GainBuff(110097)
		end
	end
end

