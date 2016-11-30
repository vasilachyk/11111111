-- 트롤에 불을 붙혀라

function Quest_113123:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			NPC:GainBuff(110028)
			NPC:ScriptSelf("Quest_113123_TrollBurning")
		end
	end
end

function Quest_113123_TrollBurning(Self)
	NPC:Despawn(true)	
end