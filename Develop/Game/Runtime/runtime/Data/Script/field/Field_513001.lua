

	-- 왼쪽
function Field_513001:OnSensorEnter_left(Actor)
	gamefunc:ChangeCustomEnv("left")
end

function Field_513001:OnSensorLeave_left(pActor)

	gamefunc:ChangeCurrentWeather( )
end

	-- 오른쪽
function Field_513001:OnSensorEnter_right(Actor)
	gamefunc:ChangeCustomEnv("right")
end

function Field_513001:OnSensorLeave_right(pActor)

	gamefunc:ChangeCurrentWeather( )
end

