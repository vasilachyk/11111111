-- 거지
function NPC_3039:OnSpawn(SpawnInfo)
	this:SetTimer(1, 60, true)
end

function NPC_3039:OnDialogExit(Player, DialogID, ExitID)
	if (3039 == DialogID) then
		if (2 == ExitID) then
			if (Player:GetSilver() >= 10) then
				this:DisableInteraction()
				this:SetTimer(2, 5, false)			
				this:Balloon("$$NPC_3039_10")
				Player:RemoveSilver(10)
			else
				this:DisableInteraction()
				this:SetTimer(2, 5, false)			
				this:Balloon("$$NPC_3039_13")
			end
		end
		if (3 == ExitID) then
			if (Player:GetSilver() >= 1000) then	
				this:DisableInteraction()
				this:KillTimer(1)
				this:Balloon("$$NPC_3039_20")
				Player:RemoveSilver(1000)
				this:Wait(3)
				this:Patrol({30391,30392,30393,30394,30395,30396}, PT_ONCE)
				this:ScriptSelf("NPC_3039_Album")
			else
				this:DisableInteraction()
				this:SetTimer(2, 5, false)			
				this:Balloon("$$NPC_3039_26")
			end
		end		
	end
end

function NPC_3039_Album(Self, Opponent)
	Field = Self:GetField()
	Field:SpawnByID(10020)
	Self:Wait(2)
	Self:Balloon("$$NPC_3039_36")
	Self:Balloon("$$NPC_3039_37")
	Self:Wait(1)
	Self:ScriptSelf("NPC_3039_Despawn")
	--Self:Despawn(true)
end

function NPC_3039_Despawn(Self)		-- 액자와 거지 함께 디스폰
	Field = Self:GetField()
	Self:Despawn(true)
	Field:DespawnByID(10020, false)
end

function NPC_3039:OnTimer(TimerID)	
	if (TimerID == 1) then	-- 거지의 호객 행위
		local dice = math.random(0,2)		
		if( dice == 0) then 
			this:Balloon("$$NPC_3039_46")
		end
		if( dice == 1) then 
			this:Balloon("$$NPC_3039_49")
		end
		if( dice == 2) then 
			this:Balloon("$$NPC_3039_52")
		end
	end	
	if (TimerID == 2) then	-- 대사를 말하고 5초 뒤 인터렉션 가능
		this:EnableInteraction()
		this:KillTimer(2)
		this:SetTimer(1, 60, true)		
	end		
end