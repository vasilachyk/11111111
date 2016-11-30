-- 베스피오 잔당 처리
function Field_1070161:OnSensorEnter_2(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		Field:DisableSensor(2)						
		local Rakuri = Field:GetSpawnNPC(20)
		local Remnant1 = Field:GetSpawnNPC(1)
		local Remnant2 = Field:GetSpawnNPC(2)
		local Remnant3 = Field:GetSpawnNPC(10)
		Remnant1:WaitFor(Rakuri)
		Remnant2:WaitFor(Rakuri)
		Remnant3:WaitFor(Rakuri)
		Rakuri:Say("$$Field_1070161_13")
		Rakuri:Say("$$Field_1070161_14")
		Rakuri:Say("$$Field_1070161_15")
		Rakuri:Say("$$Field_1070161_16")
		Rakuri:Say("$$Field_1070161_17")	
		Rakuri:NextAction()
		--Rakuri:EnableCombat()
		Rakuri:SetAlwaysRun(true)
		Rakuri:SetTarget(Actor)
		--Rakuri:Attack(Actor)
		--Remnant1:EnableCombat()
		--Remnant2:EnableCombat()		
		--Remnant3:EnableCombat()				
		Remnant1:Attack(Actor)
		Remnant2:Attack(Actor)
		Remnant3:Attack(Actor)
	end
end

function Field_1070161:OnSensorEnter_3(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		Field:DisableSensor(3)				
		local Rakuri = Field:GetSpawnNPC(20)
		local Remnant1 = Field:GetSpawnNPC(5)
		local Remnant2 = Field:GetSpawnNPC(6)
		Rakuri:NonDelaySay("$$Field_1070161_39")
		Field:EnableSensor(4)					
		Rakuri:MoveToMarker(11)		
		Rakuri:MoveToMarker(6)
		Rakuri:MoveToMarker(7)
		Rakuri:MoveToMarker(10)
		Rakuri:MoveToMarker(8)		
		Remnant1:ClearJob()
		Remnant2:ClearJob()
		--Remnant1:EnableCombat()
		--Remnant2:EnableCombat()
		Remnant1:Attack(Actor)
		Remnant2:Attack(Actor)
	end
end

function Field_1070161:OnSensorEnter_4(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		Field:DisableSensor(4)				
		local Rakuri = Field:GetSpawnNPC(20)
		local Remnant1 = Field:GetSpawnNPC(3)
		local Remnant2 = Field:GetSpawnNPC(4)
		local Remnant3 = Field:GetSpawnNPC(7)
		local Remnant4 = Field:GetSpawnNPC(8)
		local Remnant5 = Field:GetSpawnNPC(9)

		Rakuri:NonDelaySay("$$Field_1070161_66")
		Rakuri:MoveToMarker(12)		
		Rakuri:MoveToMarker(9)
		--Remnant1:EnableCombat()
		--Remnant2:EnableCombat()
		--Remnant3:EnableCombat()
		--Remnant4:EnableCombat()
		--Remnant5:EnableCombat()
		Remnant1:Attack(Actor)
		Remnant2:Attack(Actor)
		Remnant3:Attack(Actor)
		Remnant4:Attack(Actor)
		Remnant5:Attack(Actor)
	end
end

function Field_1070161:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field
	local Rakuri = Field:GetSpawnNPC(20)
	Male = Field:GetNPCCount(107035)
	Female = Field:GetNPCCount(107036)
	if (tonumber(Male) + tonumber(Female) == 7) then
		Rakuri:NonDelaySay("$$Field_1070161_88")
		Field:EnableSensor(3)			
		Rakuri:MoveToMarker(13)
		Rakuri:MoveToMarker(2)
		Rakuri:MoveToMarker(3)
		Rakuri:MoveToMarker(4)
		Rakuri:MoveToMarker(11)
		Rakuri:MoveToMarker(5)	
	end
	if (Field:GetNPCCount(107035) == 0) and (Field:GetNPCCount(107036) == 0) then
		Rakuri:Say("$$Field_1070161_98")
		Rakuri:NonDelaySay("$$Field_1070161_99")
		Rakuri:EnableCombat()
		Rakuri:Attack(Rakuri:GetTarget())
	end
	if (Field:GetNPCCount(107037) == 0) then
		Field:DespawnByID(11) -- 장애물 제거
	end
end
