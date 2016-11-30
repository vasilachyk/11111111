--[[	
	Talent.lua
--]]



function CallAlly5m(ThisActor, Opponent)
	if (ThisActor:IsNPC()) then
		AsNPC(ThisActor):Yell(500)
	end
end

function CallAlly8m(ThisActor, Opponent)
	if (ThisActor:IsNPC()) then
		AsNPC(ThisActor):Yell(800)
	end
end

function CallAlly10m(ThisActor, Opponent)
	if (ThisActor:IsNPC()) then
		AsNPC(ThisActor):Yell(1000)
	end
end

function CallAlly20m(ThisActor, Opponent)
	if (ThisActor:IsNPC()) then
		AsNPC(ThisActor):Yell(2000)
	end
end

--[[
	brief:
		근접 or 원거리 공격이 가능한 npc의 공격 명령을 수행시 특정 공격패턴을 적용시키위해 작성한 함수
		
		1. 직접 타격이 가능한 거리(400m 안쪽) 라면 즉시 공격을 수행
		2. 근거리 영역 내에 있지만 타격이 안되는 거리라면 상대와 거리를 좁히고, 입력값에 따라 강제 공격을 수행한다.
		3.	원거리 사거리면 원거리 공격.
		4.	원거리 사거리 밖이면 패스.
	param:
		ThisNPC : 공격을 수행할 npc
		Enemy : 대상 Actor
		arrRangeSep: 근, 원거리, 사거리 밖을 구분하는 값  
				ex ) { 200,   1000 }         : 200미터 내에서 근접공격   200-1000 원거리  1000이상    사거리 밖
		arrMelee : 근거리내에서 공격가능한 Talent배열
		arrMRate : 근거리내에서 공격가능한 Talent의 Rate값
		arrRange : 원거리공격 Talent배열
		arrRRate : 원거리공격의 각 Rate값
		ForceAttack : 근접시도후 강제공격을 수행할지 말지를 결정하는 파라미터 boolean 값
	
		ex) 
		SmartAttack( ThisNPC, Enemy, { 600, 2400 }, { 210702001, 210702003 }, { 80, 20 }, { 210702002 }, { 100 }, true )
		
--]]
function SmartAttack( ThisNPC, Enemy, arrRangeSep, arrMelee, arrMRate, arrRange, arrRRate, ForceAttack )
	
	local SepCnt = table.getn( arrRangeSep )
	if SepCnt ~= 2 then
		GLog( "SmartAttack Error : 근원거리 구분자 배열은 2개의 구성원을 가져야 합니다.\n" )
		return false
	end 
	
	local MeleeCnt = table.getn( arrMelee )
	local RangeCnt = table.getn( arrRange )
	local Distance = ThisNPC:DistanceTo( Enemy )

	if Distance < 400 then -- 직접타격 가능거리
		local MeleeTalID = ChooseSmartAttackTalent( arrMelee, arrMRate, MeleeCnt )
		ThisNPC:UseTalent( MeleeTalID, Enemy )
		--GLog( "MeleeTal : "..MeleeTalID.."\n" )
		return true
	elseif Distance < arrRangeSep[1] then -- 근접을 위해서 3초간 접근시도
		local MeleeTalID = ChooseSmartAttackTalent( arrMelee, arrMRate, MeleeCnt )
		ThisNPC:MoveToActorWithDuration( Enemy, MeleeTalID, 3 )
		if ForceAttack == true then 
			ThisNPC:UseTalent( MeleeTalID, Enemy )
		end
		--GLog( "MeleeTal : "..MeleeTalID.."\n" )
		return false
	elseif Distance < arrRangeSep[2] then -- 원거리 시도 범위내
		local RangeTalID = ChooseSmartAttackTalent( arrRange, arrRRate, RangeCnt )
		ThisNPC:UseTalent( RangeTalID, Enemy )
		--GLog( "RangeTal : "..RangeTalID.."\n" )
		return true
	end
end

