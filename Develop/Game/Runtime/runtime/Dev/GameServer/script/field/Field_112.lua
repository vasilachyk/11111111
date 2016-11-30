--[[
	f0112.lua
	
	Forest of Silent
	Script by arkiya
]]--

-- Portal to Swamp of the Silence
function Field_112:OnSensorEnter_1(Actor)	
	-- Go to "Swamp of the Silence"
	AsPlayer(Actor):GateToMarker(103, 2);
end
