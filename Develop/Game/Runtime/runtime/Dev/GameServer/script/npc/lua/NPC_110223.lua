-- 정찰병 린데일

-- (구) 부상당한 병사 (남 - 염산)
--[[
function NPC_110223:Init(NPCID)
	
end

function NPC_110223:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_110223:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_110223_14")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_110223_17")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_110223_20")
		end	
	end
end

function NPC_110223:OnDialogExit(Player, nDialogID, nExit)
	if (1100043 == nDialogID) then
		if (2 == nExit) then
			
			local QuestProgress = Player:GetQuestVar(110004)
			
			if (0 == QuestProgress) then
				Player:Narration("$$NPC_110223_32")
				Player:UpdateQuestVar(110004, 1)
			end
			if (1 == QuestProgress) then
				Player:Narration("$$NPC_110223_36")
				Player:UpdateQuestVar(110004, 2)
			end
			if (2 == QuestProgress) then
				Player:Narration("$$NPC_110223_40")			
				Player:UpdateQuestVar(110004, 3)				
			end
			if (3 == QuestProgress) then
				Player:Narration("$$NPC_110223_44")			
				Player:UpdateQuestVar(110004, 4)
			end
			
			this:Despawn(true)
		end
		if (3 == nExit) then		
			this:Die(Player)
		end		
	end
end
--]]