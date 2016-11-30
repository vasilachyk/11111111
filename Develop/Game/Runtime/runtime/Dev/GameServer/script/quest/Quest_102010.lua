-- 누구에게나 중요한 인맥
function Quest_102010:OnObjComplete (Player, ObjectiveID)
	if (ObjectiveID == 1) then
		Player:Tip("$$Quest_102010_4")
	end
	if (ObjectiveID == 2) then
		Player:Tip("$$Quest_102010_7")
	end	
end
