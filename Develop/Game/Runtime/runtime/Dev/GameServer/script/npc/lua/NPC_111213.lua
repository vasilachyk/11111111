-- 슈나크의 날개

function NPC_111213:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Attacker:IsPlayer() == true) then
		if (AsPlayer(HitInfo.Attacker):CheckCondition(1110261) == true) then -- or (AsPlayer(HitInfo.Attacker):CheckCondition(1110411) == true) then
			if (HitInfo.Damage >= 0) then
				local User = HitInfo.Attacker
				
				User:GainBuff(110038)	-- 110038 버프가 5개 쌓이면 110039로 변함. 110026 퀘스트가 완료된다.				
				User:GainBuff(110041)	-- 경직 버프
			end
		end
		if (AsPlayer(HitInfo.Attacker):CheckCondition(1110261) == false) then
			if (HitInfo.Damage >= 0) then
				local User = HitInfo.Attacker
				
				AsPlayer(User):Tip("$$NPC_111213", 2.5)			-- 공격이 통하지 않습니다.
				User:GainBuff(110041)
			end
		end
	end
end

function NPC_111213:OnTimer(TimerID)
	if (TimerID == 1) then
		this:Despawn(true) -- 불 붙이고 15초 후 타서 없어진다.
	end
end

