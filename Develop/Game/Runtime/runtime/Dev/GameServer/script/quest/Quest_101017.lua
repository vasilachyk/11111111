
--[[
function Quest_101017:OnBegin(Player, NPC)
	GLog("1".."/n");
	
	local Field = Player:GetField()
	
	local smoke1 = Field:GetNPC(101264)
	local smoke2 = Field:GetNPC(101265)
	local smoke3 = Field:GetNPC(101266)
	local smoke4 = Field:GetNPC(101267)		
	
	GLog("3".."/n");
		
	smoke1:GainBuff(40904)
	smoke2:GainBuff(40904)
	smoke3:GainBuff(40904)
	smoke4:GainBuff(40904)
	
	GLog("2".."/n");
	
end


function Quest_101017:OnObjComplete(Player, GetQuestVar)

	local Field = Player:GetField()
	
	local smoke1 = Field:GetNPC(101264)
	local smoke2 = Field:GetNPC(101265)
	local smoke3 = Field:GetNPC(101266)
	local smoke4 = Field:GetNPC(101267)		
	
	GLog("1".."/n");
	
	if (1 == Player:GetQuestVar(101017)) then	
		GLog("ddd".."/n");	
		smoke1:RemoveBuff(40904)
	
		
	elseif (2 == GetQuestVar(101017)) then	
		GLog("zzz".."/n");
		smoke2:RemoveBuff(40904)
		
	elseif (3 == GetQuestVar(101017)) then	
		
		GLog("eee".."/n");			
		smoke3:RemoveBuff(40904)
				
	elseif (4 == GetQuestVar(101017)) then	
		
		GLog("ssss".."/n");			
		smoke4:RemoveBuff(40904)
	end	
end
--]]
