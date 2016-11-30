

function Field_103:OnSensorEnter_env_bolrac(Actor)

	gamefunc:ChangeCustomWeather("bolrack", 0) 
end

function Field_103:OnSensorLeave_env_bolrac(pActor)

	gamefunc:ChangeCurrentWeather( )
end



