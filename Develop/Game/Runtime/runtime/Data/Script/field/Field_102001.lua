

	-- pvp zone
function Field_102001:OnSensorEnter_battlefield(Actor)
	gamefunc:ChangeCustomWeather("battlefield",5)
end

function Field_102001:OnSensorLeave_battlefield(pActor)

	gamefunc:ChangeCurrentWeather( )
end