--[[
	난수를 발생시켜 기술을 선택해준다
--]]
function ChooseSmartAttackTalent(  arrTalent, arrRate, TalentCnt )
	local n = math.random(1, 100)
	local RateTot = 0
	for i = 1, TalentCnt, 1 do
		RateTot = RateTot + arrRate[i]
		if n <= RateTot then
			return arrTalent[i]
		end
	end
end

--[[
	brief : 
		소환수를 소환하는 함수
	param :
		NPC Summoner : 소환자
		ACTOR Opponent : 소환수에게 공격을 지정할 상대방
		number MinionID : 소환수 ID
		number MinionCnt : 소환수 갯수
		string Msg : 소환할때 사용할 메시지
--]]
function SummonMinion( Summoner, Opponent, MinionID, MinionCnt, Msg, min, max )
	local WorldPos = vec3()
	local Field = Summoner:GetField()
	
	if Msg ~= nil then
		--Summoner:Narration( Msg )
		--Summoner:Say( Msg )
	end 
	
	for i = 1, MinionCnt, 1 do
		local LocalAdjPos = vec3(math.random(min, max), math.random(min, max), 0)
		WorldPos = Math_LocalToWorld(Summoner:GetDir(), Summoner:GetPos(), LocalAdjPos)

		local Minion = Summoner:Summon(MinionID, WorldPos)
		if Opponent ~= nil then
			Minion:Attack(Opponent)
		end 
	end
end

--[[
	AI_SideAttack
	
	effectiveDistance:
	limitDistance:
	TalentID:
--]]
function AI_SideAttack(ThisNPC, Opponent, effectiveDistance, limitDistance, TalentID)
	local Distance = ThisNPC:DistanceTo(Opponent)
	
	if(Distance > limitDistance or Distance < effectiveDistance) then
		-- ThisNPC:Say("-- DEBUG: Too Near [[REMOVE ME]] --")
	else
		local LocalAdjPos = vec3(effectiveDistance + 20, 0, 0);
		if( math.random(0,1) == 1) then 
			LocalAdjPos = vec3(-1*(effectiveDistance + 20), 0, 0)
		end

		local WorldPos = vec3()

		WorldPos = Math_LocalToWorld(Opponent:GetDir(), Opponent:GetPos(), LocalAdjPos)
		ThisNPC:Move(WorldPos)
	end
	
	ThisNPC:MoveToActor(Opponent, TalentID)
	ThisNPC:UseTalent(TalentID, Opponent)
end

--[[
	AI_RandomAttack(ThisNPC, Opponent, arrayTalents)
	
	제한시간은 3초로 일괄 제한
--]]
function AI_RandomAttack(ThisNPC, Opponent, arrayTalents)
	local count = table.getn(arrayTalents)
	if(count > 0) then
		local ranNum = math.random(1, count)
		if(Opponent == nil) then
			ThisNPC:UseTalentSelf(arrayTalents[ranNum])
		else
			ThisNPC:MoveToActorWithDuration(Opponent, arrayTalents[ranNum], 3)
			ThisNPC:UseTalent(arrayTalents[ranNum], Opponent)
		end
	end
end

--[[
	AI_RandomAttackWithDuration(ThisNPC, Opponent, arrayTalents, duration)
--]]
function AI_RandomAttack(ThisNPC, Opponent, arrayTalents, duration)
	local count = table.getn(arrayTalents)
	if(count > 0) then
		local ranNum = math.random(1, count)
		if(Opponent == nil) then
			ThisNPC:UseTalentSelf(arrayTalents[ranNum])
		else
			ThisNPC:MoveToActorWithDuration(Opponent, arrayTalents[ranNum], duration)
			ThisNPC:UseTalent(arrayTalents[ranNum], Opponent)
		end
	end
end

function AI_SmartChangeTarget(ThisNPC, Opponent, effectiveDistance, arrayCloseAggroParams, arrayRangeAggroParams, arrayCloseTalents, arrayRangeTalents)

end

function UT_GetPointsAroundTarget(ThisNPC, Opponent, TargetDistance, TargetDegree, TalentID)

end


