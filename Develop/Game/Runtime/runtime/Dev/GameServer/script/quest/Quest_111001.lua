-- 숨겨놓은 것

function Quest_111001:OnObjComplete(Player, ObjectiveID, Trigger)
	if (ObjectiveID == 1) then
		Player:Cutscene(111001)
	end
end

