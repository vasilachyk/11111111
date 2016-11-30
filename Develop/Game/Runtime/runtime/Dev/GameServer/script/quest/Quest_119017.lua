function Quest_119017:OnObjInteract(Player, ObjectiveID, Trigger, Progress, NPC)
	-- local Field = Player:GetField()			
	GLog("NPC in")							
	NPC:DisableInteraction()									
	-- local effector = Field:GetSpawnID(118252)
	
	NPC:GainBuff(111403)
			
			
	-- 퀘스트를 가지고 있을 때 죽이면 이펙터가 생성이 되고						
	-- 퀘스트를 가지고 있지 않을 때 죽이면 이펙터는 생성되지 않는다
			
			
	-- Field:SetTimer(119017,10,false)					
	-- local dice = math.random(1,3)			
	-- if dice == 1 then
	-- Player:Say("더러운 것들은 불 조차 붙지 않는군!!")			
	-- end			
	-- if dice == 2 then
		-- Player:Say("보기만 해도 흉물스럽구만")			
	-- end			
	-- if dice == 3 then
		-- Player:Say("갑자기 속이 메스꺼워 지는군.")			
	-- end			
	-- Field:SetTimer(119017,10,false)				
	-- Field:SetTimer(118252,10,false)							
	-- NPC:SetDecayTime(5)
	-- NPC:Die(Player)
	-- end	
	-- end
end


