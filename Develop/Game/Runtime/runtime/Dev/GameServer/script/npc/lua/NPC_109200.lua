-- 모켄의 해적 (티안의 전령 퀘스트에서 기습하는 녀석 2)
--[[
function NPC_109200:OnSpawn(SpawnInfo)
	this:Say("살려서 보내지 마!")
	this:SetTimer(1, 40, false)
end

function NPC_109200:OnTimer(TimerID)
	this:Despawn(false)
end
--]]


