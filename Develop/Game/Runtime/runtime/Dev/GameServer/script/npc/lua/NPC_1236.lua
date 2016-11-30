-- 리츠 무용가 할배 지노

function NPC_1236:OnSpawn(SpawnInfo)
	this:SetTimer(1, 70, true)
end

function NPC_1236:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			--this:Balloon("$$Field_1_36")
		end
		if( dice == 1) then
			--this:Balloon("$$Field_1_37")
		end
		if( dice == 2) then
			--this:Balloon("$$Field_1_29")
		end
	end
end

function NPC_1236:OnDialogExit(Player, DialogID, Exit)
	if (9920079 == DialogID and 1 == Exit) then 
		Player:GainBuff(111612)	
		this:DisableInteraction()
		this:UseTalentSelf(141102)
		this:Despawn(true)
	end
end

