-- ÄÚÀ¢ ´ËÁö´ë : ºÀºÀÀÇ ¸¶À» (combat)

function Field_1030042:OnSpawn(SpawnInfo)
	if (SpawnInfo.SpawnID == 103520) then	
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.NPC:Patrol({101, 102, 103, 104},PT_ONCE)
	end		
end

function Field_1030042:OnSensorEnter_2(Actor) -- ¼¼³×½º µîÀå
	if (Actor:IsPlayer() == true) then	
		this:DisableSensor(2)
		this:EnableSensor(1030043)		
		this:SpawnByID(103520)
	end
end
