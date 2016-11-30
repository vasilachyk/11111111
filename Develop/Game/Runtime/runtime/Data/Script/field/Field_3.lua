function Field_3:OnSensorEnter_1(Actor)
	local sz = string.format("Field_3:OnSensorEnter_1()")
	shDebug:Log(sz)
end

	-- ÀÎµµ¾î
function Field_3:OnSensorEnter_indoor(Actor)
	gamefunc:ChangeCustomTimeWeather("indoor", 1, 0)
end

function Field_3:OnSensorLeave_indoor(pActor)

	gamefunc:ChangeCurrentWeather( )
end
