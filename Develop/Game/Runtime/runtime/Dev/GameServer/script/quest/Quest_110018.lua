-- 구원의 손길

function Quest_110018:OnObjComplete(Player, ObjectiveID, Trigger)
	if (ObjectiveID == 1) then
		Player:Tip("$$Quest_110018_5")
	end
	if (ObjectiveID == 2) then
		local Field = Player:GetField()
		local Location = Player:GetPos()
		local Fixed = Math_GetDistancePoint(Location, vec3(-0.91, 0.41, 0.0), 800)
		Field:Spawn(110023, Fixed)
	end
	if (ObjectiveID == 3) then
		Player:Narration("$$Quest_110018_14")
	end
end


function Quest_110018:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	if (ObjectiveID == 2) then
		if (NPC:CheckBuff(110000) == true) then
			NPC:FaceTo(Player)
			NPC:RemoveBuff(110000)
			NPC:SetAlwaysRun(true)

			if (NPC:GetID() == 110218) then
				local dice = math.random(0,3)
				if( dice == 0) then 
					NPC:Balloon("$$Quest_110018_30")
				end
				if( dice == 1) then 
					NPC:Balloon("$$Quest_110018_33")
				end
				if( dice == 2) then 
					NPC:Balloon("$$Quest_110018_36")			
				end		
				if( dice == 3) then 
					NPC:Balloon("$$Quest_110018_39")
				end
				NPC:UseTalentSelf(211021801)				
				NPC:ScriptSelf("Quest_110018_AwayMove")
				NPC:ScriptSelf("Quest_110018_Despawn")	
			end	
			if (NPC:GetID() == 110219) then
				local dice = math.random(0,3)
				if( dice == 0) then 
					NPC:Balloon("$$Quest_110018_47")
				end
				if( dice == 1) then 
					NPC:Balloon("$$Quest_110018_50")
				end
				if( dice == 2) then 
					NPC:Balloon("$$Quest_110018_53")			
				end		
				if( dice == 3) then 
					NPC:Balloon("$$Quest_110018_56")
				end	
				NPC:UseTalentSelf(211021801)	
				NPC:ScriptSelf("Quest_110018_AwayMove")
				NPC:ScriptSelf("Quest_110018_Despawn")				
			end
		end	
	end
end

function Quest_110018_AwayMove(Self)
	local Pos = Self:GetPos()
	local Dir = Self:GetDir()	
	local Point = Math_GetDistancePoint(Pos, Dir, 800)
	Self:Move(Point)
end
function Quest_110018_Despawn(Self)
	Self:Despawn(false)
end
