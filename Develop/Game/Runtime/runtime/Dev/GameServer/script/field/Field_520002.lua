-- 라드의 저택 2층

function Field_520002:OnSensorEnter_4(Actor)

	local Field = AsPlayer(Actor):GetField()

	Actor:NarrationNow( "$$Field_520001_3"  ) -- 영혼조리사 일꾼에 의해 문이 잠겨있습니다.
	Field:DisableSensor(4)	

	
end

function Field_520002:OnSensorTalent_3(Actor, TalentID) -- 첫번째 레버 돌리 때
	
	local Field = Actor:GetField()
	local Event = this:GetSpawnNPC( 69 )	
	local Door1 = Field:GetSpawnNPC(29)	-- 포탈이 생기는 오브젝트		
	local Door2 = Field:GetSpawnNPC(43)	-- 일꾼방의 문
		
	
	if ( TalentID == 252050201 ) then 
		
		Actor:NarrationNow( "$$Field_520001_2"  ) -- 
		Door1:UseTalentSelf( 212102201 )	-- 레버 돌리면 문열리기 / 벽은 NPC.xls의 trigger로 제어하고 있다
		Door2:UseTalentSelf( 212102201 )	-- 일꾼 방문 열어두기(나중에 이벤트로 닫힘)
		
		Event:GainBuff( 110062 ) -- 지진이벤트		
		Field:DisableSensor(3)		
		
	end	
		
end

function Field_520002:OnSensorTalent_2(Actor, TalentID) -- 마지막 레버 돌릴 때
	
	local Field = Actor:GetField()
	local Door1 = Field:GetSpawnNPC(62)	-- 마지막 문
	local Door2 = Field:GetSpawnNPC(43)	-- 일꾼 방의 문
	local Event = this:GetSpawnNPC( 68 )	

	
	if ( TalentID == 252050201 ) then 
		
		Actor:NarrationNow( "$$Field_520001_1"  ) -- 워프존이 활성화되었습니다.
		Field:EnableSensor(1)	
		
		Door1:UseTalentSelf( 212102201 )    -- 마지막 문 열기 
		Door2:UseTalentSelf( 212102202 )	-- 일꾼 방문 닫기				
		--Field:DisableSensor(2)		
		
		Field:SpawnByID(5)  	-- 갑자기 적들이 생기는 이벤트	
		Field:SpawnByID(15)  		
		Field:SpawnByID(16)  		
		Field:SpawnByID(17)  		
		Field:SpawnByID(44)  		
		Field:SpawnByID(45)  		
		
		Event:GainBuff( 110062 ) -- 지진이벤트		
		Field:EnableSensor(4)	
		Field:DisableSensor(3)	
		
	end
	
	
end


function Field_520002:OnDie(DespawnInfo)

	local Field = DespawnInfo.Field	
	local Door1 = Field:GetSpawnNPC(10)	
	local Door2 = Field:GetSpawnNPC(43)	
	local lever1 = Field:GetSpawnNPC(28)
	
	
	
	if (DespawnInfo.SpawnID == 8) then -- 2층 에픽 영혼조리사가 죽었을 때
		
		
		Door1:UseTalentSelf( 212102201 )	-- 보스가 죽으면 문열기
		
		DespawnInfo.NPC:NarrationNow( "$$Field_520001_2"  ) -- 잠겨진 문이 열립니다
		
	end
	
	
	if ( lever1:GetMode() == 1 and Field:GetNPCCount(520208) == 0 ) then
		
		
		Door2:UseTalentSelf( 212102201 )	-- 갑자기 등장한 적들을 모두 해치우면 문이 열린다		
		DespawnInfo.NPC:NarrationNow( "$$Field_520001_2"  ) -- 잠겨진 문이 열립니다
		
	end	
	

end

function Field_520002:OnSpawn(SpawnInfo)
	
	local Field = SpawnInfo.Field
	
	local Door1 = Field:GetSpawnNPC(9)	-- 포탈이 생기는 오브젝트		
	
	Door1:GainBuff( 110051 ) -- 포탈 이펙트 나오는 탤런트		
	

	if (SpawnInfo.SpawnID == 11) then -- 첫번째 레버
		SpawnInfo.NPC:EnableSensorCheck(3)
	end
	if (SpawnInfo.SpawnID == 28) then -- 두번째 레버
		SpawnInfo.NPC:EnableSensorCheck(2)
	end
	
	if (SpawnInfo.SpawnID == 21 ) then
			SpawnInfo.NPC:Patrol({3,6}, PT_LOOP)	
	end
	if (SpawnInfo.SpawnID == 26 ) then
			SpawnInfo.NPC:Patrol({4,5}, PT_LOOP)	
	end
	
	
	if (SpawnInfo.NPCID == 520207) then -- 갑자기 생긴 적들 이동시키기
	
		SpawnInfo.NPC:SetAlwaysRun(true)
		--GLog("BongBong Move\n") 
		
		if (SpawnInfo.SpawnID == 5) then
			SpawnInfo.NPC:MoveToMarker(8)
		end
		if (SpawnInfo.SpawnID == 16) then
			SpawnInfo.NPC:MoveToMarker(8)
		end	
		--if (SpawnInfo.SpawnID == 45) then
		--	SpawnInfo.NPC:MoveToMarker(8)
		--end	
		
	end
	
	
	
	--if (SpawnInfo.NPCID == 520206) then -- 갑자기 생긴 적들 이동시키기
	
		--SpawnInfo.NPC:SetAlwaysRun(true)
		--GLog("BongBong Move\n") 
		
		--if (SpawnInfo.SpawnID == 15) then
		--	SpawnInfo.NPC:MoveToMarker(8)
		--end
		--if (SpawnInfo.SpawnID == 17) then
		--	SpawnInfo.NPC:MoveToMarker(8)
		--end	
		
	--end
	
	
	
end