--[[
brief :
	Target좌표를 Center기준으로 Angle만큼 회전시킨 좌표를 구한다

param :
	vecTarget 		: 대상좌표
	vecCenter		: 중심좌표
	Angle				: 회전각도

return
	회전결과 좌표
--]]
function RotatePoint(  vecTarget, vecCenter, Angle )
	local PI = 3.14159
	-- 라디안 값으로 변환
	Angle = Angle * PI / 180
	
	local cosq = math.cos( Angle )
	local sinq = math.sin( Angle )
		
    -- 회전중심점 C가 원점  O와 일치하도록 회전할 점 T를 함께 평행이동
    vecTarget.x = vecTarget.x - vecCenter.x
	vecTarget.y = vecTarget.y - vecCenter.y

    -- 원점 O에 대하여 회전할 점 T를 q라디안 만큼 회전
	local vecNew = vec3()
    vecNew.x  =  vecTarget.x *  cosq - vecTarget.y * sinq
    vecNew.y =  vecTarget.y * cosq + vecTarget.x * sinq
	vecNew.z = vecTarget.z

    -- 원점 O가 원래의 회전 중심점 C와 일치하도록 회전된 점 N과 함께 이동
    vecNew.x = vecNew.x + vecCenter.x
	vecNew.y = vecNew.y + vecCenter.y
	
	return vecNew
end

--[[
brief :
	두 좌표사이의 일정 비율에 해당하는 좌표를 반환
param :
	vecTarget		: 대상좌표
	vecSrc			: 소스좌표
	Rate				: 대상과 소스 사이의 2D좌표상의 비율. 0.5면 중점을 구하고 0.5보다 낮을수록 소스좌표에 가까워진다.
	
return :
	결과좌표
	
--]]
function GetRelatedPoint( vecTarget, vecSrc, Rate )
	local vecRet = vec3()
	vecRet.x = (vecTarget.x - vecSrc.x) * Rate + vecSrc.x
	vecRet.y = (vecTarget.y - vecSrc.y) * Rate + vecSrc.y
	vecRet.z = (vecTarget.z - vecSrc.z) * Rate +  vecSrc.z
	return vecRet
end

--[[
brief:
	두 좌표사이의 직선상에 위치하는 좌표를 반환

param:
	vecTarget		: 대상좌표
	vecSrc			: 소스좌표
	d					: 대상좌표에서 떨어진거리
	Direction		: 대상좌표에서의 방향성
		Direction = true   -  소스좌표에서 거리가 먼쪽의 좌표
		Direction = false   -  소스좌표에서 거리가 가까운 쪽의 좌표
		
return :
	좌표값
--]]

--[[
function GetDirectionalPoint( vecTarget, vecSrc, d, Direction )
	local X1 = vecSrc.x
	local Y1 = vecSrc.y
	local X2 = vecTarget.x
	local Y2 = vecTarget.y

	-- y = mx + n
	local m = ( Y2 - Y1 ) / ( X2 - X1 )
	local n = Y2 - m*X2
	local p = n-Y2
	
	local a = (m^2) + 1
	local b = 2*m*p - 2*X2
	local c = (X2^2) + (p^2) -(d^2)

	local sum1 = b^2 -4*a*c
	
	local vecNew = vec3()
	if sum1 < 0 then 
		return vecNew
	end	
	
	local X3 = (-1 * b + (( b^2 -4*a*c )^0.5) ) / (2*a)
	local Y3 = m * X3 + n
	local X4 = (-1 * b - (( b^2 -4*a*c )^0.5) ) / (2*a)
	local Y4 = m * X4 + n
	
	local vecNew = vec3()
	vecNew.z = vecTarget.z
	
	d1 = ( ( X3 - X1 )^2 ) + ( ( Y3-Y1 )^2 )
	d2 = ( ( X4 - X1 )^2 ) + ( ( Y4-Y1 )^2 )
	
	vecNew.z = vecTarget.z
	if Direction == true then
		if d1>d2 then
			vecNew.x = X3
			vecNew.y = Y3
		else 
			vecNew.x = X4
			vecNew.y = Y4
		end
	else
		if d1>d2 then
			vecNew.x = X4
			vecNew.y = Y4
		else 
			vecNew.x = X3
			vecNew.y = Y3
		end
	end
	
	return vecNew
end
--]]

