-- 혼돈의 불길
function NPC_116121:OnSpawn(SpawnInfo)
	SpawnInfo.NPC:SetAlwaysRun(true)
	--SpawnInfo.NPC:GainBuff(88553) -- 완드
	local dice = math.random(0,3)
	if( dice == 0) then 
		this:NonDelayBalloon("모두 태워버려라")
	end
	if( dice == 1) then 
		this:NonDelayBalloon("원시로 돌아가리라")
	end
	if( dice == 2) then 
		this:NonDelayBalloon("에르다의 창을 그대로 두어라!")
	end
	if( dice == 3) then 
		this:NonDelayBalloon("이 땅에 혼돈과 파괴를!")
	end		
end

function NPC_116121:OnTimer(TimerID)
	if (TimerID == 1) then	
		--this:ReturnToHome()
		this:Despawn(false)
	end
end