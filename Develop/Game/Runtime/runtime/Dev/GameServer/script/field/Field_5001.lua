function Field_5001:OnSensorEnter_1(Actor)
	local Player = AsPlayer(Actor);
	Player:UpdateQuestVar(5000040, 1);
	Player:Gate(5000, vec3(14000, 4700, 0));
end