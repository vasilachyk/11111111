-- 이동술사 케이트

function NPC_1210:OnSpawn(SpawnInfo)
	this:GainBuff(111615)
	this:SetTimer(1, 120, true)
end

function NPC_1210:OnTimer(TimerID)
	this:ClearJob()
	if (TimerID == 1) then
		local dice = math.random(0,2)
		if( dice == 0) then
			this:GainBuff(111614)
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

function NPC_1210:OnDialogExit(Player, DialogID, ExitID)
	if (1210 == DialogID) then
		if (1 == ExitID) then
			local GoldTo_3 = 1000
			
			if (Player:GetSilver() >= GoldTo_3) and (Player:CheckCondition(1) == true) then
				Player:RemoveSilver(GoldTo_3)
				Player:GateToMarker(3, 107101)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (2 == ExitID) then
			local GoldTo_110 = 700
			
			if (Player:GetSilver() >= GoldTo_110) and (Player:CheckCondition(1) == true) then
				Player:RemoveSilver(GoldTo_110)
				Player:GateToMarker(110, 110211)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (3 == ExitID) then
			local GoldTo_113 = 600
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(1) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 15)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (4 == ExitID) then
			local GoldTo_102 = 400
			
			if (Player:GetSilver() >= GoldTo_102) and (Player:CheckCondition(1) == true) then
				Player:RemoveSilver(GoldTo_102)
				Player:GateToMarker(102, 102229)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (5 == ExitID) then
			local GoldTo_111 = 300
			
			if (Player:GetSilver() >= GoldTo_111) and (Player:CheckCondition(1) == true) then
				Player:RemoveSilver(GoldTo_111)
				Player:GateToMarker(111, 111404)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (6 == ExitID) then
			local GoldTo_101 = 200
			
			if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(808) == true) then
				Player:RemoveSilver(GoldTo_101)
				Player:GateToMarker(101, 101029)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (7 == ExitID) then
			local GoldTo_118 = 200
			
			if (Player:GetSilver() >= GoldTo_118) and (Player:CheckCondition(810) == true) then
				Player:RemoveSilver(GoldTo_118)
				Player:GateToMarker(118, 118201)
			else
				this:Balloon("$$NPC_1210_1")
			end
		elseif (8 == ExitID) then
			local GoldTo_102001 = 1000
			
			if (Player:GetSilver() >= GoldTo_102001) and (Player:CheckCondition(806) == true) then
				Player:RemoveSilver(GoldTo_102001)
				Player:GateToMarker(102001, 99)
			else
				this:Balloon("$$NPC_1210_1")
			end			
		end	

	end
end



