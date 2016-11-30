function NPC_102153:OnCombatEnd()
		local Field = this:GetField();		
		local Prist = Field:GetNPC(102150);
		local Guard1 = Field:GetNPC(102152);
	
		if (true == Prist:IsNowCombat()) then
			this:Assist(Prist);
		elseif (true == Guard1:IsNowCombat()) then
			this:Assist(Guard1);
		end
end
