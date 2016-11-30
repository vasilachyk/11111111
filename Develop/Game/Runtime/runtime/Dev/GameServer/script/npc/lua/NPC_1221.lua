-- 리츠 쉐프 애드워디

function NPC_1221:OnDialogExit(Player, DialogID, Exit)
	if (9911011 == DialogID and 1 == Exit) then -- 고양이 버프 얻기
		Player:GainBuff(700007)	
	end
end
