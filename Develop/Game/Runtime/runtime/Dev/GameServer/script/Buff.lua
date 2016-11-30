-- Buff
--[[
	* OnGain : 버프가 걸린 시점
	* OnLost : RemoveBuff 등으로 버프가 강제로 중간에 없어지는 시점
	* OnExpired : 버프의 시간이 자연적으로 끝나는 시점
--]]
function Buff_110022:OnGain(Caster, Owner) -- 에다산 : 설인한테 습격 받고 기절
	if (Owner:IsPlayer() == true) then
		local Field = AsPlayer(Owner):GetField()
		--AsPlayer(Owner):GateToMarker(102, 2)
		AsPlayer(Owner):Narration("$$BUFF_110022_1") -- '당신은 의식을 잃었습니다.'
		AsPlayer(Owner):UpdateQuestVar(102020,2)
		Field:SetTimer(1, 8, false)
	end
end
function Buff_110023:OnGain(Caster, Owner) -- 귀환의 마법 : 초심자용 귀환석 사용
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):UpdateQuestVar(107100, 3)
	end
end
--[[
function Buff_110023:OnGain(Caster, Owner)
	if (Owner:IsNPC() == true) then
		if (AsNPC(Owner):GetID() == 109205) then

			local SpawnPos = Owner:GetPos()
			local Field = Owner:GetField()
			AsNPC(Owner):Despawn(true)
			local SpawnNpc = Field:Spawn( 109223, SpawnPos )
			SpawnNpc:FaceTo( Caster )

		end
		if (AsNPC(Owner):GetID() == 109206 ) then

			local SpawnPos = Owner:GetPos()
			local Field = Owner:GetField()
			AsNPC(Owner):Despawn(true)
			local SpawnNpc = Field:Spawn( 109224, SpawnPos )
			SpawnNpc:FaceTo( Caster )

		end
		if (AsNPC(Owner):GetID() == 109320) then

			local SpawnPos = Owner:GetPos()
			local Field = Owner:GetField()
			AsNPC(Owner):Despawn(true)
			local SpawnNpc = Field:Spawn( 109225, SpawnPos )
			SpawnNpc:FaceTo( Caster )

		end
		if (AsNPC(Owner):GetID() == 109321) then

			local SpawnPos = Owner:GetPos()
			local Field = Owner:GetField()
			AsNPC(Owner):Despawn(true)
			local SpawnNpc = Field:Spawn( 109226, SpawnPos )
			SpawnNpc:FaceTo( Caster )

		end
	end
end
--]]
--[[
function Buff_110027:OnGain(Caster, Owner)  -- 까르엔의 축복 버프. PC가 아닌 동물이나 NPC가 걸리면 자동 삭제. PC만 버프가 걸리게 바꿔서 필요 없어짐
	if (Owner:IsPlayer() == false) then
		Owner:RemoveBuff(110027)
	end
end
--]]

function Buff_110028:OnLost(Caster, Owner) -- 에다산 : 고대의 상자 - 냉기 완드로 불을 끄면 인터렉션이 가능
	if (AsNPC(Owner):GetID() == 102128) then
		AsNPC(Owner):EnableInteraction()
	end
end

function Buff_110039:OnGain(Caster, Owner)  -- 슈나크의 날개 공격하는 부분(어떻게 처리해야 하나)
	if (Owner:IsPlayer() == true) then
		if (AsPlayer(Owner):CheckCondition(1110261) == true) then -- 110026 퀘스트 진행 중
			AsPlayer(Owner):UpdateQuestVar(111026, 3)
			AsPlayer(Owner):Tip("$$BUFF_110039_1") -- "이런 식으론 가망이 없어 보입니다. 헤르온느에게 보고하십시오."
		end
		if (AsPlayer(Owner):CheckCondition(1110261) == false) and (AsPlayer(Owner):CheckCondition(1110411) == true) then -- 110041 퀘스트 진행 중
			local Field = Owner:GetField()
			local Pos = Owner:GetPos()		
			Field:SpawnLimited(111303, Pos, 60)
			AsPlayer(Owner):Tip("$$BUFF_110039_2") -- "방금 전의 충격으로 숨겨져있던 금속판이 떨어집니다!"
		end		
	end
end

