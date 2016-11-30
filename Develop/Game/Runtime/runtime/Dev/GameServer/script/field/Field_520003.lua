-- 라드의 저택 3층


function Field_520003:OnDie(DespawnInfo)

	local Field = DespawnInfo.Field	
	
	if (DespawnInfo.SpawnID == 5) then -- 3층 집사가 죽었을 때
		
		local Door1 = Field:GetSpawnNPC(9)
		local Door2 = Field:GetSpawnNPC(8)	-- 포탈이 생기는 오브젝트		
		
		--Door1:UseTalentSelf( 212102201 )	-- 보스가 죽으면 문열기		
		--Door2:GainBuff( 110051 ) -- 포탈 이펙트 나오는 탤런트		
		
		--DespawnInfo.NPC:NarrationNow( "$$Field_520001_2"  ) -- 잠겨진 문이 열립니다
		
	end
end

function Field_520003:OnSensorTalent_2(Actor, TalentID)
	local Field = AsPlayer(Actor):GetField()
	if(TalentID == 199210 ) then
		local Door1 = Field:GetSpawnNPC(9)
		local Door2 = Field:GetSpawnNPC(8)	-- 포탈이 생기는 오브젝트	
		Door1:UseTalentSelf( 212102201 )	-- 보스가 죽으면 문열기		
		Door2:GainBuff( 110051 ) -- 포탈 이펙트 나오는 탤런트		
		
		Door1:NarrationNow( "$$Field_520001_2"  ) -- 잠겨진 문이 열립니다
	end
end

function Field_520003:OnSpawn(SpawnInfo)
	
	if ( SpawnInfo.SpawnID == 10 ) then
			SpawnInfo.NPC:Patrol({3,4,5,6}, PT_LOOP)
	end
	if ( SpawnInfo.SpawnID == 7 ) then
			SpawnInfo.NPC:Patrol({7,8,9,10}, PT_LOOP)
	end
	
end

