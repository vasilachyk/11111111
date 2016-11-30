function NPC_101259:OnDialogExit(Player, nDialogID, nExit)
	
	--[[ additem 이 안되는 것 같으므로 대화에서 직접 주는걸로
	paper = Player:GetItem(10162)
	dying = Player:GetItem(10198)

	
	--모르겟다! 장재곤 -- ADDITEM 
	if (1010042 == nDialogID) and (1 == nExit) then
	
		if (paper == 0 ) then 	
			local Player = AsPlayer(Actor)
			Player:AddItem(10162, 1)	
		end
	
		if	(dying == 0 ) then 		
			local Player = AsPlayer(Actor)
			Player:AddItem(10198, 1)		
		end	
	end
		
	]]--
	
end