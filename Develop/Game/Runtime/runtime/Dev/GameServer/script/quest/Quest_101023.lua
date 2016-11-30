-- 작전명 '스파이'

function Quest_101023:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	local Field = Player:GetField()	
	local Katrina = Field:GetNPC(101216)
	local Randy = Field:GetSpawnNPC(10005)
	local Son = Field:GetSpawnNPC(10014)	
	local NpcPos = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -100 )	
	if (ObjectiveID == 1) then
		if (Trigger == true) then
			Player:UpdateQuestVar(101023, 1)	
			-- 스폰된 카트리아와 메린샤가 말풍선을 하며 이펙트도 뿌린다.
			-- 메린샤가 유저한테도 마법을 부리지만 다른 이펙트 색이 나온다.-_-
		
		
		end
	end
end
