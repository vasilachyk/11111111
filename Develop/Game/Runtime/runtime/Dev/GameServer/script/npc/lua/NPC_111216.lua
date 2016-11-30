-- 슈나크의 머리 

function NPC_111216:OnTimer(TimerID)
	if (TimerID == 1) then
		this:Despawn(true) -- 불 붙이고 15초 후 타서 없어진다.
	end
end

