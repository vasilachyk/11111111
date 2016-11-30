-- 오염된화원2

-- 1 : 27 28 29 32 33 136 139 146 164 165 
-- 3 : 140 141 142 143 144 160 161 162 163
-- 7 : 91 92 93 138 145 147


function Field_121001:OnCreate()
	Field_121001.NPC_Flower1 = {27, 28, 29, 32, 33, 136, 139, 146, 164, 165}
	Field_121001.NPC_Flower3 = {140, 141, 142, 143, 144, 160, 161, 162, 163}
	Field_121001.NPC_Flower7 = {91, 92, 93, 138, 145, 147}
	
	Field_121001.BUFF_FlowerPoison = 88010
end


function Field_121001:OnSensorTalent_15(Actor, TalentID) -- 15번 센서에서 레버를 댕기면 

	if ( TalentID == 212104401 ) then 
		Actor:NarrationNow( "$$Field_121002_13"  ) -- 석문이 열리는 소리가 들립니다.
	end	

end

function Field_121001:OnSensorTalent_16(Actor, TalentID) -- 16번 센서에서 레버를 댕기면 
	
	if ( TalentID == 212104401 ) then 
		Actor:NarrationNow( "$$Field_121002_13"  ) -- 석문이 열리는 소리가 들립니다.
	end	
	
end

function Field_121001:OnSensorTalent_21(Actor, TalentID) -- 21번 센서에서 레버를 댕기면
	--GLog("Field_121001:OnSensorTalent_21() "..TalentID.."\n")
	
	if ( TalentID == 212104401 ) then 

		Actor:NarrationNow( "$$Field_121002_13"  ) -- 석문이 열리는 소리가 들립니다.
		
		this:DespawnByID(91)
		this:DespawnByID(92)
		this:DespawnByID(93)
		this:DespawnByID(138)
		this:DespawnByID(145) 
		this:DespawnByID(147)
	end	
end


