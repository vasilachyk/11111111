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

--체크포인트 센서
function Field_1010321:OnSensorEnter_2(Actor)	
end

function Field_1010321:OnDie(DespawnInfo)
		
	GLog("1".."/n");
	-- 지그니프가 죽으면
	if (DespawnInfo.SpawnID == 1) then 
		this:EnableSensor(1)								
	end	 
end

function Field_1010321:OnSensorEnter_100(Actor) 		
	this:SpawnByID(101417)
end


function Field_1010321:OnSpawn(SpawnInfo)
	
	if SpawnInfo.NPCID == 101417 then
		SpawnInfo.NPC:SayNow("$$Field_10140905")
		SpawnInfo.NPC:SetAlwaysRun(true)		
		this:SetTimer(101417 ,5, false)	
		
		this:SpawnByID(1) --지그니프				
		
		for i = 10141800, 10141803 do		
			this:SpawnByID(i)			
		end
		
	end
end

function Field_1010321:OnTimer(TimerID)
	if TimerID == 101417 then		
		this:DespawnByID(10983200)
		this:DisableSensor(100)
		local clode = this:GetSpawnNPC(101417)
		clode:MoveToMarker(10141700)		
		
	end
end


-- function Field_1010321:OnSensorEnter_1(Actor)
	-- GLog("2".."/n");
	-- if (Actor:IsPlayer() == true) then
		-- AsPlayer(Actor):GateToMarker(101, 101030);		
	-- end
-- end 
