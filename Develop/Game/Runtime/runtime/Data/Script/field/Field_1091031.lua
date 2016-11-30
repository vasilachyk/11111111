

function Field_1091031:OnSensorEnter_out(Actor)

	gamefunc:ChangeCustomWeather("out", 0) 
end

function Field_1091031:OnSensorLeave_out(pActor)

	gamefunc:ChangeCurrentWeather( )
end



