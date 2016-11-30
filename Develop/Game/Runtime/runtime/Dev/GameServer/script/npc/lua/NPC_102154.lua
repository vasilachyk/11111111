function NPC_102154:OnCombatEnd()	
		local Field = this:GetField();		
		local Prist = Field:GetNPC(102151);
		local Guard2 = Field:GetNPC(102155);
		
		if (true == Prist:IsNowCombat()) then
			this:Assist(Prist);
		elseif (true == Guard2:IsNowCombat()) then
			this:Assist(Guard2);	
		end		
end
