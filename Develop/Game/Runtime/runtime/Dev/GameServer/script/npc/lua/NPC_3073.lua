-- 드벤 (기다리는 남자)
function NPC_3073:Init(NPCID)
	
end

function NPC_3073:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_3073:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_3073_14")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3073_17")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3073_20")
		end
	end
end
