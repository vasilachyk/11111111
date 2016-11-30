function NPC_5000111:OnSpawn(Spawn)
	this:SetDecayTime(0);
end

function NPC_5000111:OnDialogExit(Player, DialogID, ExitID)
	if (5000112 == DialogID) and (1 == ExitID) then	
		this:ClearJob();
		
		this:DisableInteraction();
		this:EnableSensorCheck(4);		
		this:MoveToSensor(4);
		
	end	
end

function NPC_5000111:OnDie(Spawn)
	Field = this:GetField();
	
	
	Field:Despawn(5000112, false);
	
	
	
	Field:Despawn(5000113, false);
	
end
