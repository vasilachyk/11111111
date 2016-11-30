-- 미스텔(돌아오지 않는 자)

function NPC_107220:OnDialogExit(Player, nDialogID, nExit)
	--GLog0("NPC_107220:OnDialogExit\n");
	
	if (1070513 == nDialogID) then
		if (3 == nExit) then
			Player:UpdateQuestVar(107051, 2)
			this:DisableInteraction()
			this:SetAlwaysRun(true)
			this:Balloon("$$NPC_107220_11")
			this:MoveToMarker(27)
			this:SetTimer(1, 13, false)
		end
	end
end

function NPC_107220:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		this:Despawn()
	end
end
