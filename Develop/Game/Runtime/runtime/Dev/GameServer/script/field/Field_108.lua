--[[
	f0108.lua
	
	Icevale
	Script by Joongpil Cho(Venister)
]]--

-- Portal to Teress
function Field_108:OnSensorEnter_3(Actor)
	AsPlayer(Actor):GateToMarker(107, 4);
end
