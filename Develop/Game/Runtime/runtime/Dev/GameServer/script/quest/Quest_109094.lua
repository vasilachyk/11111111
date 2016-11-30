-- 배신자 처단

function Quest_109094:OnObjProgress(Player, ObjectiveID, Trigger)	
	local Field = Player:GetField()	
	local SouthFire = Field:GetNPC(109114)
	local NorthFire = Field:GetNPC(109115)	
	local NpcPos = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )		
	
	--GLog( "OnObjProgress\n")
	if (Trigger == true) then
		if (ObjectiveID == 1 and SouthFire:CheckBuff(110036) == false ) then		
			Player:Tip("$$Quest_109094_12")
			SouthFire:GainBuff(110036)
			Field:Spawn( 109029, NpcPos ) 
		elseif (ObjectiveID == 2 and NorthFire:CheckBuff(110036) == false ) then
			Player:Tip("$$Quest_109094_16")
			NorthFire:GainBuff(110036)		
			Field:Spawn( 109030, NpcPos ) 
		end
	end
end

