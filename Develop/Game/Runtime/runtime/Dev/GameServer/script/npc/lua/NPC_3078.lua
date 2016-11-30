-- 인젠 미식가 남
function NPC_3078:Init(NPCID)
	
	
	
	
end

function NPC_3078:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_3078:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_3078_17")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3078_20")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3078_23")
		end
	end
end
--[[
function NPC0003078:OnInteract(Interactor)
	if( math.random(0,3) == 0) then 	
		this:Balloon("$$NPC_3078_30")
	end
	if( math.random(0,3) == 1) then 
		this:Balloon("$$NPC_3078_33")
	end
	if( math.random(0,3) == 2) then 
		this:Balloon("$$NPC_3078_36")
	end
end
--]]