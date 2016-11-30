function Field_1180081:OnDie(DespawnInfo)
	--키메라가 죽으면 장벽이동센서를 켬
	if (DespawnInfo.SpawnID == 511000) then						
		this:SetTimer(118008, 20, false)		
	end 
end

--- 부활지점 체크 센서
function Field_1180081:OnSensorEnter_2(Actor)	
	-- this:DisableSensor(2)	
	-- AsPlayer(Actor):PartyCutscene(119001)	
	-- this:SetTimer(30, 5, false))
end

function Field_1180081:OnSensorEnter_3(Actor)	
	this:SpawnByID(511000)	
	this:SpawnByID(1000)
	
	local WarpPos = this:GetMarkerPos(3)
	AsPlayer(Actor):Warp(WarpPos)	
	
	this:DisableSensor(3)
end

--컷신이 추가되면 활성화시켜야 하는 스크립트
function Field_1180081:OnEndCutscene(Player, CutsceneID)
	this:ActivateSpawnGroup(1)		
	this:SpawnByID(511000)		
	local WarpPos = this:GetMarkerPos(2)
	Player:Warp(WarpPos)
	-- local Chimera = this:GetSpawnNPC(511000)
	-- Chimera:UseTalentSelf(251100070)
	
end

-- [ NPC_Session ] 키메라 내려오는 연출

function Field_1180081:OnSessionScene_Chimera_Begin(Session)
	--GLog("Field_1180081:OnSessionScene_Chimera_Begin()\n")
	local Chimera = AsNPC( Session:FindBookmark("NPC_Chimera") )	
	-- Chimera:UseTalentSelf(251100070)
	-- local Chimera = this:GetSpawnNPC(511000)
	Chimera:UseTalentSelf(251100070)	
	Session:ChangeScene("Combat")
	
	local Effect = this:GetSpawnNPC(1000)	
	Effect:GainBuff(111409)				
	
	-- Chimera:Roam(1500, 0 )
	--Session:AddChangeSceneRule("Dead", Chimera, "dead", {})
end

function Field_1180081:OnSessionScene_Chimera_Combat(Session)
	--GLog("Field_1180081:OnSessionScene_Chimera_Combat()\n")
	Session:CombatAll()
	Session:EndSession()
end

function Field_1180081:OnSessionScene_Chimera_Dead(Session)
	-- Session:EndSession()
end

function Field_1180081:OnSessionScene_Chimera_Finish(Session)
	--GLog("Field_1180081:OnSessionScene_Chimera_Finish()\n")
end


function Field_1180081:OnCreate()
--	GLog("Field_1180081:OnCreate()\n")
	this:ActivateSpawnGroup(1)
end


function Field_1180081:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:SetAlwaysRun(true)
	
	local dice = math.random(1,3)
	
	local soldier00 = this:GetSpawnNPC(9100)
	local soldier01 = this:GetSpawnNPC(9101)	
	local soldier02 = this:GetSpawnNPC(9102)
	
	local soldier03 = this:GetSpawnNPC(9200)	
	local soldier04 = this:GetSpawnNPC(9201)		
	
	local soldier05 = this:GetSpawnNPC(9300)
	local soldier06 = this:GetSpawnNPC(9301)
	local soldier07 = this:GetSpawnNPC(9302)
	
	local soldier08 = this:GetSpawnNPC(9400)	
	local soldier09 = this:GetSpawnNPC(9401)	
	
	
	if (SpawnInfo.SpawnID == 511000) then 			
		local Session = this:MakeSession("Chimera", {SpawnInfo.NPC})
		if not Session then
			GLog("Session:Chimera is nil.\n")
		end
		Session:AddBookmark("NPC_Chimera", SpawnInfo.NPC)
	end 	
	
	if (SpawnInfo.SpawnID == 9100) then 
		SpawnInfo.NPC:Patrol({100, 101, 102, 103, 104}, PT_ONCE)				
		if dice == 1 then
			SpawnInfo.NPC:SayNow("$$Quest_118008_003")		
		elseif dice == 2 then
			SpawnInfo.NPC:SayNow("$$Quest_118008_004")		
		elseif dice == 3 then
			SpawnInfo.NPC:SayNow("$$Quest_118008_005")				
		end				
		
	end
	
	if (SpawnInfo.SpawnID == 9101) then 		
		SpawnInfo.NPC:Patrol({100, 101, 102, 103, 104}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9102) then			
		SpawnInfo.NPC:Patrol({100, 101, 102, 103, 104}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9200) then 			
		SpawnInfo.NPC:Patrol({200, 201, 202, 203, 204}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9201) then			
		SpawnInfo.NPC:Patrol({200, 201, 202, 203, 204}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9300) then 			
		SpawnInfo.NPC:Patrol({300, 301, 302}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9301) then 		
		SpawnInfo.NPC:Patrol({300, 301, 302}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9302) then			
		SpawnInfo.NPC:Patrol({300, 301, 302}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9400) then 			
		SpawnInfo.NPC:Patrol({400, 401, 402}, PT_ONCE)		
	
	elseif (SpawnInfo.SpawnID == 9401)  then			
		SpawnInfo.NPC:Patrol({400, 401, 402}, PT_ONCE)		
	end 
end


function Field_1180081:OnTimer(TimerID)

	if (TimerID == 100) then
		
		
		this:SpawnByID(9100)
		-- this:SpawnByID(9101)
		-- this:SpawnByID(9102)
		
		
		this:SpawnByID(9200)
		-- this:SpawnByID(9201)
		
		
		-- this:SpawnByID(9300)
		-- this:SpawnByID(9301)
		this:SpawnByID(9302)
		
		
		this:SpawnByID(9400)
		-- this:SpawnByID(9401)

	
	end
	
	if (TimerID == 118008) then
		this:EnableSensor(118008)			
	end
	
	if (TimerID == 30) then
		this:SpawnByID(511000)
	end
	
end