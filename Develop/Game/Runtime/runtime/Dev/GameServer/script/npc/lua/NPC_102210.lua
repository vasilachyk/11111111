-- 순례자 요한

function NPC_102210:OnSpawn(Spawn)
	this:GainBuff(110007)
end

function NPC_102210:OnTryHit(Actor, TalentID)
	if (140002 == TalentID) then
		local Player = AsPlayer(Actor)
		if (this:CheckBuff(110007) == true) then
			this:NonDelayBalloon("$$NPC_102210_11")					
			this:RemoveBuff(110007)
			this:UseTalentSelf(210221001)
			this:FaceTo(Player)
		end
	end
end

function NPC_102210:OnDialogExit(Player, DialogID, ExitID)
	if (1020062 == DialogID) and (1 == ExitID) then
		this:DisableInteraction()	
		this:Balloon("$$NPC_102210_22")
		this:SetAlwaysRun(true)
		Player:UpdateQuestVar(102006, 2)
	    this:Move(vec3(45901.0, 20792.0, 5506.0))
		this:Despawn(true)
	end
end
