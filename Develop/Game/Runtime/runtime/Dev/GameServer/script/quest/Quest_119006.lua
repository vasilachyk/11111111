--지친 병사
function Quest_119006:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	local Field = Player:GetField()		

	if (ObjectiveID == 1)  then		
		
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		Field:SetTimer(119002,20,false)		
	end
	
	if (ObjectiveID == 2)  then		
		
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		Field:SetTimer(119002,20,false)		
		
	end
	
	if (ObjectiveID == 3)  then		
		
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		Field:SetTimer(119002,20,false)		
	end
	
	if (ObjectiveID == 4)  then		
		
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		Field:SetTimer(119002,20,false)		
		
	end
	
	if (ObjectiveID == 5)  then		
		
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		Field:SetTimer(119002,20,false)		
		
	end
	
	if (ObjectiveID == 6)  then		
		
		NPC:DisableInteraction()		
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,20,false)		
		
	end
	
	if (ObjectiveID == 7)  then		
		
		NPC:DisableInteraction()		
		NPC:GainBuff(111401)		
		
		Field:SetTimer(119002,20,false)				
	end
	
end


