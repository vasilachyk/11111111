-- 대장장이 로코

function NPC_109005:OnCraft(Player, RecipeID)
	if (RecipeID == 73000) or (RecipeID == 73001) or (RecipeID == 73002) or (RecipeID == 73004) or (RecipeID == 73005) or (RecipeID == 73007) then
		Player:UpdateQuestVar(109004 ,3)
		Player:UpdateQuestVar(109004 ,2)
		Player:Cutscene(109004)
	end
	if (RecipeID == 74000) or (RecipeID == 74001) or (RecipeID == 74002) or (RecipeID == 74003) or (RecipeID == 74004) or (RecipeID == 74005) then
		Player:UpdateQuestVar(109057 ,3)	
		Player:UpdateQuestVar(109057 ,2)
	end		
end

function NPC_109005:OnRecipe(Player, RecipeID)
	if (RecipeID == 73000) or (RecipeID == 73001) or (RecipeID == 73002) or (RecipeID == 73004) or (RecipeID == 73005) or (RecipeID == 73007) then
		Player:UpdateQuestVar(109004 ,2)	
	end	
	if (RecipeID == 74000) or (RecipeID == 74001) or (RecipeID == 74002) or (RecipeID == 74003) or (RecipeID == 74004) or (RecipeID == 74005) then
		Player:UpdateQuestVar(109057 ,2)	
	end	
end
