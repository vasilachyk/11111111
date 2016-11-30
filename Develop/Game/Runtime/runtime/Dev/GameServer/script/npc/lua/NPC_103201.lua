-- 조사단원 파고
--[[
function NPC_103201:OnDialogExit(Player, DialogID, ExitID) -- 103004 퀘스트 시작하면 봉봉 마을로 납치당함
	if (1030040 == DialogID) then
		if (1 == ExitID) then
			local Field = Player:GetField()
			local loc = Player:GetPos()
			this:DisableInteraction()
			this:GainBuff(110061)
			Player:GainBuff(110061)
			Field:SpawnByID(103501)
			Field:SpawnByID(103502)			
			this:ScriptSelf("NPC_103201_Kidnap")
		end
	endsw
end

function NPC_103201_Kidnap(Self)
	local Field = Self:GetField()
	local Slaver1 = Field:GetSpawnNPC(103501)
	local Slaver2 = Field:GetSpawnNPC(103502)	
	
	Slaver1:Say("{ani=atk_n}케케케, 새로운 노예다!")
	Slaver2:Wait(3)
	Slaver2:Say("{ani=taunt_2}이놈들도 마을로 끌고가자!")	
	Slaver2:ScriptSelf("NPC_103201_Despawn")
end

function NPC_103201_Despawn(Self)
	local Field = Self:GetField()
	local Slaver1 = Field:GetSpawnNPC(103501)
	local Slaver2 = Field:GetSpawnNPC(103502)
	local Fago = Field:GetSpawnNPC(103201)
	
	Slaver1:Despawn(false)
	Slaver2:Despawn(false)
	Fago:Despawn(true)	
end
--]]