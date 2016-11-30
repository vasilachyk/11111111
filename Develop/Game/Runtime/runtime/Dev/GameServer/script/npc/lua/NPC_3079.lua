-- 인젠 미식가 여
function NPC_3079:Init(NPCID)
	
	
	
	
end

function NPC_3079:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_3079:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then 
			this:Balloon("$$NPC_3079_17")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3079_20")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3079_23")
		end
	end
end
--[[
function NPC0003079:OnInteract(Interactor)
	if( math.random(0,3) == 0) then 	
		this:Balloon("$$NPC_3079_30")
	end
	if( math.random(0,3) == 1) then 
		this:Balloon("$$NPC_3079_33")
	end
	if( math.random(0,3) == 2) then 
		this:Balloon("$$NPC_3079_36")
	end
end
--]]