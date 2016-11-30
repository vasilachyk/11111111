-- 오염된화원 보스룸

function Field_121102:OnDie(DespawnInfo)
	
	if (DespawnInfo.SpawnID == 1) then 
		local Field = DespawnInfo.Field
		local Door1 = Field:GetSpawnNPC(2)	
		--local Pos = DespawnInfo.Pos		
		--local JailsPos = Math_GetDistancePoint(Pos, vec3(0,-1,0), 500)	
		Field:PlayBGM("bgm_Scenetalk_2") 		
		Door1:UseTalentSelf( 212102201 ) -- 잠겨있던 문 열리도록
		Field:SpawnByID(3)  -- 열리지 않는 문 스폰		
		DespawnInfo.NPC:NarrationNow( "$$Field_121002_13"  )				
		--Field:SpawnDelay(113232, JailsPos, 10)	
	end	

end

function Field_121102:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 113232) then -- 제일스의 본체가 나오면
	   
		SpawnInfo.NPC:GainBuff(110031)
		SpawnInfo.NPC:Narration("$$Field_121002_23",3)	
		SpawnInfo.NPC:Wait(3)
		SpawnInfo.NPC:Narration("$$Field_121002_25",3)
		SpawnInfo.NPC:Wait(4)		
		SpawnInfo.NPC:Narration("$$Field_121002_27",4.4)
		SpawnInfo.NPC:Wait(5)		
		SpawnInfo.NPC:Narration("$$Field_121002_29",4.5)		
		SpawnInfo.NPC:Wait(5)		
		SpawnInfo.NPC:Narration("$$Field_121002_31",3)
		--SpawnInfo.NPC:RemoveBuff(110031)		
	end
end