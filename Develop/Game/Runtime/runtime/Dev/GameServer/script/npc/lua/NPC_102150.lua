function NPC_102150:OnTalentEnd(TalentID)
	if (210215001 == TalentID) then
		this:Say("$$NPC_102150_3")
		this:Despawn()
	
		local Field = this:GetField()
		local QuestPVP = Field:GetQuestPVP()
		QuestPVP:EndEvent(1, 1)

	elseif (210215002 == TalentID) then  -- 짧은 제사가 마치면
		
		this:Say("$$NPC_102150_12")
		this:Patrol({8008,8009,8010}, PT_ONCE)  -- 이동
		
		-- local Field = this:GetField()
		-- Field:SpawnByID(102190)

	elseif (210215003 == TalentID) then  -- 짧은 제사가 마치면
		
		-- this:Say("$$NPC_102150_20")
		this:Patrol({8011,8012,8013,8014}, PT_ONCE)
		
		-- local Field = this:GetField()
		-- Field:SpawnByID(102191)
	end
end

function NPC_102150:OnDie(DespawnInfo)
	local Field = this:GetField()
	local QuestPVP = Field:GetQuestPVP()
	QuestPVP:EndEvent(1, 2)
end