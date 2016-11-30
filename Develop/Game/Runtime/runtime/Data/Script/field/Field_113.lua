function Field_113:OnSensorEnter_3(Actor)
	local sz = string.format("Field_113:OnSensorEnter_3()")
	gamedebug:Log(sz)
	gamefunc:ChangeCustomWeather("swamp", 2)
end

function Field_113:OnSensorLeave_3(pActor)

	gamefunc:ChangeCurrentWeather()
end

function Field_113:OnSensorEnter_1000012(pActor)
	gamefunc:HelpTrigger(12);		-- 레이드 던전 입장 설명
end