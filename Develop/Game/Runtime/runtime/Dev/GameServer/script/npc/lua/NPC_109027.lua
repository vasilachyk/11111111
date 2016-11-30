-- 부상당한 선원
--[[
function NPC_109027:OnDialogExit(Player, DialogID, Exit)
	if (1090072 == DialogID) then
		if (1 == Exit) then
			Player:UpdateQuestVar(109007, 1)
			local Field = Player:GetField()
			Field:SpawnByID(2030)
			Field:SpawnByID(2031)	
			local Attacker1 = Field:GetSpawnNPC(2030)
			local Attacker2 = Field:GetSpawnNPC(2031)	
			
			Attacker1:NonDelayBalloon("$$NPC_109027_13")
			Attacker1:Attack(Player)
			Attacker2:NonDelayBalloon("$$NPC_109027_15")
			Attacker2:Attack(Player)			
		end
	end
end
--]]