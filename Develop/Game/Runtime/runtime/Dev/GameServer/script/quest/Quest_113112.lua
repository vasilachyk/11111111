-- 죽고 싶지 않아

function Quest_113112:OnBegin(Player, NPC)
	if (Player:GetFieldID() == 113001) or (Player:GetFieldID() == 113002) then
		Player:Narration("$$Quest_113112_5")
	end
end

function Quest_113112:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			if (NPC:CheckBuff(110005) == true) then
				NPC:DisableInteraction()
				NPC:FaceTo(Player)
				--NPC:UseTalentSelf(211021801)
				NPC:RemoveBuff(110005)
				NPC:SetAlwaysRun(true)
				

				if (NPC:GetID() == 113235) then
					local dice = math.random(0,4)
					if( dice == 0) then 
						NPC:Balloon("$$Quest_113112_23")
					end
					if( dice == 1) then 
						NPC:Balloon("$$Quest_113112_26")
					end
					if( dice == 2) then 
						NPC:Balloon("$$Quest_113112_29")			
					end		
					if( dice == 3) then 
						NPC:Balloon("$$Quest_113112_32")
					end
					if( dice == 4) then 
						NPC:Balloon("$$Quest_113112_35")
					end				
					NPC:KillTimer(1)
					NPC:MoveToMarker(1)
					NPC:ScriptSelf("Quest_113112_DespawnSelf")			
				end
			end	
		end
	end
end

function Quest_113112_DespawnSelf(Self)
	Self:Despawn(true)
end