--[[
brief:
	시작점과 끝점을 이어주는 직선의 2D 각도(Degree)를 구한다.
	
param:
	vecStart 	: 시작점
	vecEnd 		: 종료점
	
return:
	2D 각도
--]]
function GetDegree( vecStart, vecEnd )
	local Angle = math.atan2( vecEnd.y - vecStart.y , vecEnd.x - vecStart.x )
	
	local PI = 3.14159
	-- Degree 값으로 변환
	 Angle = Angle*180/PI
	 
	 return Angle
end

--[[
brief:
	현제좌표를 적의좌표를 기준으로 임의의 각도로 회전 변환(AngleRange값의 범위내) 한 좌표로 이동하는 함수
	
param:
	ThisNPC : 도망가는 npc
	Enemy : 대상 Actor
	AngleRange : 회전 각도의 허용범위             회전 허용 최소각도는 20도
	WaitInterval : 한번 이동후 Wait하는 시간
	
--]]
function RotateMove( ThisNPC, Enemy, AngleRange, WaitInterval )
	--파라미터 기본값
	
	if AngleRange < 20 then -- 최소각 체크
		return
	end
		
	local Angle = math.random( 20, AngleRange )
	
	if math.random( 0, 1 ) == 0 then
		Angle = Angle * -1
	end
	
	local vecTarget = ThisNPC:GetPos()
	local vecCenter = Enemy:GetPos()
	local vecNew = vec3()
	
	vecNew = RotatePoint( vecTarget, vecCenter, Angle )
	ThisNPC:Move( vecNew )
	ThisNPC:FaceTo( Enemy )
	
	if WaitInterval > 0 then
		ThisNPC:Wait( WaitInterval )
	end
end

--[[
brief:
	원거리에서 지그재그로 접근
param :
	ThisNPC 		: 도망가는 npc
	Enemy 			: 대상 Actor
	AngleRange 	: 대상에 접근할때 허용되는 각도의 범위
	WaitInterval 	: 한번 이동후 Wait하는 시간
	Rate 				: 대상과의 거리를 좁히는 비율.  0.5 면 절반을 좁힌다.
	
return :
	함수의 성패 여부
	
	-1 	: 실패
	1 		: 성공
--]]
function ApproachMove( ThisNPC, Enemy, AngleRange, WaitInterval, Rate )
		
	local Distance = ThisNPC:DistanceTo( Enemy )	
	-- 가까우면 거리는 좁히지 않고 회전만 수행
	if Distance < 400 then
		return -1
	end
	
	local Angle = math.random( -1 * AngleRange, AngleRange )
	
	local vecTarget = ThisNPC:GetPos()
	local vecCenter = Enemy:GetPos()
	local vecNew = vec3()
	
	vecTarget = GetRelatedPoint( vecTarget, vecCenter, Rate )
	vecNew = RotatePoint( vecTarget, vecCenter, Angle )
	
	ThisNPC:Move( vecNew )
	ThisNPC:FaceTo( Enemy )
	
	if WaitInterval > 0 then
		ThisNPC:Wait( WaitInterval )
	end
	
	return 1
end

function ApproachLeft( ThisNPC, Enemy )
	local Dir = ThisNPC:GetFowardDir(Enemy) 		-- 순회 계산시 초기방향
	local EdgeCnt = 8
	
	local Points = Math_GetPolygonPoints(Enemy:GetPos(), Dir, 100, EdgeCnt )
	
	ThisNPC:Move( Points[ "1" ] )
end

function ApproachRight( ThisNPC, Enemy )
	local Dir = ThisNPC:GetFowardDir(Enemy) 		-- 순회 계산시 초기방향
	local EdgeCnt = 8
	
	local Points = Math_GetPolygonPoints(Enemy:GetPos(), Dir, 100, EdgeCnt )
	
	ThisNPC:Move( Points[ "8" ] )
end

