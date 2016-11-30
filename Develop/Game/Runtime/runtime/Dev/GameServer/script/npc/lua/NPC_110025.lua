--[[
	Brevi
--]]
function NPC_110025:Init(NPCID)
	
end

function NPC_110025:OnYell(RequestNPC, TargetActor)
	this:Assist(RequestNPC)
end
