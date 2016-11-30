-- 연기에 푹 빠진 그대 (107087)

function Field_1070871:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 107234) then  -- 숲에 난 매연
		SpawnInfo.NPC:GainBuff(110009)
	end	
	if (SpawnInfo.NPCID == 107007) then  -- 테레시스
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
	end		
end

function Field_1070871:OnSensorEnter_1(Actor) -- 테레시스 도망
	if (Actor:IsPlayer() == true) then
		this:DisableSensor(1)
		Actor:Narration("$$Field_1070871_01")
		local Teresis = this:GetSpawnNPC(1200)
		Teresis:SetAlwaysRun(true)
		Teresis:UseTalentSelf(210700708)
		Teresis:MoveToMarker(301)
		Teresis:UseTalentSelf(210700703)
		Teresis:ScriptSelf("Field_1070871_Escape")
	end
end

function Field_1070871_Escape(Self) -- 테레시스 정해진 위치로 이동한뒤 사라짐
	local Field = Self:GetField()
	Field:DespawnByID(1200)
end

function Field_1070871:OnTimer(TimerID) -- 10초뒤 대형 센서가 켜지며 이동
	if (TimerID == 1) then
		this:EnableSensor(2)
	end
end


--[[
function Field_1070871:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	local Urcus = this:GetSpawnNPC(111250)	
	
	if (DespawnInfo.SpawnID == 111010) then
		Field:KillTimer(1)
		Urcus:RemoveBuff(110044)
		Urcus:Wait(4)
		Urcus:Say("마침내 르왕키의 압재가 끝나게 되었군.")
		Urcus:Say("이곳이 정리되면 앞으로 어떻게 할 지 얘기해보세.")
		Urcus:ScriptSelf("Field_1070871_End")
	end
end

function Field_1070871_End(Self)
	local Field = Self:GetField()
	Self:Narration("10초 후 자동으로 공용 필드로 돌아갑니다.")
	Field:SetTimer(2, 10, false)
end
--]]











