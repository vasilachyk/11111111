-- 리오드 방역

function Quest_101018:OnBegin(Player, NPC)
	GLog("aaaaaa1".."/n");
	
	local Field = Player:GetField()
	
	local dust1 = Field:GetNPC(101268)
	local dust2 = Field:GetNPC(101269)
	local dust3 = Field:GetNPC(101270)
	local dust4 = Field:GetNPC(101271)		
	
	GLog("aaaaa3".."/n");
		
	dust1:GainBuff(40904)
	dust2:GainBuff(40904)
	dust3:GainBuff(40904)
	dust4:GainBuff(40904)
	
	GLog("aaaaaw".."/n");
	
end




function Quest_101018:OnObjComplete(Player, ObjectiveID, Trigger)
	--if (ObjectiveID == 2) then
		--local Field = Player:GetField()
		--local Location = Player:GetPos()
		--local Fixed = Math_GetDistancePoint( Player:GetPos(), Player:GetDir(), -200 )		
		--local Mariae = Field:Spawn(101021, Fixed)
		--Mariae:Narration("adfsdf")
		--Mariae:Attack(Player)
	--end
end


