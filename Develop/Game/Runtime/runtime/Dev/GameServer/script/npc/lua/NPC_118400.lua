function NPC_118400:Init(NPCID)
	NPC_ReserveUserData(NPCID, 2)
end

function NPC_118400:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:DisableInteraction()			
end

function NPC_118400:OnDialogExit(Player, DialogID, nExit)
	-- 용의 출현 진행 대화
	if (1180202 == DialogID) and (2 == nExit) then
		
		local Field  = this:GetField()		
		Field:EnableSensor(999)
		-- Player:UpdateQuestVar(118020, 1)
	end
	
end
