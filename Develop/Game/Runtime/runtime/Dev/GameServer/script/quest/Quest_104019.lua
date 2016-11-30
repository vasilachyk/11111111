function Quest_104019:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)	
	if (ObjectiveID == 1)  then			
		local Field = Player:GetField()		
		NPC:UseTalentSelf(140612)		
		Field:SetTimer(1040190, 5, false)
	end
end


-- 고통의 문 파괴  -- 도르레 사용하면 고통의 군주 파닥스 스폰
function Quest_104019:OnObjComplete(Player, ObjectiveID)	
	if (ObjectiveID == 1) then		
		local Field = Player:GetField()		
		Field:SpawnByID(104190, Point)				
		Player:Tip("$$Quest_104019_001")  --Player:Tip("고통의 군주가 출현하였습니다.")
	end
end
