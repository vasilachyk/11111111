-- 호수의 수호자 이리스

function NPC_101002:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Damage >= 1) then
		local MaxHP = HitInfo.Victim:GetMaxHP()
		local Limit = tonumber(MaxHP * 0.2)
		local HP = HitInfo.Victim:GetHP()
		if (HP < Limit) then
			HitInfo.Victim:GainBuff(5000051)
			HitInfo.Victim:DisableCombat()
			HitInfo.Victim:ChangeAA(AA_NONE)
		end
	end
end