function RunAround( ThisNPC, Enemy )
	local Distance = ThisNPC:DistanceTo(Enemy)	-- 목표와의 거리
	local EdgeCnt = 8
	
	local Points = Math_GetPolygonPoints(Enemy:GetPos(), ThisNPC:GetFowardDir(Enemy) , Distance, EdgeCnt )
	local WayPoints = {}
	
	if math.random(0,1) == 1 then
		for i=1, 3 do
			WayPoints[i] = Points[tostring(i)]
		end
	else
		for i=6, 8 do
			WayPoints[ i-5 ] = Points[ tostring( 13-i ) ]
		end
	end
	
	ThisNPC:PatrolInstant(WayPoints, PT_ONCE)
	ThisNPC:FaceTo( Enemy )
	ThisNPC:Wait(0.5)
end

function SideStep( ThisNPC, Enemy )
	local Distance = ThisNPC:DistanceTo(Enemy)	-- 목표와의 거리
	local EdgeCnt = 12
	
	local Points = Math_GetPolygonPoints(Enemy:GetPos(), ThisNPC:GetFowardDir(Enemy) , Distance, EdgeCnt )
	
	if math.random(0,1) == 1 then
		ThisNPC:Move( Points[ "1" ] )
	else
		ThisNPC:Move( Points[ "12" ] )
	end
	
	ThisNPC:FaceTo( Enemy )
	ThisNPC:Wait(0.5)
end

function ChkMFForHitReaction( HitInfo )
	return HitInfo.MF:Get( MF_KNOCKBACK ).Value >= 100 or 
		HitInfo.MF:Get( MF_THROWUP ).Value >= 100  or
		HitInfo.MF:Get( MF_BEATEN ).Value >= 100 or
		HitInfo.MF:Get( MF_STUN ).Value >= 100 or
		HitInfo.MF:Get( MF_KNOCKDOWN ).Value >= 100 
end

--[[
	GlobalPain을 유발하기 위한 대표값을 뽑아내는 수식
	
--]]
DEFAULT_PAINLIMIT = 1000

function GetPainPoint( HitInfo )
	-- 최대체력의 1/1000 이하의 데미지는 무시한다.
	if HitInfo.Victim:GetMaxHP()/1000 > HitInfo.Damage then
		return 0
	end
	
	if HitInfo.MF:Get( MF_THROWUP ).Value >= 100 then
		return 10
	end
	
	if HitInfo.MF:Get( MF_KNOCKDOWN ).Value >= 100 then
		return 10
	end
	
	if HitInfo.MF:Get( MF_STUN ).Value >= 100 then
		return 10
	end
	
	if HitInfo.MF:Get( MF_KNOCKBACK ).Value >= 100 then
		return 3
	end
	
	if HitInfo.MF:Get( MF_BEATEN ).Value >= 100 then
		return 3
	end
	
	return 0
end

function ProcessPain( ThisNPC, HitInfo, TalIdPain, DataIdxForPain )
	local PainPoint = GetPainPoint( HitInfo )
	
	if PainPoint < 0 then
		return
	end
	
	local AccPainPoint = ThisNPC:GetUserData( DataIdxForPain ) + PainPoint
	if AccPainPoint > DEFAULT_PAINLIMIT and 
		( not ThisNPC:IsCooldown( TalIdPain ) ) then
		
		ThisNPC:ClearJob()
		ThisNPC:UseTalentSelf( TalIdPain )
		ThisNPC:SetUserData( DataIdxForPain, 0 )
	else
		ThisNPC:SetUserData( DataIdxForPain, AccPainPoint )
	end
	
	return
end
	
	
--[[ 
	디버깅용 함수
--]]

function _LogHitInfo( HitInfo )
	GLog( "BE[" .. HitInfo.MF:Get(MF_BEATEN).Value .. "," .. HitInfo.MF:Get(MF_BEATEN).Weight 
	.. "] KB[" .. HitInfo.MF:Get(MF_KNOCKBACK).Value .. "," .. HitInfo.MF:Get(MF_KNOCKBACK).Weight 
	.. "] ST[" .. HitInfo.MF:Get(MF_STUN).Value .. "," .. HitInfo.MF:Get(MF_STUN).Weight 
	.. "] KD[" .. HitInfo.MF:Get(MF_KNOCKDOWN).Value .. "," .. HitInfo.MF:Get(MF_KNOCKDOWN).Weight 
	.. "] TU[" .. HitInfo.MF:Get(MF_THROWUP).Value .. "," .. HitInfo.MF:Get(MF_THROWUP).Weight .."] \n"   )
