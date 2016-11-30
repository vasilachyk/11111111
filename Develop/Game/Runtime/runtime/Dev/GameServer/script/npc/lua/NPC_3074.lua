-- 마리아 (쇼핑하는 여자)
function NPC_3074:Init(NPCID)
	
	
	
	
end

--[[
function NPC_3074:OnSpawn(SpawnInfo)
	this:SetTimer(1, 120, true)
end

function NPC_3074:OnTimer(TimerID)
	if (TimerID == 1) then
		local dice = math.random(0.2)
		if( dice == 0) then 
			this:Balloon("$$NPC_3074_18")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3074_21")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3074_24")
		end
	end
end
--]]

--[[
function NPC0003074:OnInteract(Interactor)
	if( math.random(0,3) == 0) then 	
		this:Balloon("$$NPC_3074_33")
	end
	if( math.random(0,3) == 1) then 
		this:Balloon(" ")
	end
	if( math.random(0,3) == 2) then 
		this:Balloon(" ")
	end
end
--]]