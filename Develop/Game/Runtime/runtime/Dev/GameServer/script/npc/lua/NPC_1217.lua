-- 리츠 조미료상인 캐치

function NPC_1217:OnSpawn(SpawnInfo)
	this:SetTimer(1, 130, true)
end

function NPC_1217:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		this:Balloon("$$Field_1_41")
	end
end



