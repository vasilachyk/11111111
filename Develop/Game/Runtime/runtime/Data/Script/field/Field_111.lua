function Field_111:OnSensorEnter_sorena(Actor)

	gamefunc:ChangeCustomTimeWeather("sorena", 0, 0)
end

function Field_111:OnSensorLeave_sorena(pActor)

	gamefunc:ChangeCurrentWeather( )
end



function Field_111:OnSensorEnter_boss(Actor)

	gamefunc:ChangeCustomTimeWeather("boss", 0, 0)
end

function Field_111:OnSensorLeave_boss(pActor)

	gamefunc:ChangeCurrentWeather( )
end


function Field_111:OnSensorEnter_temple(Actor)

	gamefunc:ChangeCustomTimeWeather("temple", 0, 0)
end

function Field_111:OnSensorLeave_temple(pActor)

	gamefunc:ChangeCurrentWeather( )
end


function Field_111:OnSensorEnter_totem(Actor)

	gamefunc:ChangeCustomWeather("totem", 0)
end

function Field_111:OnSensorLeave_totem(pActor)

	gamefunc:ChangeCurrentWeather( )
end