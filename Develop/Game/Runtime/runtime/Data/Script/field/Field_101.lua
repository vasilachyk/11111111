function Field_101:OnSensorEnter_polluted_env(Actor)

	gamefunc:ChangeCustomWeather("pollutedtown", 0) 
end

function Field_101:OnSensorLeave_polluted_env(pActor)

	gamefunc:ChangeCurrentWeather( )
end

function Field_101:OnSensorEnter_saturation_env(Actor)

	gamefunc:ChangeCustomWeather("saturation", 0) 
end

function Field_101:OnSensorLeave_saturation_env(pActor)

	gamefunc:ChangeCurrentWeather( )
end
