--포자 버섯 불태우기
function Quest_121102:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	
	local Field = Player:GetField()
	
	for i = 1 , 6 do
		if (ObjectiveID == i) then
			if (Trigger == true) then
				if (NPC:CheckBuff(116701) == true) then
					GLog("diableInteraction")
					NPC:DisableInteraction()
					GLog("gainbuff")					
					NPC:GainBuff(116700)
					NPC:GainBuff(116702)
					GLog("removebuff")					
					NPC:RemoveBuff(116701)
					-- Field:SetTimer(12110200, 10, false)					
					-- NPC:ScriptSelf("Quest_113102_DespawnSelf")				
				end
			end	
		end
	end
end

-- function Quest_113102_DespawnSelf(Self)
	-- Self:Despawn(true)
-- end