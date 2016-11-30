-- 라드의 저택 1층


function Field_520001:OnDie(DespawnInfo)

	local Field = DespawnInfo.Field
	
	
	if ( Field:GetNPCCount(520103) == 0 and Field:GetNPCCount(520106) == 0 and Field:GetNPCCount(520107) == 0) then -- 1층 네임드 축었을 때
		
		local Door2 = Field:GetSpawnNPC(31)	-- 잠겨져있는 문
		
		
		Door2:UseTalentSelf( 212102201 )	-- 문열기			
		
		Field:EnableSensor(3)		
		Field:EnableSensor(8)
		DespawnInfo.NPC:NarrationNow( "$$Field_520001_2"  )		-- 잠겨진 문이 열렸습니다.		
		
		--Field:ActivateSpawnGroup(5)
		
	end
	

end

function Field_520001:OnSpawn(SpawnInfo)
	
	local Field = SpawnInfo.Field
	
	local Door1 = Field:GetSpawnNPC(30)	-- 포탈이 생기는 오브젝트	
	Door1:GainBuff( 110051 ) -- 포탈 이펙트 나오는 탤런트		
	
	if (SpawnInfo.SpawnID == 53 ) then
			SpawnInfo.NPC:Patrol({6,7,8}, PT_LOOP)	
	end
	
	if (SpawnInfo.SpawnID == 75 ) then
			SpawnInfo.NPC:Patrol({2,3,5,9,10,11}, PT_LOOP)	
	end	
	if (SpawnInfo.SpawnID == 76 ) then
			SpawnInfo.NPC:Patrol({2,3,5,9,10,11}, PT_LOOP)	
	end
	
	
end

function Field_520001:OnSensorEnter_5(Actor)

	local Field = AsPlayer(Actor):GetField()
	local Event = this:GetSpawnNPC( 35 )	

	Event:GainBuff( 110062 ) -- 지진이벤트		
	Field:DisableSensor(5)	

end

function Field_520001:OnSensorEnter_8(Actor)

	local Field = AsPlayer(Actor):GetField()
	local Event = this:GetSpawnNPC( 36 )	

	Event:GainBuff( 110062 ) -- 지진이벤트		
	Field:DisableSensor(8)	

end
