function Field_107:OnSensorEnter_12(Actor)
	local sz = string.format("Field_107:OnSensorEnter_12()")
	gamedebug:Log(sz)

	gamefunc:ChangeCustomWeather("custom_test", 0, 5)
end

function Field_107:OnSensorLeave_12(pActor)
	local sz = string.format("Field_107:OnSensorLeave_12()")
	gamedebug:Log(sz)

	gamefunc:ChangeCurrentWeather()
end

function Field_107:OnSensorEnter_1000011(pActor)
	gamefunc:HelpTrigger(11);		-- 자동파티 설명
end