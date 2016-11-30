-- 단 한번의 기회

function Quest_113113:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 3) then
		if (Trigger == true) then
			local Field = NPC:GetField()
			Player:Narration("$$Quest_113113_7")
			NPC:DisableInteraction()
			NPC:GainBuff(110034)
			Field:SpawnByID(113245)
			NPC:ScriptSelf("Quest_113113_DespawnSelf")			
		end
	end
end

function Quest_113113_DespawnSelf(Self)
	Self:Wait(6)
	Self:Despawn(true)
end
