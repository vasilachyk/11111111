-- 마코트 부족 보석 감정사

function NPC_111015:OnDialogExit(Player, DialogID, ExitID)
	if (1110282 == DialogID) and (1 == ExitID) then
		this:DespawnNow(true)
	end
end
