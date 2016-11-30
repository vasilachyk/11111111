-- 영역 확인

function Quest_101015:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 2) then
		if (Trigger == true) then
			Player:GainBuff(110048)
		end
	end
end