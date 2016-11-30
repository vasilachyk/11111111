-- 마담 M <헬하운드 이동술사> NPC_1243과 공유

function NPC_3213:OnDialogExit(Player, DialogID, ExitID)
	if (6010012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(601001, true)
		end	
	end
	if (6011012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(601101, false, false)
		end	
	end	
	if (6020012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(602001, true)
		end	
	end
	if (6021012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(602101, false, false)
		end	
	end	
	if (6030012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(603001, true)
		end	
	end	
	if (6031012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(603101, false, false)
		end	
	end		
	if (6040012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(604001, true)
		end	
	end
	if (6041012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(604101, false, false)
		end	
	end	
	if (6050012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(605001, true)
		end	
	end	
	if (6051012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(605101, false, false)
		end	
	end		
	if (6060012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(606001, true)
		end	
	end	
	if (6061012 == DialogID) then
		if (1 == ExitID) then
			Player:GateToTrial(606101, false, false)
		end	
	end		
end

