-- 택배 왔습니다. 

function Quest_3010:OnObjComplete(Player, ObjectiveID, Trigger)
	if (Player:CheckCondition(30107) == true) then
		if (ObjectiveID == 1) then
			Player:Tip("$$Quest_3010_12")
		elseif (ObjectiveID == 2) then
			Player:Tip("$$Quest_3010_14")
		elseif (ObjectiveID == 3) then
			Player:Tip("$$Quest_3010_16")
		end	
	end
end

