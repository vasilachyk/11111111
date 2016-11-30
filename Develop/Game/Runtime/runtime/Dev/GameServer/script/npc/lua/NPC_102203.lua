-- ¼ø·ÊÀÚ µ¦½º
--[[
function NPC_102203:OnDialogExit(Player, DialogID, ExitID)	
	if (1020022 == DialogID) and (1 == ExitID) then

		local dice = math.random(0,3)
		if( dice == 0) then 
			this:NonDelayBalloon("$$NPC_102203_8")
			this:Wait(1)
			this:NonDelayBalloon("$$NPC_102203_10")
			Player:Tip("$$NPC_102203_11")
		end
		if( dice == 1) then 
			this:NonDelayBalloon("$$NPC_102203_14")
			this:Wait(1)		
			this:NonDelayBalloon("$$NPC_102203_16")
			Player:Tip("$$NPC_102203_17")
		end
		if( dice == 2) then 
			this:NonDelayBalloon("$$NPC_102203_20")
			this:Wait(1)		
			this:NonDelayBalloon("$$NPC_102203_22")
			Player:Tip("$$NPC_102203_23")			
		end
		if( dice == 3) then 
			this:NonDelayBalloon("$$NPC_102203_26")
			Player:UpdateQuestVar(102002, 2)
			Player:Tip("$$NPC_102203_28")
		end			
	end
end
--]]