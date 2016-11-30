-- 코볼드란 조각(오우거)

function Quest_111007:OnEnd(Player, NPC)
	local Field = Player:GetField()
	local Totem = Field:GetSpawnNPC(111302)
	local Kaka = Field:GetSpawnNPC(111200)
	
	if (Player:CheckCondition(1110079) == true) then
		Kaka:DisableInteraction()
		Kaka:NonDelaySay("$$Field_111_6",6.1)		-- 마력의 토템과 마력의 펜던트를 이용해 모은 코볼드란을 합치겠다.
		Kaka:StayawayFrom(Totem, 200)
		Kaka:Say("$$Field_111_7",2.9)				-- Pichick Oicvneur
		Kaka:Say("$$Field_111_8",4.9)				-- Dadento Ybvier Terncode Wier
		Kaka:Say("$$Field_111_9",4.3)				-- Gleshac Geedi Reterdnop!
		Kaka:ScriptSelf("Quest_111007_Script")
	end
end

function Quest_111007_Script(Self)
	local Field = Self:GetField()
	local Totem = Field:GetSpawnNPC(111302)
	local Kaka = Field:GetSpawnNPC(111200)	

	Kaka:ReturnToHome()
	Kaka:EnableInteraction()
	Totem:GainBuff(110042)
end
