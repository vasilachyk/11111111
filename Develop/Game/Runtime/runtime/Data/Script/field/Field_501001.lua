
function Field_501001:OnSensorEnter_11000(Actor) -- º´»çµé
	local Field = this:GetID()
	local Soldier1 = this:GetSpawnNPC(112548)
	local Soldier2 = this:GetSpawnNPC(110112)
	local SoldierLeader = this:GetSpawnNPC(110111)
	GLog("111111111111111\n")
	Soldier1:Say("$$Field_501001_1",6) 
	Soldier2:Wait(3)
	Soldier2:Say("$$Field_501001_2",6)	
	SoldierLeader:Wait(3)
	SoldierLeader:Say("$$Field_501001_3",6)	
end

function Field_501001:OnSensorEnter_chapel(Actor)

	gamefunc:ChangeCustomWeather("chapel", 0) 
end

function Field_501001:OnSensorLeave_chapel(pActor)

	gamefunc:ChangeCurrentWeather( )
end


function Field_501001:OnSensorEnter_torture_chamber(Actor)

	gamefunc:ChangeCustomWeather("torture_chamber", 0) 
end

function Field_501001:OnSensorLeave_torture_chamber(pActor)

	gamefunc:ChangeCurrentWeather( )
end

--
-- 	function Field_501001:OnSensorEnter_boss_room(Actor)

--		gamefunc:ChangeCustomWeather("boss_room", 0) 
--	end

--	function Field_501001:OnSensorLeave_boss_room(pActor)

--		gamefunc:ChangeCurrentWeather( )
--	end



