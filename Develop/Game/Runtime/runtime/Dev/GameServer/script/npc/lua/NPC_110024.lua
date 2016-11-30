function NPC_110024:Init(NPCID)
	
end

function NPC_110024:OnYell(RequestNPC, TargetActor)
	this:Assist(RequestNPC)
end

function NPC_110024:OnTryHit(Actor, TalentID)
	if (140010 == TalentID) then
		this:NonDelayBalloon("$$NPC_110024_11")
	end
end