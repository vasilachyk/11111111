-- ·³ÁÖÅë

function NPC_109031:OnSpawn(SpawnInfo)
	this:SetDecayTime(40)
end

function NPC_109031:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Damage > 10) then
		HitInfo.Victim:GainBuff(110014)
		--this:Say("$$NPC_109031_10")
		--[[this:Yell(800)
		local Position = DespawnInfo.Pos
		local Field = DespawnInfo.Field
		Field:Spawn(109032, Position)
		this:Despawn(true)--]]
	end
end
