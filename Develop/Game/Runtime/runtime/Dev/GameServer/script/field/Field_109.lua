-- 부러진 돛대 (peace)
--[[
function Field_109:OnSensorLeave_1090031(Actor)
	if (Actor:IsPlayer() == true) then
		if (AsPlayer(Actor):CheckCondition(1090031) == true) then
			AsPlayer(Actor):GainBuff(110093)
			AsPlayer(Actor):Tip("티안이 이동속도 상승 마법을 걸어주었습니다.")
		end
	end
end
--]]
--[[
function Field_109:OnEndCutscene(Player, CutsceneID) -- 남쪽/북쪽 해안 : 컷신 후 배타고 좌표로 이동
	if (CutsceneID == 109033) then
		Player:GateToMarker(109, 109033)
	end
	if (CutsceneID == 109034) then
		Player:GateToMarker(109, 109034)
	end	
end

function Field_109:OnEndCutscene(Player, CutsceneID) -- 북쪽/동쪽 해안 : 컷신 후 배타고 좌표로 이동
	if (CutsceneID == 109035) then
		Player:GateToMarker(109, 1090392)
	end
	if (CutsceneID == 109036) then
		Player:GateToMarker(109, 109033)
	end	
end
--]]
function Field_109:OnSpawn(SpawnInfo)
	if (SpawnInfo.NPCID == 109064) then -- 까르엔의 영혼
		local Wisp = SpawnInfo.NPC
		local localAdjPos = vec3(400, 500, 0)
		local Tree = this:GetSpawnNPC(109099)
		local worldPos = Math_LocalToWorld(Tree:GetDir(), Wisp:GetPos(), localAdjPos)
	
		Wisp:Wait(2)
		--Wisp.NPC:GainBuff(110032)
		Wisp:NarrationNow("$$Field_109_15")
		Wisp:UseTalentSelf(140114)
		Wisp:Move(worldPos)
		Wisp:SayAndNarration("$$Field_109_16",0)
		--Wisp:Patrol({109064}, PT_ONCE)
		Wisp:UseTalentSelf(140113)
		Wisp:SayAndNarration("$$Field_109_17")
		Wisp:SayAndNarration("$$Field_109_18")
		Wisp:SayAndNarration("$$Field_109_19",0)
		Wisp:UseTalentSelf(140012)
	end	
	if (SpawnInfo.SpawnID == 109098) then -- 붙잡힌 크라울러. 이팩트
		SpawnInfo.NPC:GainBuff(110015)
	end		
	if (SpawnInfo.NPCID == 109067) then -- 에란초의 조수 딜라이 패트롤
		if (SpawnInfo.SpawnID == 109067) then	
			SpawnInfo.NPC:Patrol({1090671}, PT_ONCE)
			SpawnInfo.NPC:UseTalent(10906701, SpawnInfo.NPC)
			SpawnInfo.NPC:Balloon("$$Field_109_29")
			SpawnInfo.NPC:Patrol({1090672}, PT_ONCE)
			SpawnInfo.NPC:ScriptSelf("Field_109_route1")
		end
	end	
end


function Field_109_route1(self)
	

			self:Patrol({1090672}, PT_ONCE)
			self:UseTalent(10906701, self)	
			self:Balloon("$$Field_109_42")
			self:Patrol({1090673}, PT_ONCE)
			self:UseTalent(10906703, self)	
			self:Balloon("$$Field_109_45")
			self:Patrol({1090674,1090675}, PT_ONCE)
			self:UseTalent(10906703, self)	
			self:Balloon("$$Field_109_48")
			self:Patrol({1090676,1090677}, PT_ONCE)	
			self:UseTalent(10906701, self)		
			self:Balloon("$$Field_109_51")	
			self:UseTalent(10906702, self)	
			self:Wait(math.random(1, 6));	-- 1~6초 AI 멈추기
			self:ScriptSelf("Field_109_route2")
end

function Field_109_route2(self)
	

			self:Patrol({1090676,1090675}, PT_ONCE)
			self:UseTalent(10906701, self)	
			self:Balloon("$$Field_109_62")
			self:Patrol({1090674,1090673,1090672}, PT_ONCE)
			self:UseTalent(10906701, self)	
			self:Balloon("$$Field_109_65")
			self:ScriptSelf("Field_109_route1")

end


