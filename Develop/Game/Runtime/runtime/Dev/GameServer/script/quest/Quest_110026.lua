-- 이공계 기피 현상

function Quest_110026:OnObjComplete(Player, ObjectiveID, Trigger)
	if (ObjectiveID == 1) then
		Player:Tip("$$Quest_110026_5")
		--Player:RemoveItem(10020, 1)
	end
	if (ObjectiveID == 2) then
		Player:Tip("$$Quest_110026_9")
		--Player:RemoveItem(10020, 1)
	end
	if (ObjectiveID == 3) then
		Player:Tip("$$Quest_110026_13")
		--Player:RemoveItem(10020, 1)
	end	
end
