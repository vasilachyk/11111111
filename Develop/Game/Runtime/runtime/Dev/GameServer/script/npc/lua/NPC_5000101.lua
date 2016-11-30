function NPC_5000101:OnTalentEnd(TalentID)
	if (300150100 == TalentID) then
		Field = this:GetField();
		Field:DisableInteraction(5000102);	-- 상자 인터랙션 비활성화
		
		this:EnableInteraction();			-- 우솝 인터랙션 활성화	
		
		Player = this:GetLastInteractPlayer();
		if (true == Player:IsCompleteQuest(5000100)) then
			Pos = vec3(22860, 3636, 3);
			Field:Spawn(5000103, Pos);		--  고블린 소환			
		end		
	end	
end
