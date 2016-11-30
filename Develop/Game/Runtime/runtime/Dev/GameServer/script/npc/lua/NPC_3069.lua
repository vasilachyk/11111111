-- 인젠 자유 경비대 여자(순찰)

function NPC_3069:OnDialogExit(Player, nDialogID, nExit)
	this:ClearJob()
	this:Wait(2)
	--[[
	if (3071 == nDialogID) then
		if (2 == nExit) then
			this:Balloon("$$NPC_3069_9")
		end
		if (3 == nExit) then
			this:Balloon("$$NPC_3069_12")
		end
		if (4 == nExit) then
			this:Balloon("$$NPC_3069_15")
		end
		if (5 == nExit) then
			this:Balloon("$$NPC_3069_18")
		end
		if (6 == nExit) then
			this:Balloon("$$NPC_3069_21")
		end
		if (7 == nExit) then
			this:Balloon("$$NPC_3069_24")
		end
		if (8 == nExit) then
			this:Balloon("$$NPC_3069_27")
		end		
		if (9 == nExit) then
			this:Balloon("$$NPC_3069_30")
		end
		if (10 == nExit) then
			this:Balloon("$$NPC_3069_33")
		end
		if (11 == nExit) then
			this:Balloon("$$NPC_3069_36")
		end	
		if (12 == nExit) then
			this:Balloon("$$NPC_3069_39")
		end			
		if (13 == nExit) then
			this:Balloon("$$NPC_3069_42")
		end		
	end--]]
end
