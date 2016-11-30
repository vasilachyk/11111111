-- 건강 검진 - 마력 단층 촬영

function Quest_101011:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			if Player:CheckBuff(110046) == false then
				Player:GainBuff(110046)
			end
		end
	end
end
