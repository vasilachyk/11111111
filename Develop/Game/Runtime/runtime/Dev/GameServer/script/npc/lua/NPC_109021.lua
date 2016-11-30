-- 실버 (트라이얼용)

function NPC_109021:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Damage >= 1) then
		local MaxHP = HitInfo.Victim:GetMaxHP()
		local Limit = tonumber(MaxHP * 0.3)
		local HP = HitInfo.Victim:GetHP()
		if (HP < Limit) then
			HitInfo.Victim:GainBuff(5000051)
			HitInfo.Victim:DisableCombat()
			HitInfo.Victim:ChangeAA(AA_NONE)
			
			HitInfo.Victim:Say("$$NPC_109021_13")
			HitInfo.Victim:Narration("$$NPC_109021_14")
						
			--HitInfo.Victim:ClearJob()
			--HitInfo.Victim:SetTimer(1, 3, false)			
			

		end
	end
end

--[[
function NPC_109021:OnTimer(TimerID) 
	if (TimerID == 1) then

	end
end
--]]

function NPC_109021:OnDialogExit(Player, DialogID, Exit)
	if (1090162 == DialogID) then
		if (1 == Exit) then
			Player:GateToMarker(109001, 109059)
		end
	end
end