function Field_121001:OnSensorEnter_1(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		
		--Field:SpawnByID(62)  -- 가시덩굴 출현3
		--Field:SpawnByID(64)  -- 가시덩굴 출현3
		--Field:SpawnByID(66)  -- 가시덩굴 출현3		
		
		Field:ActivateSpawnGroup(2)
		Field:DisableSensor(1)		
	end
end

function Field_121001:OnSensorEnter_2(Actor) -- 가시덩굴 더미 삭제 
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		local Aruka = Field:GetSpawnNPC(75)		
		
		Aruka:NarrationNow("$$Field_121001_20")
		--Aruka:UseTalentSelf( 212100930 )
		--Aruka:UseTalentSelf( 212100931 )		
		--Aruka:UseTalentSelf( 212100932 )
		--Aruka:UseTalentSelf( 212100933 )
		
		Field:DespawnByID(51)
		Field:DespawnByID(52)  		
		Field:DespawnByID(114)  		
		Field:DespawnByID(115)  		
		Field:DespawnByID(116)  		
		Field:DespawnByID(117)
		
		Field:DisableSensor(2)	
	end
end

function Field_121001:OnSensorEnter_3(Actor) 
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		
		Field:ActivateSpawnGroup(3)
		Actor:NarrationNow("$$Field_121001_42")		
		
		for i, id in ipairs( Field_121001.NPC_Flower3 ) do
			local Flower = this:GetSpawnNPC( id )
			Flower:GainBuff( Field_121001.BUFF_FlowerPoison )
		end	
		
		Field:DisableSensor(3)	
		
	end
end

function Field_121001:OnSensorEnter_4(Actor) -- 봉봉 뒤에서 출현 
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		
		Field:SpawnByID(88)  		
		Field:SpawnByID(89)  		
		Field:SpawnByID(90)  
		Actor:NarrationNow("$$Field_121001_55")
		Field:DisableSensor(4)	
		
	end
end



function Field_121001:OnSensorEnter_6(Actor) -- room on
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()		
		Field:ActivateSpawnGroup(1)
		
		for i, id in ipairs(Field_121001.NPC_Flower1) do
			local Flower = this:GetSpawnNPC( id )
			Flower:GainBuff( Field_121001.BUFF_FlowerPoison )
			Flower:GainBuff( 88013 )
			--Flower:SayNow("?"..Flower:GetSpawnID() )
		end		
		
		Field:DisableSensor(6)		
	end
end

function Field_121001:OnSensorEnter_7(Actor) -- 1번째 room on
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()		
		
		Field:ActivateSpawnGroup(6)
		Field:DisableSensor(7)		
	end
end

function Field_121001:OnSensorEnter_10(Actor) 
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()		
		
		Field:ActivateSpawnGroup(4)
		Field:DisableSensor(10)		
	end
end

function Field_121001:OnSensorEnter_11(Actor) 
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()		
		
		--Field:ActivateSpawnGroup(5)
		Actor:NarrationNow("$$Field_121001_102")
		Field:DisableSensor(11)		
	end
end

function Field_121001:OnSensorEnter_12(Actor)
	--GLog("Field_121001:OnSensorEnter_12()\n")
	
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()		
		
		Field:ActivateSpawnGroup(7)						
		
		for i, id in ipairs( Field_121001.NPC_Flower7 ) do
			local Flower = this:GetSpawnNPC( id )
			Flower:GainBuff( Field_121001.BUFF_FlowerPoison )
		end
		
		Field:DisableSensor(12)		
	end
end

function Field_121001:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	
	if (DespawnInfo.SpawnID == 75) then -- 아루카 축었을 때
		local Door1 = Field:GetSpawnNPC(48)		
		Door1:UseTalentSelf( 212102201 )		
		Field:ActivateSpawnGroup(5)
		DespawnInfo.NPC:NarrationNow( "$$Field_121001_124"  )				
	end
	
	if (DespawnInfo.SpawnID == 56) then -- 첫번째 거대한 봉봉 죽었을 때
		local Door1 = Field:GetSpawnNPC(47)		
		Door1:UseTalentSelf( 212102201 )		
		DespawnInfo.NPC:NarrationNow( "$$Field_121001_130"  )				
		
		
		for i, id in ipairs( Field_121001.NPC_Flower3 ) do
			this:DespawnByID( id )
		end
		
	end
	
	if (DespawnInfo.SpawnID == 83) then -- 마지막 거대한 봉봉

		local Door1 = Field:GetSpawnNPC(159)		
		Door1:UseTalentSelf( 212102201 )		
		
		Field:DespawnByID(148)  		
		Field:DespawnByID(149)  		
		Field:DespawnByID(150)  		
		Field:DespawnByID(151)  		
		Field:DespawnByID(152)  		
		Field:DespawnByID(153)
		Field:DespawnByID(154) 
		Field:DespawnByID(155)  
		Field:DespawnByID(156)  				
		Field:DespawnByID(157)
		Field:DespawnByID(158)
		
		DespawnInfo.NPC:NarrationNow( "$$Field_121001_161"  )				
	
	end
end 

function Field_121001:OnSpawn(SpawnInfo)
	
	if (SpawnInfo.SpawnID == 26) then -- 첫번째 레버
		SpawnInfo.NPC:EnableSensorCheck(15)
	end
	if (SpawnInfo.SpawnID == 34) then -- 두번째 레버
		SpawnInfo.NPC:EnableSensorCheck(16)
	end
	if (SpawnInfo.SpawnID == 111) then -- 마지막 레버
		SpawnInfo.NPC:EnableSensorCheck(21)
	end
	
	if (SpawnInfo.NPCID == 121212) then -- 봉봉 페트롤
		if (SpawnInfo.SpawnID == 84) then
		-- SpawnInfo.NPC:SetAlwaysRun(true)
		--GLog("Move\n") 
		SpawnInfo.NPC:Patrol({6,7}, PT_LOOP)
		end
	end
	
	if (SpawnInfo.NPCID == 121212) then -- 나무정령 페트롤
		if (SpawnInfo.SpawnID == 113) then
			SpawnInfo.NPC:Patrol({8,9,10}, PT_LOOP)
		end
	end
	
	if (SpawnInfo.NPCID == 121201) then -- 봉봉 뒤에서 쫓아오기
		
		SpawnInfo.NPC:SetAlwaysRun(true)
		--GLog("BongBong Move\n") 
		
		if (SpawnInfo.SpawnID == 88) then
			SpawnInfo.NPC:MoveToMarker(5)
		end
		if (SpawnInfo.SpawnID == 89) then
			SpawnInfo.NPC:MoveToMarker(5)
		end
		if (SpawnInfo.SpawnID == 90) then
			SpawnInfo.NPC:MoveToMarker(5)
		end
		
	end
	

end



