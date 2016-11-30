-- 무기 제작자 아인델

function NPC_3003:OnCraft(Player, RecipeID)
	if (RecipeID == 60820000) or (RecipeID == 60820100) or (RecipeID == 60820200) or (RecipeID == 60820300) or (RecipeID == 60820400) or (RecipeID == 60820700) then
		Player:UpdateQuestVar(3012 ,1)	
	end	
end
