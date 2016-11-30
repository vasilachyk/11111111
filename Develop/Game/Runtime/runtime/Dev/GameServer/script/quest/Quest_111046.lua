-- 드래곤을 불태워라!

--[[function Quest_111046:OnBegin(Player, NPC)
	this:UpdateVar(1)
end--]]

--function Quest_111046:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
function Quest_111046:OnObjComplete(Player, ObjectiveID, Trigger)
	if (ObjectiveID == 1) then
		Player:NarrationNow("$$Field_111_29",3.0)			-- 슈나크의 시체를 불태웠습니다.
		local Field = Player:GetField()
		local Wing = Field:GetSpawnNPC(111213)
		local Head = Field:GetSpawnNPC(111216)
		local Body = Field:GetSpawnNPC(111217)	
		Wing:GainBuff(110040)
		Head:GainBuff(110040)
		Body:GainBuff(110040)	
		Wing:DisableInteraction()
		Head:DisableInteraction()		
		Body:DisableInteraction()
		Wing:SetTimer(1, 15, false)
		Head:SetTimer(1, 15, false)		
		Body:SetTimer(1, 15, false)
	end
end
