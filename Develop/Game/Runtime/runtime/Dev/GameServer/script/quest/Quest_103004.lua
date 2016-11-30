-- 구원

function Quest_103004:OnBegin(Player, NPC) -- 103004 퀘스트 시작하면 봉봉 마을로 납치당함
	local Field = Player:GetField()
	local Narrater = Field:GetSpawnNPC(9000)
	
	NPC:DisableInteraction()
	Field:SpawnByID(103501)
	Field:SpawnByID(103502)			
	Narrater:ScriptSelf("Quest_103004_Kidnap")
	NPC:GainBuff(110061)
	Player:GainBuff(110061)	
	Player:Tip("당신은 기습을 받았습니다.")
end

function Quest_103004_Kidnap(Self)
	local Field = Self:GetField()
	local Slaver1 = Field:GetSpawnNPC(103501)
	local Slaver2 = Field:GetSpawnNPC(103502)	
	
	Slaver1:ClearJob()
	Slaver2:ClearJob()
	Slaver2:Wait(1)	
	Slaver1:Say("{ani=atk_n}케케케, 새로운 노예다!")
	Slaver2:Wait(4)
	Slaver2:Say("{ani=taunt_2}이놈들도 마을로 끌고가자!")	
	Slaver2:ScriptSelf("Quest_103004_Despawn")
end

function Quest_103004_Despawn(Self)
	local Field = Self:GetField()
	local Slaver1 = Field:GetSpawnNPC(103501)
	local Slaver2 = Field:GetSpawnNPC(103502)
	local Fago = Field:GetSpawnNPC(103201)
	
	Slaver1:Despawn(false)
	Slaver2:Despawn(false)
	Fago:Despawn(true)	
end
