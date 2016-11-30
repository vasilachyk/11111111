function Field_1180202:OnSensorEnter_1(Actor)	
	-- local var = this:GetSpawnNPC(200)		
	-- var:Say("여기까지 오느라 힘이 다 빠지는구만, 배도 고프고 말이야, 일단 먹을 것이 있다면 건네주게")					
end

function Field_1180202:OnSensorTalent_1(Actor, TalentID)	
	local var = this:GetSpawnNPC(200)	
	
	if (this:CheckSensor(2) == true) and (AsPlayer(Actor):CheckCondition(1180201) ==  true ) and (TalentID == 140807) then
		
		AsPlayer(Actor):Tip("$$Quest_118020_020")
		
		this:DisableSensor(2)		
		this:EnableSensor(999)
		-- var:Say("{ani=cheer}다행이구만 마침 허기져서 모두 지쳐있었거든 더욱 힘이 나는 구만!")
		
		-- var:EnableInteraction()
	end

end


function Field_1180202:OnSensorEnter_2(Actor)	

	AsPlayer(Actor):Tip("$$Quest_118020_021")
	
end


function Field_1180202:OnSensorTalent_2(Actor, TalentID)

	local var = this:GetSpawnNPC(200)	

	if (AsPlayer(Actor):CheckCondition(1180201) ==  true ) and (TalentID == 140807) then					
		
		this:DisableSensor(2)
		
		AsPlayer(Actor):Tip("$$Quest_118020_020")
		
		this:EnableSensor(999)
		-- var:Say("{ani=cheer}다행이구만 마침 허기져서 모두 지쳐있었거든 더욱 힘이 나는 구만!")
		
		-- var:EnableInteraction()
	end

end




function Field_1180202:OnSensorEnter_999(Actor)
	
	-- local var = this:GetSpawnNPC(200)	
	this:DisableSensor(999)				
	-- var:DisableInteraction()
	
	AsPlayer(Actor):Tip("$$Quest_118020_022")		
	AsPlayer(Actor):UpdateQuestVar(118020, 1)	
	this:SpawnByID(118501)
	
	-- this:SetTimer(200, 1, false)	
	
end

function Field_1180202:OnSensorEnter_1000(Actor)	
	
	AsPlayer(Actor):Narration("$$Quest_118020_023")
	-- AsPlayer(Actor):UpdateQuestVar(118020, 2)	
	this:SetTimer(100, 20, false)				
	this:DisableSensor(1000)				
end

function Field_1180202:OnTimer(TimerID)
	
	if TimerID == 100 then	
		this:EnableSensor(999999)	
	end
	
	-- if TimerID == 200 then	
		-- this:Despawn(118400,false)	
	-- end
	
end

function Field_1180202:OnDie(DespawnInfo)	
	
	if DespawnInfo.NPCID == 118501 then		
		this:EnableSensor(1000)		
	end
	
end

function Field_1180202:OnSpawn(SpawnInfo)
	if SpawnInfo.NPCID == 118501 then	
		SpawnInfo.NPC:GainBuff(111409)	
	end
end

