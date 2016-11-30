-- 순례자 (호위 대상)

function NPC_102223:OnDialogExit(Player, DialogID, ExitID)
	if (1020031 == DialogID) and (2 == ExitID) then
		this:ClearJob()
		this:SetTimer(1, 300, false)			-- 뭔가의 오류로 인해 5분안에 도착하지 않으면 자동 디스폰
		this:NonDelayBalloon("$$NPC_102223_7")	-- "좋아요, 산적들이 있는 데까지는 빠르게 갈게요."
		this:SetAlwaysRun(true)
		this:DisableInteraction()
		this:EnableSensorCheck(102003) 			-- 102003센서 체크 켬. NPC는 센서 체크를 켜줘야만 센서와 상호작용이 가능
		this:Patrol({1020031,1020032,1020033}, PT_ONCE)
		this:Balloon("$$NPC_102223_12")			-- "저기, 놈들이 보여요!"
		this:ScriptSelf("NPC_102223_Walk")
		
	end
end

function NPC_102223_Walk(Self)
	Self:SetAlwaysRun(false)
	Self:NonDelayBalloon("$$NPC_102223_13")		-- "절 보호해 주세요."
	Self:Patrol({1020034,1020035,1020036,1020037}, PT_ONCE) -- 안전장소까지 이동
	Self:ScriptSelf("NPC_102223_Escape")		
end

function NPC_102223_Escape(Self)
	Self:DisableCombat()
	Self:ChangeAA(AA_NOCE)
	Self:Balloon("$$NPC_102223_16")				-- "여기까지 왔으면 이제 안전할 거에요..."
	Self:SetAlwaysRun(true)
	Self:Patrol({1020038}, PT_ONCE)
	Self:KillTimer(1)
	Self:Balloon("$$NPC_102223_20")				-- "무사히 도착했네요. 도움에 감사드립니다."
	Self:Despawn(true)
end

function NPC_102223:OnHitCapsule_1_0(HitInfo)
	if (HitInfo.Damage >= 1) then
		--local Field = HitInfo.Victim:GetField()
		local dice = math.random(0,3)
		if( dice == 0) then 
			AsNPC(HitInfo.Victim):NonDelayBalloon("$$NPC_102223_30")	-- "도와주세요!"
		end
		if( dice == 1) then 
			AsNPC(HitInfo.Victim):NonDelayBalloon("$$NPC_102223_33")	-- "꺄악~!"
		end
		if( dice == 2) then 
			AsNPC(HitInfo.Victim):NonDelayBalloon("$$NPC_102223_36")	-- "공격받고 있어요!"	
		end
		if( dice == 3) then 
			AsNPC(HitInfo.Victim):NonDelayBalloon("$$NPC_102223_39")	-- "도움이 필요해요."
		end			
	end
end

function NPC_102223:OnTimer(TimerID)
	if (TimerID == 1) then
		this:ClearJob()	
		--this:Say("$$NPC_102223_33")
		this:Despawn(true)
	end
end

