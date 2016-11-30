-- 동료 구출

function Quest_113102:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			if (NPC:CheckBuff(110000) == true) then
				NPC:DisableInteraction()		
				NPC:FaceTo(Player)
				--NPC:UseTalentSelf(211021801)
				NPC:RemoveBuff(110000)
				NPC:SetAlwaysRun(true)
				

				if (NPC:GetID() == 113228) then
					local dice = math.random(0,3)
					if( dice == 0) then 
						NPC:Balloon("$$Quest_113102_17")
					end
					if( dice == 1) then 
						NPC:Balloon("$$Quest_113102_20")
					end
					if( dice == 2) then 
						NPC:Balloon("$$Quest_113102_23")			
					end		
					if( dice == 3) then 
						NPC:Balloon("$$Quest_113102_26")
					end
					NPC:KillTimer(1)
					NPC:ScriptSelf("Quest_113102_DespawnSelf")				
				end
			end	
		end
	end
end

function Quest_113102_DespawnSelf(Self)
	Self:Despawn(true)
end