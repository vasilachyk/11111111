
-- ////////////////////////// 9090 ///////////////////////////

function Field_9090:OnSpawn(SpawnInfo) 
	if (SpawnInfo.SpawnID == 109221) then
		SpawnInfo.NPC:ChangeAA(AA_NONE)
		SpawnInfo.NPC:SetAlwaysRun(true)
		SpawnInfo.Field:SetTimer(1, 15, true)
	end
end

function Field_9090:OnTimer(TimerID) 
	if (TimerID == 1) then
		local Morken = this:GetSpawnNPC(109221)			

		Morken:Say("$$Field_9090_16")
		Morken:Say("$$Field_9090_17")
		
		Morken:ScriptSelf("Field_9090_MorkentAct")
	end
end

function Field_9090_MorkentAct(Self)
	local Field = Self:GetField()

	local Morken = Field:GetSpawnNPC(109221)
	
	Morken:Roam(1000, 2)	
end

