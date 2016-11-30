

function Field_508001:OnSensorEnter_renas(Actor)

	gamefunc:ChangeCustomWeather("renas", 0) 
end

function Field_508001:OnSensorLeave_renas(pActor)

	gamefunc:ChangeCurrentWeather( )
end


function Field_508001:OnSensorEnter_veinus(Actor)

	gamefunc:ChangeCustomWeather("veinus", 0) 
end

function Field_508001:OnSensorLeave_veinus(pActor)

	gamefunc:ChangeCurrentWeather( )
end




