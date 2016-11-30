function NPC_110005:Init(NPCID)

end

function NPC_110005:OnYell(RequestNPC, TargetActor)
	this:Assist(RequestNPC);
end
