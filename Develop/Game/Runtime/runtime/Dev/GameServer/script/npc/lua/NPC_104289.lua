function NPC_104289:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Damage >= 1) then
		local MaxHP = HitInfo.Victim:GetMaxHP()
		local Limit = tonumber(MaxHP * 0.5)
		local HP = HitInfo.Victim:GetHP()
		if (HP < Limit) then			
			Glog("hp<limit")
		elseif (HP >= Limit) then			
			Glog("hp>=limit")
		end
	end
end