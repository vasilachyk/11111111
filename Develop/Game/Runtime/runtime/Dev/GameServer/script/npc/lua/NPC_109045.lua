-- ¸ÚÀïÀÌ ¸ðµå

function NPC_109045:OnCraft(Player, RecipeID)
	if (RecipeID == 63002) or (RecipeID == 63012) then
		Player:UpdateQuestVar(109061 ,1)	
	end		
	if (RecipeID == 63004) or (RecipeID == 63013) then
		Player:UpdateQuestVar(109061 ,2)	
	end		
	if (RecipeID == 63005) or (RecipeID == 63015) then
		Player:UpdateQuestVar(109061 ,3)	
	end			
end
