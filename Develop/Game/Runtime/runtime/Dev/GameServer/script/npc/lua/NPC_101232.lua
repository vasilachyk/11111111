-- 영웅의 오벨리스크

function NPC_101232:OnDialogExit(Player, DialogID, ExitID) -- 영웅 알현 퀘스트 중 소환됨. 퀘스트 완료한 사람도 계속 소환
GLog(DialogID.."다이얼로그는")
	if (DialogID == 1010471) and (1 == ExitID) then
		Player:UpdateQuestVar(101047, 1)
		local Field = this:GetField()
		local Pos = vec3(66292.0, 48505.7, -593.9)
		if (Field:GetNPCCount(101002) == 0) and (Field:GetNPCCount(101253) == 0) then
			Field:SpawnLimited(101253, Pos, 30)
			local Iris = Field:GetSpawnNPC(101253)
			Iris:FaceTo(Player)
		end
	elseif (DialogID == 1010481) and (1 == ExitID) then
		local Field = this:GetField()
		local Pos = vec3(66292.0, 48505.7, -593.9)
		if (Field:GetNPCCount(101002) == 0) and (Field:GetNPCCount(101253) == 0) then
			Field:SpawnLimited(101253, Pos, 30)
			local Iris = Field:GetSpawnNPC(101253)
			Iris:FaceTo(Player)
		end
	elseif (DialogID == 1010490) and (1 == ExitID) then
		local Field = this:GetField()
		local Pos = vec3(66292.0, 48505.7, -593.9)
		if (Field:GetNPCCount(101002) == 0) and (Field:GetNPCCount(101253) == 0) then
			Field:SpawnLimited(101253, Pos, 30)
			local Iris = Field:GetSpawnNPC(101253)
			Iris:FaceTo(Player)
		end
	elseif (DialogID == 1010491) and (1 == ExitID) then
		local Field = this:GetField()
		local Pos = vec3(66292.0, 48505.7, -593.9)
		if (Field:GetNPCCount(101002) == 0) and (Field:GetNPCCount(101253) == 0) then
			Field:Spawn(101002, Pos)
			--local Iris = Field:GetSpawnNPC(101002)
			--Iris:FaceTo(Player)
		end
	elseif (DialogID == 1010492) and (1 == ExitID) then
		local Field = this:GetField()
		local Pos = vec3(66292.0, 48505.7, -593.9)
		if (Field:GetNPCCount(101002) == 0) and (Field:GetNPCCount(101253) == 0) then
			Field:Spawn(101253, Pos)
			--local Iris = Field:GetSpawnNPC(101002)
			--Iris:FaceTo(Player)
		end
	end
end


