function NPC_118261:OnSpawn(SpawnInfo)
	this:SetDecayTime(0)
	this:GainBuff(110010)
end

function NPC_118261:OnInteractionEnd(Player, InteractionID)	
	if (Player:CheckCondition(1180101) == true) then	
		Player:UpdateQuestVar(118010, 1)	
	end 	
end


