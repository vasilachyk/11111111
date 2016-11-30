-- 공개수배 '마녀'

function Quest_101005:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	local Field = Player:GetField()
	if (ObjectiveID == 3) then
		local North = Field:GetSpawnNPC(101235)
		North:GainBuff(110013)
	elseif (ObjectiveID == 4) then
		local South = Field:GetSpawnNPC(101234)
		South:GainBuff(110013)
	end
end


