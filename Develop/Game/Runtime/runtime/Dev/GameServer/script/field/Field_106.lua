--[[
	f0106.lua
	
	The Forgotten Remains (잊혀진 성지)
	Script by Joongpil Cho(Venister)
]]--

--[[ --------------------------------------------------------------------------------------------------------------------------
	PORTAL
-------------------------------------------------------------------------------------------------------------------------- ]]--

-- Portal to Limos Desert
function Field_106:OnSensorEnter_1(Actor)
	AsPlayer(Actor):GateToMarker(105, 1);
end
