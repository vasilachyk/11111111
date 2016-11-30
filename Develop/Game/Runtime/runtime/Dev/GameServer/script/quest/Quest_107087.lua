-- 연기에 푹 빠진 당신
function Quest_107087:OnBegin(Player, NPC)
	this:UpdateVar(0)
	--Player:AddItem(10004,1) quest.xml에서 처러
end

function Quest_107087:OnObjComplete(Player, ObjectiveID, Trigger)
	local Smoke = this:GetVar()
	local Field = Player:GetField()
	local EastFire = Field:GetNPC(107228)
	local WestFire = Field:GetNPC(107229)
	local SouthFire = Field:GetNPC(107230)
	local NorthFire = Field:GetNPC(107231)	

	if (Smoke < 4)then
		Smoke = Smoke +1
		this:UpdateVar(tonumber(Smoke))
		if (ObjectiveID == 1) then		
			Player:Tip("$$Quest_107087_19")
			if (Trigger == true) then
				EastFire:GainBuff(110011)
			end
			
		elseif (ObjectiveID == 2) then
			Player:Tip("$$Quest_107087_25")
			if (Trigger == true) then
				WestFire:GainBuff(110011)
			end
			
		elseif (ObjectiveID == 3) then
			Player:Tip("$$Quest_107087_31")
			if (Trigger == true) then
				SouthFire:GainBuff(110011)
			end

		elseif (ObjectiveID == 4) then
			Player:Tip("$$Quest_107087_37")	
			if (Trigger == true) then			
				NorthFire:GainBuff(110011)
			end
			
		end
	end
	if (Smoke == 4)then
		Smoke = Smoke +1
		this:UpdateVar(tonumber(Smoke))
		Player:Tip("$$Quest_107087_46")
		--[[if (Trigger == true) then
			Field:SpawnByID(1201)
			Field:SpawnByID(1202)
			Field:SpawnByID(1203)
			Field:SpawnByID(1204)
			Field:SpawnByID(1205)
			Field:SpawnByID(1206)		
			Field:SpawnByID(1207)
			Field:SpawnByID(1208)
			Field:SpawnByID(1209)
			Field:SpawnByID(1210)
			Field:SpawnByID(1211)
			Field:SpawnByID(1212)		
			Field:SpawnByID(1213)
			Field:SpawnByID(1214)
			Field:SpawnByID(1215)
			Field:SpawnByID(1216)
		end--]]
	end
end

function Quest_107087:OnComplete(Player)
	local Field = Player:GetField()
	Player:Tip("$$Quest_107087_001")	--Player:Tip("퀘스트를 완료했습니다. 10초 후 자동으로 공용 필드로 돌아갑니다.")	
	Field:SetTimer(1, 11, false)	
end