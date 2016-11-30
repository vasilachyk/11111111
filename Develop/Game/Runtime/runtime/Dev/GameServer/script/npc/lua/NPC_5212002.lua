-- PC방 전용 이동술사

function NPC_5212002:OnDialogExit(Player, DialogID, ExitID)
	if (5212005 == DialogID) then
		if (5 == ExitID) then --테레스 평원 입구
			local GoldTo_107 = 0 
			
			if (Player:GetSilver() >= GoldTo_107) and (Player:CheckCondition(904) == true) then
				Player:RemoveSilver(GoldTo_107)
				Player:GateToMarker(107, 2)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
		--elseif (6 == ExitID) then --테레스 평원 플릿폿 출몰지역		
			--local GoldTo_107 = 3000 --30실버 보스 스폰지역은 해당 지역보다 10배 비쌈
			
			--if (Player:GetSilver() >= GoldTo_107) and (Player:CheckCondition(904) == true) then
				--Player:RemoveSilver(GoldTo_107)
				--Player:GateToMarker(107, 33)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문
		elseif (7 == ExitID) then --테레스 평원 테레시스 출몰지역	
			local GoldTo_107 = 3000 --30실버 보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_107) and (Player:CheckCondition(904) == true) then
				Player:RemoveSilver(GoldTo_107)
				Player:GateToMarker(107, 14)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
-- 테레스 평원 종료			

-- 렌고트 부락 시작 
		elseif (8 == ExitID) then --렌고트 부락 입구
			local GoldTo_110 = 0 
			
			if (Player:GetSilver() >= GoldTo_110) and (Player:CheckCondition(905) == true) then
				Player:RemoveSilver(GoldTo_110)
				Player:GateToMarker(110, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문			
			
		elseif (9 == ExitID) then --렌고트 부락 보르고 
			local GoldTo_110 = 4000 --40실버 보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_110) and (Player:CheckCondition(905) == true) then
				Player:RemoveSilver(GoldTo_110)
				Player:GateToMarker(110, 13052)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문			
		--elseif (10 == ExitID) then --렌고트 부락 고블린 골렘	
			--local GoldTo_110 = 4000 --40실버 보스 스폰지역은 해당 지역보다 10배 비쌈
			
			--if (Player:GetSilver() >= GoldTo_110) and (Player:CheckCondition(905) == true) then
				--Player:RemoveSilver(GoldTo_110)
				--Player:GateToMarker(110, 13031)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문	
-- 렌고트 부락 종료

-- 영웅의 오솔길 시작
		elseif (11 == ExitID) then --영웅의 오솔길 입구
			local GoldTo_113 = 0 --5실버 보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(906) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
		elseif (12 == ExitID) then --영웅의 오솔길 오염된 화원
			local GoldTo_113 = 1000 --던전 입구는 입구의 2배로 비쌈			
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(906) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 7)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
		elseif (13 == ExitID) then --영웅의 오솔길 저주받은 납골당
			local GoldTo_113 = 1000 --던전 입구는 입구의 2배로 비쌈		
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(906) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 10)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
		elseif (14 == ExitID) then --영웅의 오솔길 고스트 라이더
			local GoldTo_113 = 5000 --보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_113) and (Player:CheckCondition(906) == true) then
				Player:RemoveSilver(GoldTo_113)
				Player:GateToMarker(113, 1601)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
--영웅의 오솔길 종료

--에다산 시작
		elseif (15 == ExitID) then --에다산입구
			local GoldTo_102 = 0 --보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_102) and (Player:CheckCondition(907) == true) then
				Player:RemoveSilver(GoldTo_102)
				Player:GateToMarker(102, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
		elseif (16 == ExitID) then --에다산 샤디즈
			local GoldTo_102 = 6000 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_102) and (Player:CheckCondition(907) == true) then
				Player:RemoveSilver(GoldTo_102)
				Player:GateToMarker(102, 1110)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
--에다산 종료

--마코트 부락 시작			
		elseif (17 == ExitID) then --마코트 부락 입구
			local GoldTo_111 = 0 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_111) and (Player:CheckCondition(908) == true) then
				Player:RemoveSilver(GoldTo_111)
				Player:GateToMarker(111, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문				
		elseif (18 == ExitID) then --마코트 부락 크라서스 
			local GoldTo_111 = 7000 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_111) and (Player:CheckCondition(908) == true) then
				Player:RemoveSilver(GoldTo_111)
				Player:GateToMarker(111, 4)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
--마코트 부락 종료

