function NPC_102151:OnTalentEnd(TalentID)
	if (210215001 == TalentID) then
		this:Say("$$NPC_102151_3")
		this:Despawn()
		
		local Field = this:GetField()
		local QuestPVP = Field:GetQuestPVP()
		QuestPVP:EndEvent(2, 2)
	
	elseif (210215002 == TalentID) then  -- 짧은 제사가 마치면
		
		this:Say("$$NPC_102151_12")
		this:Patrol({9005,9006}, PT_ONCE)
		
		-- local Field = this:GetField()
		-- Field:SpawnByID(102192)

	elseif (210215003 == TalentID) then  -- 짧은 제사가 마치면
		
		-- this:Say("$$NPC_102151_20")
		this:Patrol({9007,9008,9009,9010,9011,9012}, PT_ONCE)
		
		-- local Field = this:GetField()
		-- Field:SpawnByID(102193)
	end
end

function NPC_102151:OnDie(DespawnInfo)
	local Field = this:GetField()
	local QuestPVP =Field:GetQuestPVP()
	QuestPVP:EndEvent(2, 1)
end