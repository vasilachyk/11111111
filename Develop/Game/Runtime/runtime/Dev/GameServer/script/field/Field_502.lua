--[[
	f0502.lua
	
	Forest of Mirage
	Script by arkiya
]]--

-- Portal to Mt. Eda
function Field_502:OnSensorEnter_1(Actor)
	-- Go to "Mt. Eda"
	AsPlayer(Actor):GateToMarker(102, 2);
end