-- 닷소의 집
function Field_1070541:OnSensorEnter_3(Actor)
	if (Actor:IsPlayer() == true) then
		-- local Field = AsPlayer(Actor):GetField()		
		local Maid = this:GetSpawnNPC(8)
		local Session = this:MakeSession("TalkMaid",{Maid})
		Session:AddBookmark("Player", Actor)		
	end
end

function Field_1070541:OnSessionScene_TalkMaid_Begin(Session)		
		this:DisableSensor(3)	
		Session:Blocking()
		
		local Maid = this:GetSpawnNPC(8)
		
		Maid:FaceTo(Session:FindBookmark("Player"))
		Maid:Say("$$Field_1070541_8") -- 어서오세요. 또 뵙게되었네요.
		Maid:FaceTo(Session:FindBookmark("Player"))		
		Maid:Say("$$Field_1070541_10") -- 주인님 말씀으로는 찾는 물건이 갈대밭의 사냥꾼이란 시집이라면서요?
		Maid:FaceTo(Session:FindBookmark("Player"))		
		Maid:Say("$$Field_1070541_12") -- 일단은 서재에서부터 찾아보도록 하죠.
		Maid:NonDelaySay("$$Field_1070541_13") -- 이쪽이에요.
		Maid:Patrol({11,12,13}, PT_ONCE)
		Maid:Say("$$Field_1070541_15")	 -- 어디 보자.. 여기에는 없는것 같고..
		Maid:MoveToMarker(17)
		
		
		Maid:Say("$$Field_1070541_19") -- 으음.. 서재에는 없는 거 같네요.
		Maid:FaceTo(Session:FindBookmark("Player"))
		Maid:Say("$$Field_1070541_21") -- 아, 생각났어요.
		Maid:Say("$$Field_1070541_22") -- 꽤 오래전에 안 쓰는 책을 모아 창고로 옮겨두었던 걸로 기억해요. 분명히 거기 있을 거에요.
		Maid:NonDelaySay("$$Field_1070541_23") -- 절 따라오세요.	
		Maid:Patrol({11,14,15}, PT_ONCE)
		
		-- AsPlayer(Actor):UpdateQuestVar(107054, 1)
		Session:ChangeScene("SensorEnable")
			
end

function Field_1070541:OnSessionScene_TalkMaid_SensorEnable(Session)
		this:EnableSensor(4)	
		Session:EndSession()
end
		

function Field_1070541:OnSensorEnter_4(Actor)
	-- local Field = AsPlayer(Actor):GetField()
	local Maid = this:GetSpawnNPC(8)	
	local Session = this:MakeSession("MaidTalk2",{Maid})
	Session:AddBookmark("Player", Actor)		
	this:DisableSensor(4)	
	-- AsPlayer(Actor):UpdateQuestVar(107054, 2)	
end

	
function Field_1070541:OnSessionScene_MaidTalk2_Begin(Session)
		local Maid = this:GetSpawnNPC(8)	
		
		Maid:FaceTo(Session:FindBookmark("Player"))		
		Maid:Say("$$Field_1070541_36") -- 이 문으로 들어가면 지하에 있는 창고로 내려갈 수 있어요.
		Maid:FaceTo(Session:FindBookmark("Player"))				
		Maid:Say("$$Field_1070541_38") -- 먼저 내려가도록 하세요. 저도 곧 뒤쫓아가겠습니다.				
		
		Session:ChangeScene("EnableSensor")		
end
		
function Field_1070541:OnSessionScene_MaidTalk2_EnableSensor(Session)
	Session:Blocking()
	this:EnableSensor(5)
	Session:EndSession()
end

--[[
function Field_1070541:OnDie(DespawnInfo)
	-- GLog("DespawnInfo.SpawnID = "..DespawnInfo.SpawnID.."\n")

	if (DespawnInfo.NPCID == 3057) then
		GLog("DespawnInfo.NPCID = "..DespawnInfo.NPCID.."\n")

		if (self:IsReadyToSpawnBoss(this) == true) then
			self:SpawnBoss(this)
		end

	elseif (DespawnInfo.NPCID == 3058) then
		GLog("DespawnInfo.NPCID = "..DespawnInfo.NPCID.."\n")
	end
end
--]]