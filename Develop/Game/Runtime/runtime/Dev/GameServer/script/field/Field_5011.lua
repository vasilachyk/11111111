-- ¿À¿°µÈ È­¿ø(Å×½ºÆ®)


function Field_5011:OnSensorEnter_1(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		--Field:DisableSensor(20)			
		--Field:EnableSensor(21)
		
		Field:SpawnByID(9)  -- ¹ú ÃâÇö1
		Field:SpawnByID(10)  -- ¹ú ÃâÇö1
		Field:SpawnByID(11)  -- ¹ú ÃâÇö1
		
	end
end

function Field_5011:OnSensorEnter_2(Actor)
	if (Actor:IsPlayer() == true) then
		local Field = AsPlayer(Actor):GetField()
		
		Field:SpawnByID(56)  -- °¡½Ãµ¢±¼ ÃâÇö1
		Field:SpawnByID(68)  -- °¡½Ãµ¢±¼ ÃâÇö3
		Field:SpawnByID(70)  -- °¡½Ãµ¢±¼ ÃâÇö3
		Field:SpawnByID(71)  -- °¡½Ãµ¢±¼ ÃâÇö3
		
		
	end
end
	
function Field_5011:OnDie(DespawnInfo)
	local Field = DespawnInfo.Field	
	
	
	if (DespawnInfo.NPCID == 121202) then  -- Å©¸®½ºÅ» ÆÄ±«µÇ¸é
		Field:DespawnByID(22) -- ¹® Á¦°Å1
		
	end
	
	if (DespawnInfo.NPCID == 121206) then  -- Å©¸®½ºÅ» ÆÄ±«µÇ¸é
		Field:DespawnByID(66) -- ¹® Á¦°Å2
		
	end
	
	if (DespawnInfo.NPCID == 121208) then  -- Å©¸®½ºÅ» ÆÄ±«µÇ¸é
		Field:DespawnByID(117) -- ¹® Á¦°Å2
		
	end

end



function Field_5011:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 121205) then
		SpawnInfo.NPC:Patrol({2, 3}, PT_LOOP);
	end
 end





--function Field_5011:OnSpawn(SpawnInfo)
--		
--	if (SpawnInfo.NPCID == 121205) then
--		local Field = SpawnInfo.Field
--		
--		SpawnInfo.NPC:SetAlwaysRun(true)
--		SpawnInfo.NPC:MoveToMarker(2)
--			
--	end

--end

--function Field_5011:OnSensorEnter_2(Actor)
--	if (Actor:IsNPC() == true) then
	
--		if (Actor.NPCID == 121205) then
--			
--			Actor.NPC:MoveToMarker(3)
				
--		end
		
--	end
	
--end