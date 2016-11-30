-- 이동술사 스테이시

function NPC_3303:OnSpawn(SpawnInfo)
	this:GainBuff(111615)
	this:SetTimer(1, 120, true)
end

function NPC_3303:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:GainBuff(111613)
			this:Balloon("$$Field_1_38")
		end
		if( dice == 1) then
			this:Balloon("$$Field_1_39")
		end
		if( dice == 2) then
			this:Balloon("$$Field_1_44")
		end
	end
end

function NPC_3303:OnDialogExit(Player, DialogID, ExitID)

	if (3303 == DialogID) then
		if (1 == ExitID) then
			local GoldTo_107 = 200
					
			if (Player:GetSilver() >= GoldTo_107) and (Player:CheckCondition(802) == true) then
				Player:RemoveSilver(GoldTo_107)
				Player:GateToMarker(107, 41)
			else
				this:Balloon("$$NPC_3303_1")
			end		
		elseif (2 == ExitID) then
			local GoldTo_110 = 200
					
			if (Player:GetSilver() >= GoldTo_110) and (Player:CheckCondition(803) == true) then
				Player:RemoveSilver(GoldTo_110)
				Player:GateToMarker(110, 110211)
			else
				this:Balloon("$$NPC_3303_1")
			end
		elseif (3 == ExitID) then
			local GoldTo_113 = 300
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(804) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 15)
			else
				this:Balloon("$$NPC_3303_1")
			end
		elseif (4 == ExitID) then
			local GoldTo_102 = 400
			
			if (Player:GetSilver() >= GoldTo_102) and (Player:CheckCondition(805) == true) then
				Player:RemoveSilver(GoldTo_102)
				Player:GateToMarker(102, 102229)
			else
				this:Balloon("$$NPC_3303_1")
			end
		elseif (5 == ExitID) then
			local GoldTo_111 = 500
			
			if (Player:GetSilver() >= GoldTo_111) and (Player:CheckCondition(807) == true) then
				Player:RemoveSilver(GoldTo_111)
				Player:GateToMarker(111, 111404)
			else
				this:Balloon("$$NPC_3303_1")
			end
		elseif (6 == ExitID) then
			local GoldTo_101 = 600
			
			if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(808) == true) then
				Player:RemoveSilver(GoldTo_101)
				Player:GateToMarker(101, 101029)
			else
				this:Balloon("$$NPC_3303_1")
			end			
		elseif (7 == ExitID) then
			local GoldTo_1 = 1000
			
			if (Player:GetSilver() >= GoldTo_1) and (Player:CheckCondition(809) == true) then
				Player:RemoveSilver(GoldTo_1)
				Player:GateToMarker(1, 1210)
			else
				this:Balloon("$$NPC_3303_1")
			end
		end
		
	elseif (1071012 == DialogID) then
		if (1 == ExitID) then
			if (Player:CheckCondition(1071011) == true) then
				Player:GateToMarker(107, 1071012)
				Player:UpdateQuestVar(107101, 2)
			end
		end
	end
end