
function Quest_998020:OnBegin(Player, NPC)
	
	local Field = Player:GetField()		
	local cursed_supply = Field:GetNPC(117221)
	
	Field:EnableSensor(21000)
	Field:EnableSensor(21001)
	Field:EnableSensor(21002)
	Field:EnableSensor(21003)
	Field:EnableSensor(21004)		

	
end



function Quest_998020:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	
	local Field = Player:GetField()	
	
	if (ObjectiveID == 1)  then		
		-- GLog("1 Line")
		NPC:DisableInteraction()		
		NPC:GainBuff(111103)
		NPC:RemoveBuff(111102)		
		Field:SetTimer(117048, 10, false)			
	end
	
	if (ObjectiveID == 2)  then		
		-- GLog("2 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111103)		
		NPC:RemoveBuff(111102)					
		Field:SetTimer(117048, 10, false)			
	end
	
	if (ObjectiveID == 3)  then		
		-- GLog("3 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111103)
		NPC:RemoveBuff(111102)		
		Field:SetTimer(117048, 10, false)			
	end
	
	if (ObjectiveID == 4)  then		
		-- GLog("4 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111103)
		NPC:RemoveBuff(111102)		
		Field:SetTimer(117048, 10, false)			
	end
	
	if (ObjectiveID == 5)  then		
		-- GLog("5 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111103)
		NPC:RemoveBuff(111102)
		Field:SetTimer(117048, 10, false)			
	end
		
	
	Player:Tip("$$Quest_998020_001")
	
end


