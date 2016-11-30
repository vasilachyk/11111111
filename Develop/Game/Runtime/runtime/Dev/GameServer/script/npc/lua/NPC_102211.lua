-- 순례자 비오레

function NPC_102211:OnSpawn(Spawn)
	this:GainBuff(110007)
end

function NPC_102211:OnTryHit(Actor, TalentID)
	if (140002 == TalentID) then
		local Player = AsPlayer(Actor)
		if (this:CheckBuff(110007) == true) then
			this:NonDelayBalloon("$$NPC_102211_11")					
			this:RemoveBuff(110007)
			this:UseTalentSelf(210221001)
			this:FaceTo(Player)
		end
	end
end

function NPC_102211:OnDialogExit(Player, DialogID, ExitID)
	if (1020063 == DialogID) and (1 == ExitID) then
		this:DisableInteraction()	
		this:Balloon("$$NPC_102211_22")
		this:SetAlwaysRun(true)
		Player:UpdateQuestVar(102006, 3)		
	    this:Move(vec3(36446.0, 13524.0, 4557.0))
		this:Despawn(true)
	end
end