function NPC_1182:OnSpawn(SpawnInfo)
 
 local Field = this:GetField() 
 
	this:GainBuff(40904)
	this:SayNow("$$NPC_1182_001")
	
	-- Field:DisableSensor(1182)	
end

function NPC_1182:OnDie(DespawnInfo)	
	this:SetDecayTime(10)	
end

