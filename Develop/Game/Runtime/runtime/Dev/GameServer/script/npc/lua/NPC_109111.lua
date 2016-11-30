-- 모켄의 대포

function NPC_109111:OnSpawn(SpawnInfo)
	this:SetDecayTime(0)
	this:GainBuff(110010)
end

function NPC_109111:OnDialogExit(Player, DialogID, ExitID)
	if (DialogID == 109111) then
		if (ExitID == 1) then
			Player:GainBuff(110094)
			this:Despawn(true)
		end
	end
end