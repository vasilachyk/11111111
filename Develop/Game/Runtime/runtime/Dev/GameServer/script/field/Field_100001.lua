-- 부러진돛대 스크립트 테스트 
function Field_100001:OnSensorTalent_1(Actor, TalentID)
	
	--Actor:Narration("$$Field_100001_4")		
	
	if(TalentID == 25514 ) then

	--	Actor:Narration("$$Field_100001_8")	

		
		local Field = Actor:GetField()
		local NpcPos = Math_GetDistancePoint( Actor:GetPos(), Actor:GetDir(), 300 )		
		
		Field:Spawn( 109029, NpcPos )
		
	
	end
end

function Field_100001:OnSensorTalent_3(Actor, TalentID)
	
	-- Actor:Narration("$$Field_100001_22")		
	
	if(TalentID == 25514 ) then
		--Actor:Narration("$$Field_100001_25")	
		local Field = Actor:GetField()
		local NpcPos = Math_GetDistancePoint( Actor:GetPos(), Actor:GetDir(), 300 )		
		Field:Spawn( 109030, NpcPos )
	end
end


function Field_100001:OnDie(DespawnInfo)
	
		
	if (DespawnInfo.NPCID == 109220) then
		
		--GLog("DespawnInfo.NPCID = "..DespawnInfo.NPCID.."\n")
		
		local Field = DespawnInfo.Field
		local NpcPos = Math_GetDistancePoint( DespawnInfo.NPC:GetPos(), DespawnInfo.NPC:GetDir(), -200 )		
		Field:Spawn( 109310, NpcPos ) 

		
		DespawnInfo.NPC:SetDecayTime(13)
		
	end
	
end

function Field_100001:OnSpawn(SpawnInfo)
	--GLog("OnSpawn\n")	

	if (SpawnInfo.NPCID == 109310) then 
	
		
	
		SpawnInfo.NPC:Say("$$Field_100001_58")
		SpawnInfo.NPC:GainBuff(5000051)
		SpawnInfo.NPC:UseTalentSelf(210901733)		
		SpawnInfo.NPC:Say("$$Field_100001_61")		
		SpawnInfo.NPC:Say("$$Field_100001_62")
		SpawnInfo.NPC:Wait(1)		
		SpawnInfo.NPC:Narration("$$Field_100001_64")
		SpawnInfo.NPC:Despawn(false)
		
		
	end
	


end



 


