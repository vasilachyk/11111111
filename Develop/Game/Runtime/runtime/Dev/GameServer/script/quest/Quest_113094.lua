-- ±∏√‚

function Quest_113094:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			if (NPC:CheckBuff(110000) == true) then
				NPC:DisableInteraction()
				NPC:RemoveBuff(110000)
				NPC:FaceTo(Player)
				NPC:SetAlwaysRun(true)
				
				if (NPC:GetID() == 113238) then
					NPC:Balloon("$$Quest_113094_13")	
					NPC:Balloon("$$Quest_113094_14")
					NPC:MoveToMarker(113094)
					NPC:ScriptSelf("Quest_113094_DespawnSelf")
				end
			end	
		end
	end
end

function Quest_113094_DespawnSelf(Self)
	Self:Despawn(true)
end