end


--[[
	전투개시 음향 및 메시지 관련 함수들
--]]

function BespioAggroChat1( ThisNPC, Enemy)
	local dice = math.random(0,9)
	
	if dice == 0 then
		ThisNPC:NonDelaySay("$$BespioAggro1")
	elseif dice == 1 then
		ThisNPC:NonDelaySay("$$BespioAggro2")
	elseif dice == 2 then
		ThisNPC:NonDelaySay("$$BespioAggro3")
	elseif dice == 3 then
		ThisNPC:NonDelaySay("$$BespioAggro4")
	end
end

function BespioAggroChat2( ThisNPC, Enemy)
	local dice = math.random(0,9)
	
	if dice == 0 then
		ThisNPC:NonDelaySay("$$BespioAggro1")
	elseif dice == 1 then
		ThisNPC:NonDelaySay("$$BespioAggro5")
	elseif dice == 2 then
		ThisNPC:NonDelaySay("$$BespioAggro3")
	elseif dice == 3 then
		ThisNPC:NonDelaySay("$$BespioAggro4")
	end
end

function BespioAggroChat3( ThisNPC, Enemy)
	local dice = math.random(0,9)
	
	if dice == 0 then
		ThisNPC:NonDelaySay("$$BespioCook1")
	elseif dice == 1 then
		ThisNPC:NonDelaySay("$$BespioCook2")
	elseif dice == 2 then
		ThisNPC:NonDelaySay("$$BespioCook3")
	elseif dice == 3 then
		ThisNPC:NonDelaySay("$$BespioCook4")
	elseif dice == 4 then
		ThisNPC:NonDelaySay("$$BespioCook5")
	end
end

function GaddielAggroChat1( ThisNPC)
	local dice = math.random(0,6)
	
	if dice == 0 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat1")
	elseif dice == 1 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat2")
	elseif dice == 2 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat3")
	end
end

function GaddielAggroChat2( ThisNPC )
	local dice = math.random(0,6)
	
	if dice == 0 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat4")
	elseif dice == 1 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat5")
	elseif dice == 2 then
		ThisNPC:NonDelayBalloon("$$GaddielAggroChat6")
	end
end

function GaddielDenature( ThisNPC)
	local dice = math.random(0,6)
	
	if dice == 0 then
		ThisNPC:NonDelayBalloon("$$GaddielDenature1")
	elseif dice == 1 then
		ThisNPC:NonDelayBalloon("$$GaddielDenature2")
	elseif dice == 2 then
		ThisNPC:NonDelayBalloon("$$GaddielDenature3")
	end
end
-- 
function BetrayersAggroChat( ThisNPC, Enemy)
	local dice = math.random(0,2)

	if dice == 0 then
		ThisNPC:NonDelaySay("$$BetrayerAggro1")
	elseif dice == 1 then
		ThisNPC:NonDelaySay("$$BetrayerAggro2")
	elseif dice == 2 then
		ThisNPC:NonDelaySay("$$BetrayerAggro3")
	end
end

--[[
	연출 관련
--]]
function PuppetBegin(npc)
	--GLog("PuppetBegin "..npc:GetID().."\n")
	npc:ClearJob();
	npc:GainBuffDetail(1900, 600, 0); -- 무적버프
	npc:SaveHomePoint();
	npc:ChangeAA(AA_NONE)
	npc:DisableCombat();
	npc:MakePeace();
end

function PuppetFinish(npc)
	--GLog("PuppetFinish "..npc:GetID().."\n")
	npc:RemoveBuff(1900); -- 무적버프 잃기
	npc:ChangeAA(AA_FACTION)
	npc:EnableCombatWithFaction();
end

--[[
brief:
	카드를 섞거나 랜덤으로 맵을 만들때 사용 
	루아 테이블을 섞어주는 셔플 함수
     http://en.wikipedia.org/wiki/Fisher-Yates_shuffle 참조
--]]

