-- 컷신 미리보기


-- Event List
function NPC_318:OnDialogExit(Player, nDialogID, nExit)
	GLog0("NPC_318:OnInteract\n")

	if (318 == nDialogID) then

		if (10 == nExit) then
			Player:Cutscene(1021)
		end
		if (11 == nExit) then
			Player:PartyCutscene(1022)
		end	
		if (12 == nExit) then
			Player:PartyCutscene(109000)
		end		
		if (15 == nExit) then
			Player:Cutscene(209003)
		end		
		if (16 == nExit) then
			Player:Cutscene(209001)
		end		
		if (17 == nExit) then
			Player:Cutscene(109004)
		end	
		if (18 == nExit) then
			Player:Cutscene(119001)
		end				
	end
end
