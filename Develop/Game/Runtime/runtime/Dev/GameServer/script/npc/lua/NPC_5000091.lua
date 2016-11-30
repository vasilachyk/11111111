function NPC_5000091:OnSpawn(Spawn)
	if (1 == this:GetMode()) then
		this:SetDecayTime(0);
		this:GainBuff(5000090);	
	end
end

function NPC_5000091:OnChangeMode(BeforeMode, Mode)
	if (1 == BeforeMode) and (0 == Mode) then
		this:RemoveBuff(5000090);
	end
end

function NPC_5000091:OnTalentEnd(TalentID)
	if (300150090 == TalentID) then
		this:Despawn(true);
	end
end

function NPC_5000091:OnDie(Despawn)	
	if (1 == this:GetMode()) then
		Field = this:GetField();
		Pos = this:GetPos();
		Field:SpawnDelay(5000092, Pos, 3);
	end
end