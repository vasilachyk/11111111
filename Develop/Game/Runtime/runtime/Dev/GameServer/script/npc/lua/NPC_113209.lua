-- 미치광이 연금술사 우르

function NPC_113209:OnDialogExit(Player, DialogID, ExitID) -- 능력 밖의 일 : 대화 시 아이젠트 트리어를 소환
	if (DialogID == 1130731) and (1 == ExitID) then
		Player:UpdateQuestVar(113073, 2)
		local Field = this:GetField()
		local Pos = vec3(31336.23, 47340.88, 1456.90)
		Field:SpawnLimited(113215, Pos, 30)
		local Ghost = Field:GetSpawnNPC(113215)
		Ghost:FaceTo(this)
	end
end


