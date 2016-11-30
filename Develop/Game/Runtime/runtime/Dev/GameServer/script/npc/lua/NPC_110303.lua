-- ∑ªµ® ¿¸≈ı∫¥ (ø©)
function NPC_110221:Init(NPCID)
	
end

function NPC_110221:OnDialogExit(Player, nDialogID, nExit)
	if (1100052 == nDialogID) then
		if (1 == nExit) then
			if (this:CheckBuff(110001) == false) then
				
				this:UseTalentSelf(211022009)
				--Player:AddItem(10008, 1)
				this:SetTimer(1,61,false)
			end
		end
	end
end

function NPC_110221:OnTimer(TimerID)
	if  (TimerID == 1) then
		this:UseTalentSelf(211022010)
	end
end
