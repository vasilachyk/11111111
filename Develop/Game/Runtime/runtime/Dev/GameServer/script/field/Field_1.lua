--117055 수도부관 리리아
function Field_1:OnSensorEnter_5(Actor)	
	if (AsPlayer(Actor):CheckCondition(1170552) == true ) then			
		-- local NpcPos = Math_GetDistancePoint(AsPlayer(Actor):GetPos(), AsPlayer(Actor):GetDir(), 50)
		AsPlayer(Actor):UpdateQuestVar(117055,3)		
		-- this:DisableSensor(1180)
	end		
end


function Field_1:OnCreate()
	this:SetTimer(11, 300, true)
	
end

---------------------------------------------퀘: 수상한 움직임 117025

function Field_1:OnSensorEnter_1180(Actor)	
	if (AsPlayer(Actor):CheckCondition(1170252) == true ) then			
		-- local NpcPos = Math_GetDistancePoint(AsPlayer(Actor):GetPos(), AsPlayer(Actor):GetDir(), 50)
		this:SpawnByID(1180)
		-- this:DisableSensor(1180)
	end		
end

function Field_1:OnSensorEnter_1181(Actor)
	if (AsPlayer(Actor):CheckCondition(1170253) == true ) then	
		-- local NpcPos = Math_GetDistancePoint(AsPlayer(Actor):GetPos(), AsPlayer(Actor):GetDir(), 50)
		this:SpawnByID(1181)
		-- this:DisableSensor(1181)
	end		
end

function Field_1:OnSensorEnter_1182(Actor)
	if (AsPlayer(Actor):CheckCondition(1170254) == true ) then	
		-- local NpcPos = Math_GetDistancePoint(AsPlayer(Actor):GetPos(), AsPlayer(Actor):GetDir(), 50)
		this:SpawnByID(1182)
		-- this:DisableSensor(1182)		
	end		
end

function Field_1:OnSensorEnter_1183(Actor)
	if (AsPlayer(Actor):CheckCondition(1170255) == true ) then	
		-- local NpcPos = Math_GetDistancePoint(AsPlayer(Actor):GetPos(), AsPlayer(Actor):GetDir(), 50)
		this:SpawnByID(1183)
		-- this:DisableSensor(1183)		
	end		
end
------------------------------------------------------

function Field_1:OnSensorEnter_1200(Actor) -- 리츠 여관방문 
	if Actor:IsPlayer() == true then
		--[[if AsPlayer(Actor):CheckCondition(900) == true then
			AsPlayer(Actor):Tip("$$DoorOpenTip")	자동으로 들어가게 바뀌면서 안내 문구 없앰
		end--]]
		if AsPlayer(Actor):CheckCondition(900) == false then
			AsPlayer(Actor):Tip("$$InnRegistTip")
		end		
	end
end





-- Portal to Ritz
function Field_1:OnSensorEnter_1(Actor)
	AsPlayer(Actor):GateToMarker(101, 3);
end


function Field_1:OnTimer(TimerID)
	
	if (TimerID == 10) then	
	
		---연습하는 병사들
		local TalentDice = math.random(141100,141101)				
		local array = {1455, 1451, 1456, 1452}
		
		for i,v in ipairs(array) do 
			local pirate = this:GetNPC(v)
			pirate:UseTalentSelf(TalentDice)			
		end
	
	end
	
	if (TimerID == 11 ) then	
	
		local SeniorTrainer = this:GetNPC(1122)		
		SeniorTrainer:Say("$$Field_109_139")				
		this:SetTimer(10, 1, false)
		
	end
	

	if (TimerID == 6) then	-- 거지의 호객 행위
		
		local Beggar = this:GetSpawnNPC(1328)		
		local dice = math.random(0,2)		
		
		if( dice == 0) then 
			Beggar:Balloon("$$Field_1_001")
		end
		if( dice == 1) then 
			Beggar:Balloon("$$Field_1_002")
		end
		if( dice == 2) then 
			Beggar:Balloon("$$Field_1_003")
		end
	end	

	if (TimerID == 2) then	-- 오빠 저거사줘
		local ChatterBox1 = this:GetSpawnNPC(280)
		local ChatterBox2 = this:GetSpawnNPC(281)
		local ChatterBox3 = this:GetSpawnNPC(282)
		local ChatterBox4 = this:GetSpawnNPC(283)
		local ChatterBox5 = this:GetSpawnNPC(284)
		local ChatterBox6 = this:GetSpawnNPC(285)
		local ChatterBox7 = this:GetSpawnNPC(286)
		local ChatterBox8 = this:GetSpawnNPC(287)		
		local dice = math.random(0,1)
		if( dice == 0) then 
			ChatterBox1:Balloon("$$Field_3_240")
			ChatterBox3:Balloon("$$Field_3_241")
			ChatterBox5:Balloon("$$Field_3_242")
			ChatterBox7:Balloon("$$Field_3_243")
			ChatterBox2:Wait(3);ChatterBox4:Wait(3);ChatterBox6:Wait(3);ChatterBox8:Wait(3)
			ChatterBox2:Balloon("$$Field_3_245")
			ChatterBox4:Balloon("$$Field_3_246")
			ChatterBox6:Balloon("$$Field_3_247")	
			ChatterBox8:Balloon("$$Field_3_248")
		end		
		if( dice == 1) then 
			ChatterBox2:Balloon("$$Field_3_251")
			ChatterBox4:Balloon("$$Field_3_252")
			ChatterBox6:Balloon("$$Field_3_253")
			ChatterBox8:Balloon("$$Field_3_254")
			ChatterBox1:Wait(3);ChatterBox3:Wait(3);ChatterBox5:Wait(3);ChatterBox7:Wait(3)
			ChatterBox1:Balloon("$$Field_3_256")
			ChatterBox3:Balloon("$$Field_3_257")	
			ChatterBox5:Balloon("$$Field_3_258")
			ChatterBox7:Balloon("$$Field_3_259")
		end

	end
end

function Field_1:OnSensorTalent_1169(Actor, TalentID) 
	local sirub = this:GetSpawnNPC(1173)
	if TalentID == 2000067 then
		local dice = math.random(0,2)
		if( dice == 0) then 
			sirub:UseTalentSelf(141140)
		end		
		if( dice == 1) then 
			sirub:UseTalentSelf(141141)
		end		
		if( dice == 2) then 
			sirub:UseTalentSelf(141142)
		end
	end
	if TalentID == 2000070 then
		sirub:UseTalentSelf(141143)
	end
end
