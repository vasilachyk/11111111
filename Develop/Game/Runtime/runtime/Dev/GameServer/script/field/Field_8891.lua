
function Field_8891:OnSpawn(SpawnInfo)
	

	if (SpawnInfo.NPCID == 3015) then -- 소녀와 개 산책(소녀)
		if (SpawnInfo.SpawnID == 3015) then
			SpawnInfo.NPC:SetAlwaysRun(true)		
			SpawnInfo.NPC:Patrol({30151,30152,30153,30154,30155,30156,30157,30158,30159,30160,30161,30162,30163,30164,30165,30166,30167,30168,30169,30170,30171,30172,30173,30174,30175,30176,30177,30178}, PT_LOOP)
		end
	elseif (SpawnInfo.NPCID == 3016) then -- 소녀와 개 산책(개)	
		if (SpawnInfo.SpawnID == 3016) then	
			SpawnInfo.NPC:SetAlwaysRun(true)				
			SpawnInfo.NPC:Patrol({30151,30152,30153,30154,30155,30156,30157,30158,30159,30160,30161,30162,30163,30164,30165,30166,30167,30168,30169,30170,30171,30172,30173,30174,30175,30176,30177,30178}, PT_LOOP)
		end		
		
	elseif (SpawnInfo.NPCID == 3017) then -- 오스틴, 거지, 아줌마  : 오스틴 스폰 시간 기준으로 40초 마다 호객 행위 looper		
		this:SetTimer(6, 40, true)
		
	elseif (SpawnInfo.NPCID == 3068 or 3069) then -- 인젠 자유 경비대 (순찰)
		if (SpawnInfo.SpawnID == 206) then	
			SpawnInfo.NPC:Patrol({260,250,251,252,253,254,255,256,257,258,259}, PT_LOOP)			
		elseif (SpawnInfo.SpawnID == 207) then
			SpawnInfo.NPC:Patrol({253,254,255,256,257,258,259,260,250,251,252}, PT_LOOP)
		elseif (SpawnInfo.SpawnID == 217) then
			SpawnInfo.NPC:Patrol({257,258,259,260,250,251,252,253,254,255,256}, PT_LOOP)			
		elseif (SpawnInfo.SpawnID == 218) then
			SpawnInfo.NPC:Patrol({284,285,286,270,271,272,273,274,275,276,277,278,279,280,281,282,283}, PT_LOOP)			
		elseif (SpawnInfo.SpawnID == 219) then
			SpawnInfo.NPC:Patrol({272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,270,271}, PT_LOOP)				
		elseif (SpawnInfo.SpawnID == 220) then
			SpawnInfo.NPC:Patrol({276,277,278,279,280,281,282,283,284,285,286,270,271,272,273,274,275}, PT_LOOP)							
		end

	end
	
	
end


function Field_8891:OnTimer(TimerID)
	if (TimerID == 5) then 	-- 운석 예찬론자의 연설
		this:SpawnByID(61)
	end
	
	if (TimerID == 6) then	-- 수다떠는 아줌마
		local ChatterBox1 = this:GetSpawnNPC(280)
		local ChatterBox2 = this:GetSpawnNPC(281)
		local ChatterBox3 = this:GetSpawnNPC(282)
		local ChatterBox4 = this:GetSpawnNPC(283)
		local ChatterBox5 = this:GetSpawnNPC(284)
		local ChatterBox6 = this:GetSpawnNPC(285)
		local ChatterBox7 = this:GetSpawnNPC(286)
		local ChatterBox8 = this:GetSpawnNPC(287)		
		local dice = math.random(0,3)
		if( dice == 0) then 
			ChatterBox1:Balloon("$$Field_8891_90")
			ChatterBox3:Balloon("$$Field_8891_91")
			ChatterBox5:Balloon("$$Field_8891_92")
			ChatterBox7:Balloon("$$Field_8891_93")
			ChatterBox2:Wait(3);ChatterBox4:Wait(3);ChatterBox6:Wait(3);ChatterBox8:Wait(3)
			ChatterBox2:Balloon("$$Field_8891_95")
			ChatterBox4:Balloon("$$Field_8891_96")
			ChatterBox6:Balloon("$$Field_8891_97")	
			ChatterBox8:Balloon("$$Field_8891_98")
		end		
		if( dice == 1) then 
			ChatterBox2:Balloon("$$Field_8891_101")
			ChatterBox4:Balloon("$$Field_8891_102")
			ChatterBox6:Balloon("$$Field_8891_103")
			ChatterBox8:Balloon("$$Field_8891_104")
			ChatterBox1:Wait(3);ChatterBox3:Wait(3);ChatterBox5:Wait(3);ChatterBox7:Wait(3)
			ChatterBox1:Balloon("$$Field_8891_106")
			ChatterBox3:Balloon("$$Field_8891_107")	
			ChatterBox5:Balloon("$$Field_8891_108")
			ChatterBox7:Balloon("$$Field_8891_109")
		end
		if( dice == 2) then 
			ChatterBox1:Balloon("$$Field_8891_112")
			ChatterBox3:Balloon("$$Field_8891_113")
			ChatterBox5:Balloon("$$Field_8891_114")
			ChatterBox7:Balloon("$$Field_8891_115")			
			ChatterBox2:Wait(3);ChatterBox4:Wait(3);ChatterBox6:Wait(3);ChatterBox8:Wait(3)
			ChatterBox2:Balloon("$$Field_8891_117")	
			ChatterBox4:Balloon("$$Field_8891_118")
			ChatterBox6:Balloon("$$Field_8891_119")
			ChatterBox8:Balloon("$$Field_8891_120")
		end
		if( dice == 3) then 
			ChatterBox2:Balloon("$$Field_8891_123")
			ChatterBox4:Balloon("$$Field_8891_124")
			ChatterBox6:Balloon("$$Field_8891_125")
			ChatterBox8:Balloon("$$Field_8891_126")
			ChatterBox1:Wait(3);ChatterBox3:Wait(3);ChatterBox5:Wait(3);ChatterBox7:Wait(3)
			ChatterBox1:Balloon("$$Field_8891_128")
			ChatterBox3:Balloon("$$Field_8891_129")
			ChatterBox5:Balloon("$$Field_8891_130")
			ChatterBox7:Balloon("$$Field_8891_131")				
		end		
	end	
end
