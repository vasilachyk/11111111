-- 모켄의 해적 (티안의 전령 퀘스트에서 기습하는 녀석 1)
--[[
function NPC_109199:OnSpawn(SpawnInfo)
	this:Say("저놈이 티안의 전령이다!")
	this:SetTimer(1, 40, false)
end

function NPC_109199:OnTimer(TimerID)
	this:Despawn(false)
end
--]]