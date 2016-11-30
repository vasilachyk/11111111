
function NPC_1180:OnSpawn(SpawnInfo)
 
	local Field = this:GetField() 
 
	this:GainBuff(40904)
	this:SayNow("$$NPC_1180_001")
	
	-- Field:DisableSensor(1180)	
end

function NPC_1180:OnDie(DespawnInfo) 		
	this:SetDecayTime(10)	
end

