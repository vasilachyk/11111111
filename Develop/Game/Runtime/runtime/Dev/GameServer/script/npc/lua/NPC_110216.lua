-- 부상당한 병사 (남 - 절상)
function NPC_110216:Init(NPCID)
	
end

function NPC_110216:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_110216:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_110216_14")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_110216_17")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_110216_20")
		end	
	end
end

function NPC_110216:OnDialogExit(Player, nDialogID, nExit)
	if (1100042 == nDialogID) then
		if (2 == nExit) then
			
			local QuestProgress = Player:GetQuestVar(110004)
			
			if (0 == QuestProgress) then
				Player:Narration("$$NPC_110216_32")
				Player:UpdateQuestVar(110004, 1)
			end
			if (1 == QuestProgress) then
				Player:Narration("$$NPC_110216_36")
				Player:UpdateQuestVar(110004, 2)
			end
			if (2 == QuestProgress) then
				Player:Narration("$$NPC_110216_40")			
				Player:UpdateQuestVar(110004, 3)				
			end
			if (3 == QuestProgress) then
				Player:Narration("$$NPC_110216_44")			
				Player:UpdateQuestVar(110004, 4)
			end
			
			this:Despawn(true)
		end
		if (3 == nExit) then		
			this:Die(Player)
		end		
	end
end
