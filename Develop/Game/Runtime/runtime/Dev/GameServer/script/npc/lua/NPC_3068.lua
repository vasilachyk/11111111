-- 인젠 자유 경비대 남자(순찰)

function NPC_3068:OnDialogExit(Player, nDialogID, nExit)
	this:ClearJob()
	this:Wait(2)
	--[[if (3071 == nDialogID) then
		if (2 == nExit) then
			this:Balloon("$$NPC_3068_8")		
		end
		if (3 == nExit) then
			this:Balloon("$$NPC_3068_11")		
		end
		if (4 == nExit) then
			this:Balloon("$$NPC_3068_14")
		end
		if (5 == nExit) then
			this:Balloon("$$NPC_3068_17")
		end
		if (6 == nExit) then
			this:Balloon("$$NPC_3068_20")
		end
		if (7 == nExit) then
			this:Balloon("$$NPC_3068_23")
		end
		if (8 == nExit) then
			this:Balloon("$$NPC_3068_26")
		end	
		if (9 == nExit) then
			this:Balloon("$$NPC_3068_29")
		end
		if (10 == nExit) then
			this:Balloon("$$NPC_3068_32")
		end
		if (11 == nExit) then
			this:Balloon("$$NPC_3068_35")
		end	
		if (12 == nExit) then
			this:Balloon("$$NPC_3068_38")
		end			
		if (13 == nExit) then
			this:Balloon("$$NPC_3068_41")
		end		
	end--]]
end

