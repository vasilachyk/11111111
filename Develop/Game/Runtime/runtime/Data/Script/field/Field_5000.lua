function Field_5000:OnSensorEnter_4(pActor)
	local sz = string.format("Field_5000:OnSensorEnter_4()")
	shDebug:Log(sz)
	
	shGame:ChangeWeather(5)
end

function Field_5000:OnSensorLeave_4(pActor)
	local sz = string.format("Field_5000:OnSensorLeave_4()")
	shDebug:Log(sz)

	shGame:ChangeWeather(0)
end