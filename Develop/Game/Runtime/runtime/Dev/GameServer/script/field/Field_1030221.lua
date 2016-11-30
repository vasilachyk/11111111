-- 레나스의 신전(1인용)

function Field_1030221:OnDie(DespawnInfo) -- 토가트 수호자 대장이 죽으면 포탈이 열린다.
	if (DespawnInfo.SpawnID == 7) then
		this:EnableSensor(4)
	end
end

function Field_1030221:OnSpawn(SpawnInfo) -- 신전 수호자 3,4번 패트롤
	if (SpawnInfo.SpawnID == 3) then
		GLog("3번 스폰 패트롤/n")
		--SpawnInfo.NPC:Patrol({32,31}, PT_LOOP)
		SpawnInfo.NPC:Patrol({31,32}, PT_LOOP)		
	end
	if (SpawnInfo.SpawnID == 4) then
		GLog("4번 스폰 패트롤/n")	
		--SpawnInfo.NPC:Patrol({42,41}, PT_LOOP)
		SpawnInfo.NPC:Patrol({41,42}, PT_LOOP)
	end			
end
function Field_1030221:OnSensorEnter_10(Actor) -- 강탈 이벤트
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(10)	
		this:PlayBGM("bgm_Scenetalk_2") 	
		local Treasure = this:GetSpawnNPC(103414)		
		local Fighter = this:GetSpawnNPC(103515)	
		local Archer = this:GetSpawnNPC(103516)
		local Magician = this:GetSpawnNPC(103517)	
		local Berserker = this:GetSpawnNPC(103518)		
		local Session = this:MakeSession("Theft", {Treasure, Fighter, Archer, Magician, Berserker})
		Session:AddBookmark("Player", Actor)
	end
end

function Field_1030221:OnSessionScene_Theft_Begin(Session)
		local Fighter = this:GetSpawnNPC(103515)	
		local Archer = this:GetSpawnNPC(103516)
		local Magician = this:GetSpawnNPC(103517)	
		local Berserker = this:GetSpawnNPC(103518)
		
		Berserker:FaceTo(Session:FindBookmark("Player"))
		Archer:FaceTo(Session:FindBookmark("Player"))
		Berserker:Say("뭐지, 이 조그만 녀석들은?")
		Archer:Say("이 신전을 지키는 자들인가 봅니다.")
		Magician:FaceTo(Session:FindBookmark("Player"))
		Magician:Say("별로 강해보이진 않는데?")
		Berserker:Say("사피엔, 네가 이놈들을 처리해라.")
		Berserker:Say("우린 이 상자를 가지고 마리니님께 가져가겠다.")
		Fighter:Say("맡겨만 주십시오.")
		
		Session:ChangeScene("Combat")
end

function Field_1030221:OnSessionScene_Theft_Combat(Session)
		local Fighter = this:GetSpawnNPC(103515)	
		local Archer = this:GetSpawnNPC(103516)
		local Magician = this:GetSpawnNPC(103517)	
		local Berserker = this:GetSpawnNPC(103518)
		local Treasure = this:GetSpawnNPC(103414)
		
		Session:CombatAll()
		this:PlayBGM("bgm_Scenewar_2") 
		
		Treasure:GainBuff(110051)
		Fighter:FaceTo(Session:FindBookmark("Player"))
		Fighter:EnableCombat()
		Fighter:ChangeAA(AA_ALWAYS)
		Fighter:Attack(Session:FindBookmark("Player"))

		Session:ChangeScene("Portal")
end

function Field_1030221:OnSessionScene_Theft_Portal(Session)
		local Fighter = this:GetSpawnNPC(103515)	
		local Archer = this:GetSpawnNPC(103516)
		local Magician = this:GetSpawnNPC(103517)	
		local Berserker = this:GetSpawnNPC(103518)
		local Treasure = this:GetSpawnNPC(103414)
		
		Archer:Despawn(false)
		Magician:Despawn(false)
		Berserker:Despawn(false)
		Treasure:RemoveBuff(110051)
		this:DespawnByID(103414)
		
		Session:EndSession()
end