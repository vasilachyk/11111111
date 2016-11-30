function NPC_10002:Init(NPCID)
	
	
end

-- Event List
function NPC_10002:OnInteract(Interactor)
	GLog0("NPC_10002:OnInteract\n");
	
end

function NPC_10002:OnDialogExit(Player, nDialogID, nExit)
	GLog0("NPC_10002:OnDialogExit\n");
	
	if (9 == nDialogID) then
		if (1 == nExit) then
			Player:UpdateQuestVar(2, 3);
		end;
	end;
end

function NPC_10002:Final()
end

function NPC_10002:OnThinking()
end
