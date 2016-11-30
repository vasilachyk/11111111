function Quest_5000100:OnObjComplete(Player, ObjectiveID)
	if (1 == ObjectiveID) then		
		NPC = Player:GetInteractNPC();
		NPC:DisableInteraction();			-- 우솝 인터랙션 비활성화
		NPC:UseTalentSelf(300150100);		-- 우솝 춤추는 탤런트 사용		
		
		Field = NPC:GetField();
		Field:EnableInteraction(5000102);	-- 상자 인터랙션 활성화
	end	
end