function shuffle(t)
  local n = #t
 
  while n > 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
 
  return t
end

-- 유저 요리 차리기 (임시)
--function SummonVegetable( ThisActor, Enemy )
--	local Field = ThisActor:GetField()
--	local LocalAdjPos = vec3(50, 50, 0)
--	WorldPos = Math_LocalToWorld(ThisActor:GetDir(), ThisActor:GetPos(), LocalAdjPos)

--	Field:SpawnLimited(4000000, WorldPos, 60)
--end


--디펜스모드용 코어툴에 정해진 개수만 디스폰
function DespawnBy_SpawnID(ThisField, StartNum, AddNum )			
	for i = StartNum , StartNum - 1 + AddNum do						
		ThisField:DespawnByID(i, false)
	end	
	GLog("DeSpawnBy ("..StartNum..")\n")	
end

--디펜스모드용 코어툴에 정해진 개수만 스폰
function SpawnBy_SpawnID(ThisField, StartNum, AddNum, Min, Max)		
	
	for i = StartNum , StartNum - 1 + AddNum do		
		local dice = math.random(Min,Max)
		ThisField:SpawnDelayByID(i, dice)				
		-- GLog("Spawn("..StartNum..") " .. dice .."\n")
	end		
	
	
end

---스폰된 ID가 마커로 이동
function SpawnID_MoveToMarker(ThisField, SpawnID, MarkerID)		
	local NPC  = ThisField:GetSpawnNPC(SpawnID)			
		NPC:MoveToMarker(MarkerID)				
	return NPC
end


--디펜스모드용 NPC의 인스턴스를 스폰
function SpawnBy_NPCID(ThisField, StartNum, AddNum)		
	
	for i = StartNum , StartNum - 1 + AddNum do				
		-- GLog("Spawn("..i..")\n")
		ThisField:SpawnByID(i)		
	end		
end


--디펜스모드용 모든 NPC 디스폰
function DespawnBy_NPCID(ThisField, Array)		
	for k,v in ipairs(Array) do				
		local NPC = ThisField:GetNPC(v)		
		ThisField:Despawn(v, false)					
		-- GLog("DespawnBy_NPCID : "..v.."\n")
	end	
end

--디펜스모드용 NPC 사망 
function KillNPC_Timer(ThisField, StartNum, AddNum, BoolKillTimer)	
	
	if (BoolKillTimer == true) then
		-- GLog("KillNPCTimer("..i..")\n")
		ThisField:KillTimer(StartNum)
	end			
	
	for i = StartNum , StartNum - 1 + AddNum do				
		-- GLog("KilledBy("..i..")\n")
		local NPC = ThisField:GetSpawnNPC(i)		
		NPC:ClearJob()
		NPC:Die(NPC)				
	end	
end

--Settimer에 배열을 지정
function SetTimer_Stack(ThisField, ID, Interval, Repeatable, StackArray)				
	ThisField:SetTimer(ID, Interval, Repeatable)	
	table.insert(StackArray, ID)
	-- GLog("Stacked\n")
end

--아이디를 배열에 저장한뒤 Kill 타이밍을 한다
function Stacked_KillTimer(ThisField, StackArray)	
	for k,v in ipairs(StackArray) do
		ThisField:KillTimer(v)
		-- GLog("KillTImer : "..v.."\n")
	end
end



function Init_2DArray(array, x,y)			
	for i = 1, x do
	array[i] = {}	
		for j =1, y do	
			array[i][j] = {i,j}
			-- GLog(""..array[i][j][1].."")
			-- GLog(" "..array[i][j][2].."\n")
		end	
		-- GLog("\n")
	end
	return array
end


function Init_3DArray(array, x,y,z)			
	for i = 1, x do
	array[i] = {}	
		for j =1, y do	
			array[i][j] = {}
			for k = 1, z do
				array[i][j][k] = {}
			end
		end	
	end
	return array
end

-- function Defense_PhaseToSpawn(ThisField, StartNum, AddNum)
	-- for i = StartNum, StartNum - 1 + AddNum do		
		-- Array_SpawnNPC(ThisField, StartNum, AddNum)
	-- end
-- end




