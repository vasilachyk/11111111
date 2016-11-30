function NPC_1181:OnSpawn(SpawnInfo)
 
 local Field = this:GetField() 
 
	this:GainBuff(40904)
	this:SayNow("$$NPC_1181_001")
	
	-- Field:DisableSensor(1181)	
end

function NPC_1181:OnDie(DespawnInfo)	
	this:SetDecayTime(10)	
end