--리오드 시작
		elseif (19 == ExitID) then --리오드 입구
			local GoldTo_101 = 0 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(909) == true) then
				Player:RemoveSilver(GoldTo_101)
				Player:GateToMarker(101, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문	
		--elseif (20 == ExitID) then --리오드 지그니프
			--local GoldTo_101 = 8000 --보스 스폰지역은 해당 지역보다 10배 비쌈		
			
			--if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(909) == true) then
				--Player:RemoveSilver(GoldTo_101)
				--Player:GateToMarker(101, 1010321)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문	
		elseif (21 == ExitID) then --리오드 이리스
			local GoldTo_101 = 8000 --보스 스폰지역은 해당 지역보다 10배 비쌈
			
			if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(909) == true) then
				Player:RemoveSilver(GoldTo_101)
				Player:GateToMarker(101, 1010195)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
		elseif (22 == ExitID) then --리오드 수도원
			local GoldTo_101 = 1600 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_101) and (Player:CheckCondition(909) == true) then
				Player:RemoveSilver(GoldTo_101)
				Player:GateToMarker(101, 1010530)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
--리오드 종료

--리츠 지하수로 시작
		elseif (23 == ExitID) then --지하수로 입구
			local GoldTo_117 = 0 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_117) and (Player:CheckCondition(910) == true) then
				Player:RemoveSilver(GoldTo_117)
				Player:GateToMarker(117, 2)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
		--elseif (24 == ExitID) then --펑거스 
			--local GoldTo_117 = 9000 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			--if (Player:GetSilver() >= GoldTo_117) and (Player:CheckCondition(910) == true) then
				--Player:RemoveSilver(GoldTo_117)
				--Player:GateToMarker(117, 41)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문
		--elseif (25 == ExitID) then --폴루토
			--local GoldTo_117 = 9000 --보스 스폰지역은 해당 지역보다 10배 비쌈
			
			--if (Player:GetSilver() >= GoldTo_117) and (Player:CheckCondition(910) == true) then
				--Player:RemoveSilver(GoldTo_117)
				--Player:GateToMarker(117, 37)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문
		elseif (26 == ExitID) then --타일런트 좀비
			local GoldTo_117 = 9000 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_117) and (Player:CheckCondition(910) == true) then
				Player:RemoveSilver(GoldTo_117)
				Player:GateToMarker(117, 117022)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
--리츠 지하수로 종료

--침묵의 장벽 시작 
		elseif (27 == ExitID) then --침묵의 장벽
			local GoldTo_118 = 0 --보스 스폰지역은 해당 지역보다 10배 비쌈	
			
			if (Player:GetSilver() >= GoldTo_118) and (Player:CheckCondition(911) == true) then
				Player:RemoveSilver(GoldTo_118)
				Player:GateToMarker(118, 1)
			else
				this:Balloon("$$NPC_1210_1")
			end --여기까지 한 구문
		--elseif (28 == ExitID) then --키메라
			--local GoldTo_118 = 10000 --보스 스폰지역은 해당 지역보다 10배 비쌈
			
			--if (Player:GetSilver() >= GoldTo_118) and (Player:CheckCondition(911) == true) then
				--Player:RemoveSilver(GoldTo_118)
				--Player:GateToMarker(118, 1)
			--else
				--this:Balloon("$$NPC_1210_1")
			--end --여기까지 한 구문					
--침묵의 장벽 종료					
--에다산 성지 시작 
		elseif (28 == ExitID) then --에다산 성지
			local GoldTo_102001 = 0 
			
			if (Player:GetSilver() >= GoldTo_102001) and (Player:CheckCondition(34) == true) then
				Player:RemoveSilver(GoldTo_102001)
				Player:GateToMarker(102001, 99)
			else
				this:Balloon("$$NPC_1210_1")
			end 
--에다산 성지 종료
--인젠 자유항 시작 
		elseif (29 == ExitID) then --인젠 자유항
			local GoldTo_3 = 0 
			
			if (Player:GetSilver() >= GoldTo_3) and (Player:CheckCondition(5) == true) then
				Player:RemoveSilver(GoldTo_3)
				Player:GateToMarker(3, 107101)
			else
				this:Balloon("$$NPC_1210_1")
			end 
--인젠 자유항 종료
--리츠 시작 
		elseif (30 == ExitID) then --리츠
			local GoldTo_1 = 0 
			
			if (Player:GetSilver() >= GoldTo_1) and (Player:CheckCondition(28) == true) then
				Player:RemoveSilver(GoldTo_1)
				Player:GateToMarker(1, 1210)
			else
				this:Balloon("$$NPC_1210_1")
			end 
--리츠 종료
		end
	end 
end	




