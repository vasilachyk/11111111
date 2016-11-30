-- 귀환의 마법

function Quest_107100:OnObjComplete(Player, ObjectiveID, Trigger)
	if (ObjectiveID == 1) then
		Player:RemoveBuff(110023)
	end
end