--[[
	if (SpawnInfo.NPCID == 109098) then
		SpawnInfo.Field:SetTimer(1, 10, true)
	end

function Field_109:OnTimer(TimerID)
	if (TimerID == 1) then
		local Crawler = this:GetSpawnNPC(109098)
		local dice = math.random(0,4)
		if(dice == 0 or 4) then 
			Crawler:UseTalentSelf(210909800)
		end
		if(dice == 1) then 
			Crawler:UseTalentSelf(210909801)
		end
		if(dice == 2) then 
			Crawler:UseTalentSelf(210909802)
		end	
		if(dice == 3) then 
			Crawler:UseTalentSelf(210909803)
		end		
	end
end
--]]

--[[
function Field_109:OnSensorTalent_109090(Actor, TalentID)
	if(TalentID == 25514 ) then
		local Field = Actor:GetField()
		local NpcPos = Math_GetDistancePoint( Actor:GetPos(), Actor:GetDir(), 300 )		
		Field:Spawn( 109030, NpcPos )
	end
end


function Field_109:OnSensorTalent_109019(Actor, TalentID)
	if(TalentID == 25514 ) then		
		local Field = Actor:GetField()
		local NpcPos = Math_GetDistancePoint( Actor:GetPos(), Actor:GetDir(), 300 )		
		Field:Spawn( 109029, NpcPos )
	end
end

function Field_109:OnSensorTalent_109091(Actor, TalentID)
	if(TalentID == 25514 ) then		
		local Field = Actor:GetField()
		local NpcPos = Math_GetDistancePoint( Actor:GetPos(), Actor:GetDir(), 300 )		
		Field:Spawn( 109029, NpcPos )
	end
end
--]]


--[[
function Field_109:OnDie(DespawnInfo)
	if (DespawnInfo.NPCID == 109220) then -- 알펜 죽으면 제일스가 나타나는 이벤트

		local Field = DespawnInfo.Field
		local NpcPos = Math_GetDistancePoint( DespawnInfo.NPC:GetPos(), DespawnInfo.NPC:GetDir(), -200 )		
		local Jeils = Field:Spawn( 109310, NpcPos ) 
		
		Jeils:FaceTo(DespawnInfo.NPC)
		
		Jeils:Say("$$Field_109_134")
		Jeils:Say("$$Field_109_135")		
		Jeils:Say("$$Field_109_136")		
		Jeils:Wait(1)		
		Jeils:Narration("$$Field_109_138")
		Jeils:Despawn(false)
		
		DespawnInfo.NPC:SetDecayTime(12)
	end
	if (DespawnInfo.NPCID == 109099) then -- 까르엔이 죽으면, 까르엔의 후예가 나타나 주변에 모두 버프를 주고 퀘스트를 완료시킴. 
		--local Pos = DespawnInfo.Pos
		--
		local Tree = DespawnInfo.NPC
		local localAdjPos = vec3(0, 550, 0)
		local worldPos = Math_LocalToWorld(Tree:GetDir(), Tree:GetPos(), localAdjPos)
		--local Wisp = this:Spawn(109064, worldPos)
		local Wisp = this:SpawnLimited (109064, worldPos, 22)
		--Wisp:FaceTo(Tree)		
	end
end
--]]


function Field_109:OnSensorEnter_1098002(Actor)
	local Jeki = this:GetSpawnNPC(1090731)
	Jeki:Say("$$MK_NPC_109450_1")
	Jeki:Wait(3)
	Jeki:Say("$$MK_NPC_109450_2")
	Jeki:Wait(3)
end



function Field_109:OnSensorEnter_1098003(Actor)
	local Baragi = this:GetSpawnNPC(1090732)
	local Losel = this:GetSpawnNPC(1090733)
	Losel:Say("$$MK_NPC_109452_1")
	Losel:Wait(3)
	Baragi:Wait(2)
	Baragi:Say("$$MK_NPC_109451_1")
	Baragi:Wait(3)
	Losel:Say("$$MK_NPC_109452_2")
	Losel:Wait(3)
	Baragi:Say("$$MK_NPC_109451_2")
	Baragi:Wait(2)
	Baragi:Say("$$MK_NPC_109451_3")
	Baragi:Wait(3)
	Losel:Say("$$MK_NPC_109452_3")
	Losel:Wait(2)
end

function Field_109:OnSensorEnter_1098009(Actor)
	local Dudu = this:GetSpawnNPC(2027)
	Dudu:Say("$$MK_NPC_109050_1")
	Dudu:Wait(3)
	Dudu:Say("$$MK_NPC_109050_2")
	Dudu:Wait(3)
end