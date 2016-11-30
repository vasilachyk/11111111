-- 조사단원 클레오(의 시체)

function NPC_102235:OnDialogExit(Player, DialogID, ExitID)
	if (1110042 == DialogID) and (1 == ExitID) then
		local Field = this:GetField()
		local Aris = Field:GetSpawnNPC(102237)
		Player:UpdateQuestVar(111004, 2)
	end
end
