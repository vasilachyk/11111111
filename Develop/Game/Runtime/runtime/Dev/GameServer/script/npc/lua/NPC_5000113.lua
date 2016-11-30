function NPC_5000113:OnDie(Desapwn)
	Field = this:GetField();
	if (0 == Field:GetNPCCount(5000113)) then
		EscortNPC = Field:GetNPC(5000111);
		
		this:ClearJob();
		
		-- 전투가 끝났을때 BehaviorMode로 넣은 잡은 삭제 되서, MissionMode로 넣음
		
		EscortNPC:Say("$$NPC_5000113_10");
		EscortNPC:EnableSensorCheck(6);	
		EscortNPC:MoveToSensor(6);		

	end	
end
