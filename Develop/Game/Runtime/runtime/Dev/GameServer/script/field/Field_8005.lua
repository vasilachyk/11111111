-- Portal to Ritz Sewer - for test

function Field_8005:OnSpawn(SpawnInfo)
	
	
	if (SpawnInfo.NPCID == 91) then
		

		if (SpawnInfo.SpawnID == 1) then
			--	spawn_8005_2:GetObject(this):JoinGroup(Actor)	
			
		elseif (SpawnInfo.SpawnID == 2) then
			--	spawn_8005_1:GetObject(this):JoinGroup(Actor)	
			
		end
		
	end		
	
end


function Field_8005:OnSensorEnter_2(Actor)
	-- Go to "Teress_Plain"
	AsPlayer(Actor):GateToMarker(107, 1);
end
