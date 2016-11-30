function Field_1170581:OnCreate()
	
	this:SpawnByID(11710004, false)
	this:SpawnByID(11710006, false)
	this:SpawnByID(11710007, false)
	this:SpawnByID(11710012, false)
	this:SpawnByID(11710018, false)
	
end

--체크포인트센서
function Field_1170581:OnSensorEnter_4234(Actor)
	
	
end

function Field_1170581:OnSensorEnter_4235(Actor)
	
	this:DisableSensor(4235)
	
	if (AsPlayer(Actor):GetQuestVar(117058) == 4) then	
		AsPlayer(Actor):Tip("$$Quest_117058_006") --Player:Tip("잠시 뒤에 맥기프가 나타날 것입니다!")
		this:SetTimer(1170580, 10, false)						
	end 
	

end

function Field_1170581:OnTimer(TimerID) 
		
	-- GLog("f Line")
	
	--자금원 차단 퀘스트
	if (TimerID == 117058) then
	
		local burning_supply1 = this:GetSpawnNPC(11710000)
		local burning_supply2 = this:GetSpawnNPC(11710001)
		local burning_supply3 = this:GetSpawnNPC(11710002)
		local burning_supply4 = this:GetSpawnNPC(11710003)

		if (burning_supply1:CheckBuff(110028) == true) then

			-- burning_supply1:RemoveBuff(110028)			

		end
		
		if (burning_supply2:CheckBuff(110028) == true) then
			-- burning_supply2:RemoveBuff(110028)
			
		end
		
		if (burning_supply3:CheckBuff(110028) == true) then
			-- burning_supply3:RemoveBuff(110028)
			
		end
		
		if (burning_supply4:CheckBuff(110028) == true) then
			-- burning_supply4:RemoveBuff(110028)
			
		end		
		
	end
	
	
	--창고 불을 모두 켜면 #초뒤 맥기프가 출현
	if (TimerID == 1170580) then		
		this:SpawnByID(117601)		
		local meckih = this:GetNPC(117601)
		
		meckih:DisableCombat()		
		meckih:Narration("$$Field_1170581_001")						--meckih:Narration("멕기프가 창고에 나타났습니다!")						
		meckih:Say("$$Field_1170581_002") 		--meckih:Say("누구냐!! 창고에 불을 붙인 녀석이!!!") 		
		meckih:Say("$$Field_1170581_003") 				--		meckih:Say("이런 어린녀석들이!! 죽고 싶어 환장했구나!!") 				
		-- meckih:UseTalentSelf(211760100)		
	
	end
	
	if (TimerID == 1170581) then
		
		local meckih = this:GetNPC(117601)		
		local dice = math.random(0, 2)
		
		meckih:EnableCombat()		
		
		if dice == 0 then			
			meckih:SayNow("$$Field_1170581_004") 				--meckih:Say("너흰 여기 오지 말았어야 했다 킬킬") 				
		end
		
		if dice == 1 then
			meckih:SayNow("$$Field_1170581_005") 				--meckih:Say("너희! 지금 무사할거라 생각한게냐!!") 				
		end
		
		if dice == 2 then
			meckih:SayNow("$$Field_1170581_006") 				--meckih:Say("이 리츠의 개들!!") 				
		end
	end
end


function Field_1170581:OnSpawn(SpawnInfo)

	-- local Field = SpawnInfo.Field	
	
	if (SpawnInfo.SpawnID == 117601) then	
		-- GLog("Spawn mekih")	
		
		this:SetTimer(1170581, 15, true)			
	
	end

end

function Field_1170581:OnDie(DespawnInfo)
	if (DespawnInfo.SpawnID == 117601) then	
		this:KillTimer(1170581)
	end	
end