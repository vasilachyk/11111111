function Field_1180111:OnCreate()	
	this:SpawnByID(118212)	
	this:ActivateSpawnGroup(1000)
end

function Field_1180111:OnSensorEnter_140711(Actor)	
	this:DisableSensor(140711)	
	this:SetTimer(2, 1, false)
end

-- function Field_1180111:OnSensorEnter_140710(Actor)	
	-- this:DisableSensor(2)		
	
	-- local Effector = {1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009,1010,1011}		
	-- local Effector = {1000}		
	
	-- for i in ipairs(Effector) do			
		-- local Effect = this:GetSpawnNPC(Effector[i])		
		-- Effect:GainBuff(111408)				
	-- end	
-- end




--체크포인트에서도 탈렌트를 사용할 수 있게 하기
function Field_1180111:OnSensorTalent_2(Actor, TalentID) 	
	if (this:CheckSensor(140710) == true ) and (AsPlayer(Actor):CheckCondition(1180111) ==  true ) and (TalentID == 140806) then
	
		local Scope = this:GetSpawnNPC(118212)
		Scope:EnableInteraction()
		Scope:RemoveBuff(111410)
		
		AsPlayer(Actor):Tip("$$Quest_118011_001")
		this:DisableSensor(140710)
	end
end


--망원경 수리 인터렉션 센서

function Field_1180111:OnSensorTalent_140710(Actor, TalentID) 	
	if (AsPlayer(Actor):CheckCondition(1180111) ==  true ) and (TalentID == 140806) then			
	
		local Scope = this:GetSpawnNPC(118212)
		Scope:EnableInteraction()
		Scope:RemoveBuff(111410)
		
		AsPlayer(Actor):Tip("$$Quest_118011_001")
		
		
		-- local meat = this:GetNPC(118213)
		-- local chimera = this:GetNPC(511000)
		
		-- chimera:MoveToActor(meat, 251100070)	
		
		this:DisableSensor(140710)
	end
end


function Field_1180111:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 511000) then						
		this:SetTimer(118008, 20, false)		
	end 	
end

function Field_1180111:OnTimer(TimerID)	

	if (TimerID == 118008) then
		this:EnableSensor(118008)			
	end
	
	if (TimerID == 2) then
		this:SpawnByID(511000)	
	end
end



function Field_1180111:OnSpawn(SpawnInfo)

	if (SpawnInfo.SpawnID == 511000) then 			
	
		local Session = this:MakeSession("Chimera", {SpawnInfo.NPC})
		local Effector = {1000}		
		local Scope = this:GetSpawnNPC(118212)
		
		if not Session then
			GLog("Session:Chimera is nil.\n")
		end
		
		Scope:DespawnNow()				
		Session:AddBookmark("NPC_Chimera", SpawnInfo.NPC)
		
		
		-- local Effector = {1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009,1010,1011}		
		-- local Effector = {1000}		
	
		-- for i in ipairs(Effector) do			
			-- local Effect = this:GetSpawnNPC(Effector[i])		
			-- Effect:RemoveBuff(111408)				
		-- end	
	
	end 		
end



function Field_1180111:OnSessionScene_Chimera_Begin(Session)
	--GLog("Field_1180081:OnSessionScene_Chimera_Begin()\n")
	local Chimera = AsNPC( Session:FindBookmark("NPC_Chimera") )	
	local Effector = {1000}		
	-- local Pos = vec3(45383.0, 46982.0, 281.0)		
	-- Chimera:Warp(Pos)
	
	Chimera:UseTalentSelf(251100070)
	Session:ChangeScene("Combat")
	
	for i in ipairs(Effector) do			
			local Effect = this:GetSpawnNPC(Effector[i])		
			Effect:GainBuff(111409)				
			-- Effect:RemoveBuff(111408)				
	end	
		
	--Session:AddChangeSceneRule("Dead", Chimera, "dead", {})
end

function Field_1180111:OnSessionScene_Chimera_Combat(Session)
	--GLog("Field_1180081:OnSessionScene_Chimera_Combat()\n")
	Session:CombatAll()	
	Session:EndSession()
end

function Field_1180111:OnSessionScene_Chimera_Dead(Session)
	-- Session:EndSession()
end

