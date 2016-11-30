-- 베스피오단 은신처 (트라이얼)
function Field_113001:OnSpawn(SpawnInfo) 
    if (SpawnInfo.SpawnID == 512002) then -- 만넬로스 전투 불가로 설정
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
	end
	if (SpawnInfo.SpawnID == 113079) then -- 게리온을 이벤트 전까지 전투 불가로 설정
		SpawnInfo.NPC:DisableCombat()
		SpawnInfo.NPC:ChangeAA(AA_NONE)
	end	
end

function Field_113001:OnSensorEnter_10(Actor) -- 만넬로스가 제물의 영혼을 흡수
	this:DisableSensor(10)
	local Lich = this:GetSpawnNPC(512002)
	--local Field = this:GetID()		
	if (Actor:IsPlayer() == true) then		
		this:PlayBGM("bgm_Scenetalk_1")
		Lich:SetAlwaysRun(true)
		Lich:MoveToMarker(5)
		Lich:NonDelaySay("$$Field_113001_21",2.2) -- 내 마력의 양분이 되어라!
		Lich:UseTalentSelf(251200205)
		Lich:ScriptSelf("Field_113001_Victim")
	end
end

function Field_113001_Victim(Self)
	local Field = Self:GetField()
	local Victim1 = Field:GetSpawnNPC(11)
	local Victim2 = Field:GetSpawnNPC(12)
	local Victim3 = Field:GetSpawnNPC(13)
	Victim1:GainBuff(110008)
	Victim2:GainBuff(110008)
	Victim3:GainBuff(110008)	
end

function Field_113001:OnDie(DespawnInfo) 
	local Field = this:GetID()
	local Lich = this:GetSpawnNPC(512002)
	
	if (DespawnInfo.NPCID == 113244) then -- 제물 모두 죽으면 이벤트 시작
		if (this:GetNPCCount(113244) == 0) then
			Lich:GainBuff(110006)
			Lich:Say("$$Field_113001_44",4.9) -- (웃음) 이로써 내 육체가 모두 복구되었다.
			Lich:Wait(3)
			Lich:Say("$$Field_113001_46",2.3)	-- 곧 모든 마력을 되찾을 수 있겠군
			Lich:ScriptSelf("Field_113001_Event1")
		end
	end
	if (DespawnInfo.NPCID == 113079) then -- [1] 게리온이 죽으면 : 이벤트 시작
		local Pos = DespawnInfo.Pos
		DespawnInfo.Field:Spawn(113245, Pos)
		Lich:Say("$$Field_113001_53",2.5) -- 이놈도 결국 쥐새끼에 불과했군
		Lich:Say("$$Field_113001_54",3.8)	-- 할 수 없지. 내가 직접 너희의 영혼을 흡수해 주마
		Lich:Say("$$Field_113001_55",2.2) -- 내 마력의 양분이 되어라
		Lich:UseTalentSelf(251200205)
		Lich:ScriptSelf("Field_113001_Event3")	-- [2] 제일스의 영혼이 등장
	end	
end

function Field_113001_Event1(Self)	-- 아이젠트 트리어 등장
	local Field = Self:GetField()	
	Field:SpawnByID(113217)
	Field:EnableSensor(11)
end

function Field_113001:OnSensorEnter_11(Actor) -- 센서에 닿으면 이벤트 1
    this:DisableSensor(11)
	local Lich = this:GetSpawnNPC(512002)
	local Gerion = this:GetSpawnNPC(113079)
	local Iesent = this:GetSpawnNPC(113217)
	
	if (Actor:IsPlayer() == true) then	
		Iesent:Say("$$Field_113001_74",2.0) -- 너의 의도대로 될 거 같으냐
		Iesent:WaitFor(Lich)
		Lich:FaceTo(Iesent)
		Lich:Wait(1)
		Lich:Say("$$Field_113001_78",1.9) -- 넌 아이젠트 트리어!
		Lich:Say("$$Field_113001_79",4.2)	-- 네놈도 부활한 것인가! 하지만 고작 영혼 밖에 남지 않았군.
		Lich:Say("$$Field_113001_80",2.8) -- 육신도 없는 놈이 무엇을 어쩌겠단 것이냐!
		Lich:NextAction()
		Lich:WaitFor(Iesent)
		Iesent:Say("$$Field_113001_83",4.9) -- 나의 육신은 바스러졌지만, 내 뜻은 여기 이 자가 이어갈 것이다.
		Iesent:NextAction()
		Lich:Say("$$Field_113001_85",1.8) -- 이자가 널 불러낸 놈인가
		Lich:Say("$$Field_113001_86",3.3) -- 이런 애송이가 너의 마지막 희망이라니. 한심하군
		Lich:FaceTo(Gerion)
		Lich:Say("$$Field_113001_88",6.0) -- 거기 있는 쥐새끼. 내 부활을 도와준데 대한 보답으로, 널 멋진 전사로 거듭나게 해주마
		Lich:UseTalentSelf(251200206)
		Lich:ScriptSelf("Field_113001_Event2")
	end
