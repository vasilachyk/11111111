function Field_9091:OnSensorEnter_1(pActor)
	local sz = string.format("Field_9091:OnSensorEnter_1()")
	gamedebug:Log(sz)
	
	--gamefunc:ChangeCustomEnv("custom")
	gamefunc:ChangeCustomTimeWeather("custom", 3, 5)
	--gamefunc:ChangeCustomWeather("custom", 5)
	--gamefunc:ChangeCustomTime("custom", 3)
end

function Field_9091:OnSensorLeave_1(pActor)
	local sz = string.format("Field_9091:OnSensorLeave_1()")
	gamedebug:Log(sz)

	gamefunc:ChangeCurrentWeather()
end

function Field_9091:OnAreaEnter_1(pActor)
	local sz = string.format("Field_9091:OnAreaEnter_1() ¸Þ·Õ¸Þ·Õ")
	gamedebug:Log(sz)
end
