-- 테오란 실험실

function Field_521000:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 1) or (SpawnInfo.SpawnID == 2) then -- 쌍 지그니프
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:DisableCombat()
	end	
end

function Field_521000:OnSensorEnter_2(Actor) -- 쌍 지그니프 활성화
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(2)
		local Epic1 = this:GetSpawnNPC(1)
		local Epic2 = this:GetSpawnNPC(2)
		Epic1:ChangeAA(AA_ALWAYS)
		Epic2:ChangeAA(AA_ALWAYS)
		Epic1:Attack(Actor)		
		Epic2:Attack(Actor)
		Epic1:EnableCombat()	
		Epic2:EnableCombat()
	end
end

function Field_521000:OnSensorEnter_1(Actor)
	if (Actor:IsPlayer() == true) then
		Actor:RemoveBuff(1910)
	end
end
function Field_521000:OnSensorEnter_3(Actor)
	if (Actor:IsPlayer() == true) then
		Actor:RemoveBuff(1910)
	end	
end

function Field_521000:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 512001) or (DespawnInfo.NPCID == 512002) then -- 만네로스와 기사단장 죽으면 투명벽 사라짐
		if (this:GetNPCCount(512001) == 0) and (this:GetNPCCount(512002) == 0) then
			this:DespawnByID(100, false)
			this:DespawnByID(101, false)
			this:DespawnByID(102, false)			
		end
	end	
	if (DespawnInfo.NPCID == 101000) then -- 지그니프 죽으면 투명벽 사라짐
		if (this:GetNPCCount(101000) == 0) then
			this:DespawnByID(103, false)
			this:DespawnByID(104, false)
			this:DespawnByID(105, false)			
		end
	end		
end
