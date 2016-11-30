-- 광기 중간거점

function NPC_7102195:OnSpawn(SpawnInfo) 
	this:GainBuff(120070)	
end

function NPC_7102195:OnDie(DespawnInfo)
	this:RemoveBuff(120070)
end