function Buff_110041:OnGain(Caster, Owner)  -- 슈나크의 날개 공격하는 부분(고대의 유물)
	if (Owner:IsPlayer() == true) then
		local Count = tonumber(AsPlayer(Owner):GetQuestVar(111041))
		Count = Count +1
		AsPlayer(Owner):UpdateQuestVar(111041, Count)
	end
end

function Buff_110045:OnLost(Caster, Owner)  -- 렌고트 부락 : 110007 퀘스트 - 물항아리에 독 타기
	if (AsNPC(Owner):GetID() == 110040) then
		AsNPC(Owner):Despawn(true)
	end
end

--[[
function Buff_130046:OnGain(Owner) -- TEST용 
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):Tip("$$BUFF_130046_1")
	end
end

function Buff_130046:OnExpired(Owner)
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):Tip("$$BUFF_130046_2")
	end
end
--]]

function Buff_110047:OnGain(Caster, Owner)  -- 성수를 마시면 퀘스트 완료
	if (Owner:IsPlayer() == true) then
		if (AsPlayer(Owner):CheckCondition(1010261) == true) then
			AsPlayer(Owner):UpdateQuestVar(101026, 4)
			AsPlayer(Owner):Tip("$$BUFF_110047_1") 
		end
	end
end

function Buff_110065:OnGain(Caster, Owner)  -- 코웬 늪지대 : 설치된 함정을 밟음
	if (Owner:IsPlayer() == false) then
		local OwnerID = AsNPC(Owner):GetID()
	
		if (OwnerID == 103111) then
			if (AsPlayer(Caster):CheckCondition(1030131) == true) or (AsPlayer(Caster):CheckCondition(1030141) == true) then
				AsNPC(Owner):Die(Owner)
				Caster:GainBuff(110066)
			end
		end
		if (OwnerID == 103128) then
			Owner:GainBuff(110060)
		end
	end
end

function Buff_110067:OnGain(Caster, Owner)  -- 함정으로 처치 10마리 달성(110066버프 10개 붙으면 110067버프로 변화)
	if (Owner:IsPlayer() == true) then
		if (AsPlayer(Owner):CheckCondition(1030131) == true) then	-- 퀘스트를 완료시킴
			AsPlayer(Owner):UpdateQuestVar(103013, 10)
		end
		if (AsPlayer(Owner):CheckCondition(1030141) == true) then	-- 퀘스트를 완료시킴
			AsPlayer(Owner):UpdateQuestVar(103014, 10)
		end		
	end
end
function Buff_110069:OnGain(Caster, Owner)  -- 물호리병으로 물의 정령 흡수 10마리 달성(110068버프 10개 붙으면 110069버프로 변화)
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):UpdateQuestVar(116036, 10)	
	end
end

function Buff_110058:OnExpired(Caster, Owner)  -- 코웬 늪지대 : 검은 늪의 환각 3단계
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):GateToTrial(1030210, true)
	end
end

function Buff_110061:OnExpired(Caster, Owner)  -- 103004 퀘스트 시작시 봉봉에게 포로로 잡힘
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):GateToTrial(1030040, true)
	end
end

function Buff_110072:OnExpired(Caster, Owner)  -- 완성된 정령신주 : 걸려있던 30초 버프가 사라지면 오브젝트도 사라짐
	if (AsNPC(Owner):GetID() == 116414) then
		AsNPC(Owner):Despawn(false)
	end
end
--[[
function Buff_110093:OnExpired(Caster, Owner)  -- 부러진 돛대 : 티안의 전령 버프가 소진되면 모켄의 해적이 등장
	if (Owner:IsPlayer() == true) then
		local Field = Owner:GetField()
		local Tian = Field:GetSpawnNPC(109001)
		local MyPos = Owner:GetPos()
		local MyDir = Owner:GetDir()		
		local TianPos = Tian:GetPos()
		if (Math_GetDistance(MyPos, TianPos) > 5000) then
			Owner:GainBuff(110094)
			local SummonTable = Math_GetPolygonPoints(MyPos, MyDir, 300, 8)
			local PiratePos1 = SummonTable["1"]
			local PiratePos2 = SummonTable["2"]
	
			Field:Spawn(109199, PiratePos1)
			Field:Spawn(109200, PiratePos2)				
		end
	end
end
--]]
function Buff_110095:OnExpired(Caster, Owner)  -- 부러진 돛대 : 109008 퀘스트 - 버프 사라지면 컷신 시작
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):Cutscene(109008)
	end
end

