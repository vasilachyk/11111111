---수상한 움직임 117025

function NPC_1183:OnSpawn(SpawnInfo)
 
 local Field = this:GetField() 
 
	this:GainBuff(40904)
	this:SayNow("$$NPC_1183_001")
	-- Field:DisableSensor(1183)	
end

function NPC_1183:OnDie(DespawnInfo)  	
	this:SetDecayTime(10)	
end

