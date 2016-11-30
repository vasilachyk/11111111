--[[
	Tray main LUA script
--]]


-- Tray window
g_TraySelWindow = nil;





-- OnTrayPopupMenu
function OnTrayPopupMenu( _wnd)

	g_TraySelWindow = _wnd;
	g_TraySelWindow:TrackPopupMenu( "pmTrayPopupMenu");
end





-- OnTrayBindScript
function OnTrayBindScript( _instance)

	if ( g_TraySelWindow ~= nil)  then  g_TraySelWindow:BindScriptInstance( _instance);
	end
	
	g_TraySelWindow = nil;
end