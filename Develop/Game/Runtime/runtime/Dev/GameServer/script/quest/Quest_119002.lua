--투석기 공병
function Quest_119002:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	local Field = Player:GetField()		

	if (ObjectiveID == 1)  then		
		GLog("1 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		FIeld:SetTimer(119002,10,false)		
	end
	
	if (ObjectiveID == 2)  then		
		GLog("2 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)		
		
	end
	
	if (ObjectiveID == 3)  then		
		GLog("3 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)		
	end
	
	if (ObjectiveID == 4)  then		
		GLog("4 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)		
		
	end
	
	if (ObjectiveID == 5)  then		
		GLog("5 Line")
		NPC:DisableInteraction()
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)		
		
	end
	
	if (ObjectiveID == 6)  then		
		GLog("6 Line")
		NPC:DisableInteraction()		
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)		
		
	end
	
	if (ObjectiveID == 7)  then		
		GLog("6 Line")
		NPC:DisableInteraction()		
		NPC:GainBuff(111401)		
		
		FIeld:SetTimer(119002,10,false)				
	end
	
end


