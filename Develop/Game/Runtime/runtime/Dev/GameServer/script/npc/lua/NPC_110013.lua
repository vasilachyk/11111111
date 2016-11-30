-- 렌고트 정예병
--[[
function NPC_110013:OnDialogExit(Player, nDialogID, nExit)
	if (1100222 == nDialogID) then
		if (1 == nExit) then
			local Position = Player:GetPos()
			local InputVar = Player:GetQuestVar(110022)
			local OutputVar = tonumber(InputVar) + 1
			Player:UpdateQuestVar(110022, OutputVar)
			Player:Narration( tostring(OutputVar) .. "개의 깃발을 꽂았습니다.")
			
			if (10 == OutputVar) then
				Player:Narration("$$NPC_110013_13")
			end
		end
	end
end
--]]

function NPC_110013:OnTryHit(Actor, TalentID)
	if (140010 == TalentID) then
		
		this:GainBuff(110004)
		--this:SetMFModValue(MF_STUN, 100)
		--this:SetMFModWeight(MF_STUN, 1000)
		
	end
end
