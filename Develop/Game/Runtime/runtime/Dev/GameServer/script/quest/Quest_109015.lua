-- 두 번째 재료 - 마력로

function Quest_109015:OnEnd(Player, NPC)
	if (Player:CheckCondition(1090149) == true) and (Player:CheckCondition(1090169) == true) then
		if (Player:CheckBuff(110097) == true) then
			Player:RemoveBuff(110097)
		end
	end
end

function Quest_109015:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)	
	if (Trigger == true) then
		NPC:GainBuff(110100)
	end
end

--[[ 
구버전 돛대 퀘스트 - 모닥불에 불 붙이기
function Quest_109015:OnObjProgress(Player, ObjectiveID, Trigger)	
	local Field = Player:GetField()	
	local NorthFire = Field:GetNPC(109115)	
	local NpcPos = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )		
	
	--GLog( "OnObjProgress\n")
	if (Trigger == true) then
		if (ObjectiveID == 2 and NorthFire:CheckBuff(110036) == false ) then		
			Player:Tip("$$Quest_109094_12")
			NorthFire:GainBuff(110036)
			Field:Spawn( 109030, NpcPos ) 
			
			
--		elseif (ObjectiveID == 2 and NorthFire:CheckBuff(110036) == false ) then
--			Player:Tip("$$Quest_109094_16")
--			NorthFire:GainBuff(110036)		
--			Field:Spawn( 109030, NpcPos )
		--end
	--elseif (Trigger == false) then		
		elseif (ObjectiveID == 2 and NorthFire:CheckBuff(110036) == true ) then			
			Player:Tip("이미 불이 붙어 있습니다. 잠시 후에 다시 시도하십시오.")
		end
	end
end
--]]