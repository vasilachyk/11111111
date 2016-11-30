-- 간호병 글로리에
function NPC_110222:Init(NPCID)
	
end

function NPC_110222:OnDialogExit(Player, DialogID, ExitID)
	if (110222 == DialogID) then
		if (2 == ExitID) then
			Player:RemoveBuff(1910) -- 극심한 피로 제거
			Player:GainBuff(88901) -- 치료 버프
		end			
	end
end
