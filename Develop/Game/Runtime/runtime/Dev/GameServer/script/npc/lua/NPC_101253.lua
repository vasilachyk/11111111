-- 엔피씨 이리스

function NPC_101253:OnDialogExit(Player, DialogID, ExitID) 
	if (DialogID == 1010490) and (1 == ExitID) then
		this:EnableCombat()
		this:ChangeAA(AA_ALWAYS)
	end
end

function NPC_101253:OnHitCapsule_1_0(HitInfo)
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