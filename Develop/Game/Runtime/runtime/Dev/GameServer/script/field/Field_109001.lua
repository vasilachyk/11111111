-- 부러진 돛대 (war)

--[[
function Field_109001:OnSensorLeave_109059(Actor) -- 109018 퀘스트 완료시 티안과 나가기로 나갔을 때 
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1090189) == true) then
			AsPlayer(Actor):GateToMarker(109, 1090189)
		end
	end
end
--]]
function Field_109001:OnSensorLeave_500(Actor)	-- 유적 밖으로 나가면 영령 효과가 사라진다.
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckBuff(110097) == true) then
			AsPlayer(Actor):RemoveBuff(110097)
		end
	end
end

---교관을 따라 훈련중인 NPC들의 타이머 이벤트에 따라 액션추가 // 장재곤

function Field_109001:OnTimer(TimerID)
	
	--전투준비하는 병사들이 칼질하는 타이머
	if (TimerID == 1) then
		-- 1300 ~ 7 전투 준비해적		
		local TalentDice = math.random(140900,140901)				
		local array = {109495,109496,109497,109498,109499,109500,109501,109502}
		
		for i,v in ipairs(array) do 
			local pirate = this:GetNPC(v)
			pirate:UseTalentSelf(TalentDice)			
		end
	
	-- 교관이 말하는 타이머
	elseif (TimerID == 2 ) then	
		local SeniorTrainer = this:GetNPC(109056)		
		SeniorTrainer:Say("$$Field_109_139")				
		this:SetTimer(1, 1, false)
	end
end

function Field_109001:OnCreate()
	this:SetTimer(2, 60, true)
end

function Field_109001:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 109235) then -- 제사장이 죽으면 봉인의 가지가 든 상자를 드랍한다.
		local Deadbody = DespawnInfo.NPC
		local localAdjPos = vec3(0, 50, 0)
		local worldPos = Math_LocalToWorld(Deadbody:GetDir(), Deadbody:GetPos(), localAdjPos)
		local Chest = this:SpawnLimited (109124, worldPos, 40)
		Chest:GainBuff(110013)
	end
end