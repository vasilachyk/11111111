-- function Field_1010321:OnCreate()
	
	-- local wall1 = this:GetSpawnNPC(2)	
	-- local wall2 = this:GetSpawnNPC(3)	
	-- local wall3 = this:GetSpawnNPC(4)	
	-- local wall4 = this:GetSpawnNPC(5)	
	-- local wall5 = this:GetSpawnNPC(6)	
	-- local wall6 = this:GetSpawnNPC(7)	
	-- local wall7 = this:GetSpawnNPC(8)	
	-- local wall8 = this:GetSpawnNPC(9)	
	-- local wall9 = this:GetSpawnNPC(10)	
	
	
	-- wall1:GainBuff(40904)
	-- wall2:GainBuff(40904)
	-- wall3:GainBuff(40904)
	-- wall4:GainBuff(40904)
	-- wall5:GainBuff(40904)
	-- wall6:GainBuff(40904)
	-- wall7:GainBuff(40904)
	-- wall8:GainBuff(40904)
	-- wall9:GainBuff(40904)	
	

-- end

function Field_1010671:OnSensorTalent_2(Actor, TalentID) 		
	
	if (this:CheckSensor(100) == true) and (AsPlayer(Actor):CheckCondition(1010671) ==  true ) and (TalentID == 140051) then			
		this:SetTimer(101417 ,1, false)	
		this:DisableSensor(100)	
	end
	
end


function Field_1010671:OnDie(DespawnInfo)
		
	GLog("1".."/n");
	-- 지그니프가 죽으면
	if (DespawnInfo.SpawnID == 1) then 				
		this:SetTimer(101067, 20, false)							
	end	 
end

function Field_1010671:OnSensorEnter_100(Actor) 		
	this:SpawnByID(101417)
	
	for i = 10141800, 10141803 do		
		this:SpawnByID(i)			
	end
		
end


function Field_1010671:OnSpawn(SpawnInfo)	
	
	-- 촌장이 스폰되면 처리
	if (SpawnInfo.NPCID == 101417) then			
		SpawnInfo.NPC:SayNow("$$Quest_101067_003")
	end

	--주머니가 스폰되면 스크립트 처리	
	-- if (SpawnInfo.NPCID == 101317) then						
	-- end

end

function Field_1010671:OnSensorTalent_100(Actor, TalentID) 		
	if (AsPlayer(Actor):CheckCondition(1010671) ==  true ) and (TalentID == 140051) then			
		this:SetTimer(101417 ,1, false)	
		this:DisableSensor(100)	
	end
end



function Field_1010671:OnTimer(TimerID)
	if (TimerID == 101417) then			
	
		this:DespawnByID(10983200)
		this:SpawnByID(1)
		
		for i = 10141800, 10141803 do
			this:SpawnByID(i)			
		end				
		
		local clode = this:GetSpawnNPC(101417)
		local Sack = this:GetNPC(101317)		
		
		local Session = this:MakeSession("clode", {clode})		
		Session:AddBookmark("NPC_Sack", Sack)		
		Session:AddBookmark("NPC_clode", clode)		
		
		clode:SetAlwaysRun(true)						
		
	end		
	
	-- if (TimerID == 101418) then		
		-- local Sack = this:GetNPC(101317)		
		-- -- local clode = this:GetNPC(101417)		
		-- local clode = this:GetSpawnNPC(101417)
		-- clode:SayNow("안녕~")
		-- Sack:Die(clode)
		
		-- this:SetTimer(101419,5, false)				
	-- end
	
	-- if (TimerID == 101419) then		
	
		-- local Sack = this:GetNPC(101317)		
		-- local clode = this:GetSpawnNPC(101417)
		
		-- this:Despawn(Sack, false)
		-- this:DespawnByID(clode, false)
	
	-- end	
	
	if (TimerID == 101067) then		
		this:EnableSensor(1)			
	end
	
end


function Field_1010671:OnSessionScene_clode_Begin(Session)
		
		local clode = AsNPC( Session:FindBookmark("NPC_clode"))							
		local Sack = AsNPC( Session:FindBookmark("NPC_Sack"))
		
		clode:Say("$$Quest_101067_002")
		-- clode:MoveToMarker(10141700)								
		clode:StayawayFrom(Sack, 70)								
		-- this:SetTimer(101418,5, false)		
		Session:ChangeScene("Despawn")
	-- clode:SayNow("고맙네! 어서 지그니프를 처치해주게!")
	-- clode:StayawayFrom(Session:FindBookmark("Sack"), 100)		
	-- Session:ChangeScene("Despawn")
end

function Field_1010671:OnSessionScene_clode_Despawn(Session)
	
	local clode = AsNPC( Session:FindBookmark("NPC_clode"))					
	local Sack = AsNPC( Session:FindBookmark("NPC_Sack"))
	
	--동작을 안함 despawn이 안됨
	this:DespawnByID(clode, false)
	Sack:Die(Sack)
	
	GLog("Despawn")
	-- Session:EndSession()		
	-- Session:ChangeScene("Finish")
	Session:EndSession()	
end

function Field_1010671:OnSessionScene_clode_Finish(Session)
	
end
-- function Field_1010321:OnSensorEnter_1(Actor)
	-- GLog("2".."/n");
	-- if (Actor:IsPlayer() == true) then
		-- AsPlayer(Actor):GateToMarker(101, 101030);		
	-- end
-- end 
