-- 보급 방해

function Quest_110007:OnObjInteract(Player, ObjectiveID, Progress, Trigger, NPC)
	
	if (2 == ObjectiveID) then												-- NPC : 물항아리 110040
		NPC:DisableInteraction()
		NPC:GainBuff(110045)
	end
end