-- 40991 집사 다르엘의 지팡이
function Buff_40991:OnGain(Caster, Owner)  
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):NarrationNow("$$COLT_0520010_8")
	end
end

-- 41010 집사 다르엘의 가면
function Buff_41010:OnGain(Caster, Owner)  
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):NarrationNow("$$COLT_0520010_5")
	end
end

-- 성녀 보호막 해제
function Buff_40770:OnLost( Caster, Owner )
--	GLog("Buff_40770:OnLost")
	if not Owner:IsNPC() then return end
	local ThisNPC = AsNPC(Owner)
--	ThisNPC:SayNow("Buff_40770:OnLost")
	if ThisNPC:GetCurrentTalent() == NPC_501003.TALENT_BreakShield2 then return end
	ThisNPC:ClearJob()
	ThisNPC:UseTalentSelf( NPC_501003.TALENT_BreakShield1 )
end
--function Buff_40770:OnExpired ( Caster, Owner )
--	GLog("Buff_40770:OnExpired")
--end

function Buff_40771:OnLost( Caster, Owner )
--	GLog("Buff_40771:OnLost")
	if not Owner:IsNPC() then return end
	local ThisNPC = AsNPC(Owner)
--	ThisNPC:SayNow("Buff_40771:OnLost")
	if ThisNPC:GetCurrentTalent() == NPC_501003.TALENT_BreakShield2 then return end
	ThisNPC:ClearJob()
	ThisNPC:UseTalentSelf( NPC_501003.TALENT_BreakShield1 )
end

function Buff_40183:OnExpired( Caster, Owner ) -- 튜토리얼 : (시선 끌기)크라울러 공격 후, 얻는 버프가 사라지면 퀘스트 완료되고 공용 필드로. 컷신 시작
	AsPlayer(Owner):OutTutorialField()
end


-- 실험 104010 퀘스트 
function Buff_110073:OnGain(Caster, Owner)
	if (Owner:IsPlayer() == false) then
		local OwnerID = AsNPC(Owner):GetID()
	
		if (OwnerID == 104113) and (AsPlayer(Caster):CheckCondition(1040101) == true) then			
			Owner:GainBuff(110073)		
			GLog("104113")			
		end
		
		if (OwnerID == 104114) and (AsPlayer(Caster):CheckCondition(1040101) == true) then			
			Owner:GainBuff(110073)			
			GLog("104114")
		end
		
		if (OwnerID == 104114) and (AsPlayer(Caster):CheckCondition(1040101) == true) then			
			Owner:GainBuff(110073)			
			GLog("104115")
		end
		
	end
end

 -- 104024 퀘스트 
function Buff_110078:OnGain(Caster, Owner)
	if (Owner:IsPlayer() == false) then
		local OwnerID = AsNPC(Owner):GetID()		
		if (OwnerID == 104152) and (AsPlayer(Caster):CheckCondition(1040241) == true) then					
			
		end		
	end		
end

 -- 111022 퀘스트 
function Buff_110104:OnLost(Caster, Owner)
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):Cutscene(111022)
	end		
end

--- 118002 퀘스트
function Buff_111400:OnLost(Caster, Owner) 
	if (AsNPC(Owner):GetID() == 118002) or (AsNPC(Owner):GetID() == 118003) then
		AsNPC(Owner):EnableInteraction()
	end
end	


--- 118009 퀘스트
function Buff_111401:OnLost(Caster, Owner) 
	if (AsNPC(Owner):GetID() == 118004) or (AsNPC(Owner):GetID() == 118005) then
		AsNPC(Owner):EnableInteraction()
	end
end	

--- 119017 퀘스트 -- 시간이 지나면 despawn 되는 버프
function Buff_111406:OnLost(Caster, Owner) 
	if (AsNPC(Owner):GetID() == 118252) then						
		AsNPC(Owner):Despawn(false)		
	end
end	

--- 119017 퀘스트 -- 이펙터에 버프 걸어주는 것
function Buff_111403:OnLost(Caster, Owner) 
	if (AsNPC(Owner):GetID() == 118252) then
		AsNPC(Owner):Despawn(false)
	end
end	

-- 130511 한국 현상금 사냥꾼 이벤트 (OBT 기념)
function Buff_130511:OnGain(Caster, Owner)  
	if (Owner:IsPlayer() == true) then
		AsPlayer(Owner):NarrationMe("$$Eventitem_monsterhunter")
	end
end