function NPC_101228:OnDialogExit(Player, DialogID, nExit)
	if (1010175 == DialogID) and (1 == nExit) then				
		this:RemoveBuff(111201)
		local dice = math.random(140030,140032)
		this:UseTalentSelf(dice)		
		Player:UpdateQuestVar(101017, 4)				
	end
end