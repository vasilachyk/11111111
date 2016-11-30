-- 서리 중간거점

function NPC_7102197:OnSpawn(SpawnInfo) 
	this:GainBuff(120071)	
end

function NPC_7102197:OnDie(DespawnInfo)
	this:RemoveBuff(120071)
end