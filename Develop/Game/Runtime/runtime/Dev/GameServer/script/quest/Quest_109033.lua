function Quest_109033:OnBegin(Player, NPC)
	--Player:GateToTrial(1090161, false)
	this:UpdateVar(0)
end
--[[
function Quest_109033:OnComplete(Player)
	local Field = Player:GetField()
	Field:EnableSensor(2)
end
--]]