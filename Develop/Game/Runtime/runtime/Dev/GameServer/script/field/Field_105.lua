--[[
	f0105.lua
	
	Limos Desert
	Script by Joongpil Cho(Venister)
]]--

--[[ --------------------------------------------------------------------------------------------------------------------------
	PORTAL
-------------------------------------------------------------------------------------------------------------------------- ]]--

-- Portal to The Forgotten Remains
function Field_105:OnSensorEnter_1(Actor)
	AsPlayer(Actor):GateToMarker(106, 1);
end

-- Portal to Linden Hills
function Field_105:OnSensorEnter_2(Actor)
	AsPlayer(Actor):GateToMarker(104, 2);
end
