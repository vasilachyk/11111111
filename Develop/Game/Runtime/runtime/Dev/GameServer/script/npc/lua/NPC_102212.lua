-- ¼ø·ÊÀÚ Å¬·¹¸à½º

function NPC_102212:OnSpawn(Spawn)
	this:GainBuff(110007)
end

function NPC_102212:OnTryHit(Actor, TalentID)
	if (140002 == TalentID) then
		local Player = AsPlayer(Actor)
		if (this:CheckBuff(110007) == true) then
			this:NonDelayBalloon("$$NPC_102212_11")		
			this:RemoveBuff(110007)
			this:UseTalentSelf(210221001)
			this:FaceTo(Player)
		end
	end
end

function NPC_102212:OnDialogExit(Player, DialogID, ExitID)
	if (1020064 == DialogID) and (1 == ExitID) then
		this:DisableInteraction()	
		this:Balloon("$$NPC_102212_22")
		this:SetAlwaysRun(true)
		Player:UpdateQuestVar(102006, 4)		
	    this:Move(vec3(29400.0, 12199.0, 5136.0))
		this:Despawn(true)
	end
end