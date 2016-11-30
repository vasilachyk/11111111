-- 보스테스트필드로 보내기
function NPC_990009:Init(NPCID)
	
	
	
end

-- Event List


function NPC_990009:OnDialogExit(Player, nDialogID, nExit)
	GLog0("NPC_990009:OnDialogExit\n");
	
	if (9900005 == nDialogID) then
		if (3 == nExit) then
		    Pos = vec3(42846,40490,576);
		    Player:Gate(107099, Pos);		    
		end;
	end;
end






