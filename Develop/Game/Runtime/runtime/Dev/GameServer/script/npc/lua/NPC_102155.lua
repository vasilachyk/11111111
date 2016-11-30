function NPC_102155:OnCombatEnd()
		local Field = this:GetField();				
		local Prist = Field:GetNPC(102151);
		local Guard1 = Field:GetNPC(102154);	
		
		if (true == Prist:IsNowCombat()) then
			this:Assist(Prist);
		elseif (true == Guard1:IsNowCombat()) then
			this:Assist(Guard1);			
		end
end
