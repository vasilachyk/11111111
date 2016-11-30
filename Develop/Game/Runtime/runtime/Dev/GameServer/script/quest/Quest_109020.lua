-- 복수의 불길 

function Quest_109020:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)			-- 보트 불태우기
	if (Trigger == true) then
		if (NPC:CheckBuff(110099) == false) then
			NPC:GainBuff(110099)
		end
	end
end