end

function Field_113001_Event2(Self)	-- 게리온과 전투 센서
	local Field = Self:GetField()
	local Gerion = Field:GetSpawnNPC(113079)	
	Field:EnableSensor(12)
	Gerion:Say("$$Field_113001_98")	
end

function Field_113001:OnSensorEnter_12(Actor) -- 게리온이 공격하고 전투
	this:DisableSensor(12)
	local Lich = this:GetSpawnNPC(512002)
	local Gerion = this:GetSpawnNPC(113079)
		
	if (Actor:IsPlayer() == true) then		
		this:PlayBGM("bgm_Scenewar_1")
		Lich:FaceTo(Actor)		
		Gerion:GainBuff(110031)
		Gerion:EnableCombat()
		Gerion:ChangeAA(AA_ALWAYS)
		Gerion:Attack(Actor)	-- [1] 게리온이 죽으면	
		
		Gerion:Say("$$Field_113001_114")	
	end
end

function Field_113001_Event3(Self)	-- [2] 제일스의 영혼이 등장
	local Field = Self:GetField()	
	Field:EnableSensor(13)	
end

function Field_113001:OnSensorEnter_13(Actor) -- 제일스의 영혼이 만넬로스와 용합
	this:DisableSensor(13)
	local Lich = this:GetSpawnNPC(512002)
	local Jails = this:GetNPC(113245)
	
	if (Actor:IsPlayer() == true) then	
		--this:PlayBGM("bgm_Scenewar_2")
		Lich:FaceTo(Jails)
		Lich:Say("$$Field_113001_131")	
		Jails:GainBuff(110032)
		Jails:Wait(4)
		Jails:MoveToMarker(5)
		Jails:ScriptSelf("Field_113001_Fusion")	
	end
end

function Field_113001_Fusion(Self)	-- 융합
	local Field = Self:GetField()
	Self:Despawn(true)	
	local Lich = Field:GetSpawnNPC(512002)	
	Lich:UseTalentSelf(251200208)
	Lich:GainBuff(110006)	
	Lich:GainBuff(110033) -- 리치 괴로워하기
	Lich:Say("$$Field_113001_146",4.1) 	-- 이 영혼만 남은 쥐새끼가 무슨 짓을... 	
	Lich:Narration("$$Field_113001_147",3.4)	-- 게리온의 육체에서 네놈의 육체로 옮겨왔다.
	Lich:Wait(5)
	Lich:Narration("$$Field_113001_149",4.3) -- 네가 내 영혼을 흡수하기만을 얼마나 기다렸는지 넌 모를 것이다.
	Lich:Wait(6)		
	Lich:Narration("$$Field_113001_151",4.0) -- 이제 그만 반항하고, 네 육체를 나에게 바쳐라.
	Lich:Wait(5)		
	Lich:NonDelaySay("$$Field_113001_153",3.0) -- 이이이 크아아아~
	Lich:UseTalentSelf(251200207)
	Lich:ScriptSelf("Field_113001_Event4")
end

function Field_113001_Event4(Self)	-- [2] 제일스의 영혼이 등장
	local Field = Self:GetField()	
	Field:EnableSensor(14)
	Self:Despawn(true)
end

function Field_113001:OnSensorEnter_14(Actor)
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(14)
		local GK = this:GetSpawnNPC(113217)	
		
		GK:MoveToMarker(5)
		GK:FaceTo(AsPlayer(Actor))
		GK:Say("$$Field_113001_170",3.6) -- 제일스의 영혼이 만넬로스의 육체를 차지해버렸군...
		GK:Say("$$Field_113001_171",4.6) -- 놈이 모든 힘을 회복하게 되면, 이 세계는 큰 혼란에 빠지게 될 거야.
		GK:Say("$$Field_113001_172",4.0) -- 그 전에 만넬로스가 가지고 있는 생명의 단지를 파괴해야 해.
		GK:Say("$$Field_113001_173",2.4) -- 부탁한다... 젊은 영웅들이여.
		GK:ScriptSelf("Field_113001_DespawnSelf")	
	end
end

function Field_113001_DespawnSelf(Self)
	Self:Despawn(true)
end


