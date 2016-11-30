-- 슈나크의 몸통

function NPC_111217:OnSpawn(SpawnInfo)
	this:DisableInteraction()
end

function NPC_111217:OnTryHit(Actor, TalentID)
	if (TalentID == 140019) then
		this:Narration("$$NPC_111217",4.0)			-- 카이저의 발톱으로 인해 슈나크의 몸에 균열이 생겼습니다.
		this:DisableCombat()		
		this:EnableInteraction()
		this:SetTimer(2, 15, false)
	end
end

function NPC_111217:OnTimer(TimerID)
	if (TimerID == 1) then
			--GLog("15초 후 시체 사라짐\n")
		this:Despawn(true)
	end
	if (TimerID == 2) then
			--GLog("15초 원래대로\n")
		this:EnableCombat()
		this:DisableInteraction()
	end	
end


