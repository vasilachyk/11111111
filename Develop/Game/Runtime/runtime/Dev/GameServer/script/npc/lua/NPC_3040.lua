-- 액자
function NPC_3040:OnSpawn(SpawnInfo)
	this:SetTimer(1, 30, false)
end

function NPC_3040:OnTimer(TimerID)	
	if (TimerID == 1) then	-- 30초 후 사라짐
		this:Despawn(false)
	end	
end